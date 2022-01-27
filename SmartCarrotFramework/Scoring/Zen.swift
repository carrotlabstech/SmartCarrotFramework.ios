//
//  Zen.swift
//  SmartCarrotFramework
//
//  Copyright © 2020 CarrotLabs gmbh. All rights reserved.
//

import Foundation

internal class Zen {
    private let _budgets: [Budget]
    private let _transactions: [Transaction]
    private var _startDaySince1970: Int
    private let _endDaySince1970: Int
    
    internal init(transactions: [Transaction], budgets: [Budget]) {
        self._transactions = transactions
        self._budgets = budgets
        
        let startTx = _transactions
            .map { $0.bookingDate }
            .reduce(Date(timeIntervalSinceNow: 3 *  365 * 24 * 3600), { min($0, $1) })
        _startDaySince1970 = ZenUtils.daySince1970(date: startTx)

        let endTx = _transactions
            .map { $0.bookingDate }
            .reduce(Date(timeIntervalSince1970: 0), { max($0, $1) })
        _endDaySince1970 = ZenUtils.daySince1970(date: endTx)
        
        if _endDaySince1970 - _startDaySince1970 > ZenParams.MAX_INTERVAL {
            _startDaySince1970 = _endDaySince1970 - ZenParams.MAX_INTERVAL
        }
    }
    
    internal func build() -> [ZenScore] {
        if _transactions.count == 0 {
            return [ZenScore]()
        }
        
        if _transactions.count == 1 {
            return [ZenScore(DaySince1970: ZenUtils.daySince1970(date: _transactions[0].bookingDate), Score: 0)]
        }
        
        let outputFrame = buildOutputFrame()
        let incomeVector = buildIncomeVector()
        return buildZen(outputFrame: outputFrame, incomeVector: incomeVector)
    }
    
    internal func buildZen(outputFrame: [ZenItem], incomeVector: [Decimal]) -> [ZenScore] {
        let months = ZenUtils.monthSince1970(daySince1970: _endDaySince1970) - ZenUtils.monthSince1970(daySince1970: _startDaySince1970)
        
        var averageMonthlyIncome = incomeVector.reduce(0, +) / Decimal(months)
        averageMonthlyIncome = max(averageMonthlyIncome, ZenParams.minSalary)
        
        let budgetsMax = _budgets
            .map { monthlyBudgeted(budget: $0) / averageMonthlyIncome - ZenParams.getStrike(categoryId: $0.categoryId) }
            .map { max($0, 0) }
        
        // sum ( budgetsMax.elementN * budgetWeights.elementN)
        let P:Decimal = zip(budgetsMax, budgetWeights()).map(*).reduce(0, +)
        let f_P = Decimal(1) - Decimal(0.5) * (Decimal(1) - Decimal(exp(-ZenParams.delta.doubleValue * P.doubleValue)))
        
        let RawSpendingScore = outputFrame.map { $0.UnbudgetedSpendingFactor * $0.DailyUtilizationScore * f_P }
        
        let m = (ZenParams.finalValue - ZenParams.lambda)/(Decimal(1) - ZenParams.kickInPoint)
        let b = (ZenParams.lambda - ZenParams.finalValue)/(Decimal(1) - ZenParams.kickInPoint) + ZenParams.finalValue
        
        var zenScores = [ZenScore]()
        zenScores.append(ZenScore(DaySince1970: _startDaySince1970, Score: 0))
        
        for day in 1...RawSpendingScore.count - 1 {
            zenScores.append(ZenScore(DaySince1970: day + _startDaySince1970, Score: 0))
            
            if RawSpendingScore[day] >= zenScores[day - 1].Score {
                zenScores[day].Score = ZenParams.lambda * zenScores[day-1].Score + (1-ZenParams.lambda) * RawSpendingScore[day]
            } else {
                let penaltyFactor = m * zenScores[day - 1].Score + b
                zenScores[day].Score = penaltyFactor * zenScores[day-1].Score + (1-penaltyFactor) * RawSpendingScore[day]
            }
        }
        
        return zenScores
    }
    
    internal func buildOutputFrame() -> [ZenItem] {
        let spendingMatrix = buildSpendingMatrix()
        let unbudgetedSpendingVector = buildUnbudgetedSpendingVector()
        let utilisationMatrix = buildUtilisationMatrix(spendingMatrix: spendingMatrix)
        let averageUtilisationAggregated = buildUtilisationMatrixWithBudgetWeights(utilisaitonMatrix: utilisationMatrix)
        
        var outputFrame = [ZenItem]()
        for daySince1970 in 0...averageUtilisationAggregated.count - 1 {
            let rawUtilisatinScore = ZenUtils.r(x: averageUtilisationAggregated[daySince1970], alpha: ZenParams.alpha, beta: ZenParams.beta, gamma: ZenParams.gamma)
            
            let rowSum:Decimal = spendingMatrix[daySince1970].reduce(0, +)
            var unbudgetedSpendingFactor:Decimal = rowSum + unbudgetedSpendingVector[daySince1970]
            unbudgetedSpendingFactor = unbudgetedSpendingFactor == 0 ? 1 : rowSum / unbudgetedSpendingFactor
            
            let zenScoreItem = ZenItem(DateSince1970: daySince1970 + _startDaySince1970,
                                       AverageUtilisation: averageUtilisationAggregated[daySince1970],
                                       RawUtilisatinScore: rawUtilisatinScore,
                                       DailyUtilizationScore: ZenUtils.sigmoid(x: rawUtilisatinScore),
                                       UnbudgetedSpendingFactor: unbudgetedSpendingFactor,
                                       TotalSpending: rowSum + unbudgetedSpendingVector[daySince1970])
            
            outputFrame.append(zenScoreItem)
        }

        return outputFrame
    }
    
    internal func buildUtilisationMatrixWithBudgetWeights(utilisaitonMatrix: [[Decimal]]) -> [Decimal] {
        let budgetWeigts = budgetWeights()
        
        var averageUtilisationMatrix = utilisaitonMatrix
        
        // from other calculations we assume that utilisationMatrix has Budgets.count columns
        for i in 0...averageUtilisationMatrix.count - 1 {
            for j in 0...averageUtilisationMatrix[i].count - 1 {
                averageUtilisationMatrix[i][j] = averageUtilisationMatrix[i][j] * budgetWeigts[j]
            }
        }
        
        return averageUtilisationMatrix.map { $0.reduce(0, +) }
    }
    
    private func budgetWeights() -> [Decimal] {
        let budgetWeigts = _budgets.map { monthlyBudgeted(budget: $0) }
        let budgetSum = budgetWeigts.reduce(0, +)
        return budgetWeigts.map { $0/budgetSum }
    }
    
    private func monthlyBudgeted(budget: Budget) -> Decimal {
        return budget.frequencyType == BudgetFrequency.monthly ? budget.budgeted : budget.budgeted / Decimal(12)
    }
    
    internal func buildUtilisationMatrix(spendingMatrix: [[Decimal]]) -> [[Decimal]] {
        var utilisationMatrix = [[Decimal]]()
        var monthSince1970 = ZenUtils.monthSince1970(daySince1970: _startDaySince1970)
        
        // cumulative per day within a month (within a budget)
        // unlist(cumsum( LMatrix[wRow,iCol] )
        for currentDay in 0...(_endDaySince1970 - _startDaySince1970) {
            utilisationMatrix.append(spendingMatrix[currentDay])
            let currentMonthSince1970 = ZenUtils.monthSince1970(daySince1970: currentDay + _startDaySince1970)
            
            if currentDay > 0 && currentMonthSince1970 == monthSince1970 {
                for bugetCategoryNo in 0...spendingMatrix[currentDay].count - 1 {
                    utilisationMatrix[currentDay][bugetCategoryNo] = utilisationMatrix[currentDay - 1][bugetCategoryNo] + utilisationMatrix[currentDay][bugetCategoryNo]
                }
            }
            
            monthSince1970 = currentMonthSince1970
        }
        
        // multiply by (count_days / current_day)
        // divide by budget's monthly budgeted
        // LMatrix <- LMatrix / xBudget
        for currentDay in 0...(_endDaySince1970 - _startDaySince1970) {
            let currentMonthSince1970 = ZenUtils.monthSince1970(daySince1970: currentDay + _startDaySince1970)
            
            for bugetCategoryNo in 0...spendingMatrix[currentDay].count - 1 {
                utilisationMatrix[currentDay][bugetCategoryNo] =
                    utilisationMatrix[currentDay][bugetCategoryNo] * Decimal(ZenUtils.daysPerMonth(monthSince1970: currentMonthSince1970)) / Decimal(ZenUtils.dayOfMonth(daySince1970: currentDay + _startDaySince1970))
                
                
                var budgetMonthlyBudgeted: Decimal = _budgets[bugetCategoryNo].budgeted
                if _budgets[bugetCategoryNo].frequencyType == BudgetFrequency.annual {
                    budgetMonthlyBudgeted = budgetMonthlyBudgeted / 12
                }

                // This part should be commented to test UtilisationMatrixMid
                utilisationMatrix[currentDay][bugetCategoryNo] = utilisationMatrix[currentDay][bugetCategoryNo] * (Decimal(1) / budgetMonthlyBudgeted)
            }
        }
        
        return utilisationMatrix
    }
    
    internal func buildSpendingMatrix() -> [[Decimal]] {
        var spendingMatrix = [[Decimal]]()
        
        for daySince1970 in _startDaySince1970..._endDaySince1970 {
            var spendingRow = [Decimal](repeating: 0, count: _budgets.count)
            
            for i in 0..._budgets.count - 1 {
                spendingRow[i] = abs(_transactions
                    .filter { $0.categoryId != nil &&
                            $0.categoryId == _budgets[i].categoryId
                            && ZenUtils.daySince1970(date: $0.bookingDate) == daySince1970 }
                    .reduce(0, { $0 + $1.amount }))
            }
            
            spendingMatrix.append(spendingRow)
        }
        
        return spendingMatrix
    }
    
    internal func buildIncomeVector() -> [Decimal] {
        var income = [Decimal](repeating: 0, count: _endDaySince1970 - _startDaySince1970 + 1)
        
        for daySince1970 in _startDaySince1970..._endDaySince1970 {
            income[daySince1970 - _startDaySince1970] = _transactions
                .filter { $0.amount > 0 }
                .reduce(0, { $0 + $1.amount })
        }
        
        return income
    }
    
    internal func buildUnbudgetedSpendingVector() -> [Decimal] {
        var unspent = [Decimal](repeating: 0, count: _endDaySince1970 - _startDaySince1970 + 1)
        
        for daySince1970 in _startDaySince1970..._endDaySince1970 {
            unspent[daySince1970 - _startDaySince1970] = abs(_transactions
                    .filter { $0.amount < 0 &&
                                ZenUtils.daySince1970(date: $0.bookingDate) == daySince1970 &&
                                !ZenUtils.budgetsIncludeCategory(budgets: _budgets, categoryId: $0.categoryId)  }
                    .reduce(0, { $0 + $1.amount }))
        }
        
        return unspent
    }
}

internal struct ZenItem : Equatable {
    static var _eps: Decimal = 0.0001
    
    internal var DateSince1970: Int
    internal var AverageUtilisation: Decimal
    internal var RawUtilisatinScore: Decimal
    internal var DailyUtilizationScore: Decimal
    internal var UnbudgetedSpendingFactor: Decimal
    internal var TotalSpending: Decimal
    internal var ZenScore: Decimal = 0
    
    static func == (lhs: ZenItem, rhs: ZenItem) -> Bool {
        return
            lhs.DateSince1970 == rhs.DateSince1970 &&
            abs(lhs.AverageUtilisation - rhs.AverageUtilisation) < ZenItem._eps &&
            abs(lhs.RawUtilisatinScore - rhs.RawUtilisatinScore) < ZenItem._eps &&
            abs(lhs.DailyUtilizationScore - rhs.DailyUtilizationScore) < ZenItem._eps &&
            abs(lhs.UnbudgetedSpendingFactor - rhs.UnbudgetedSpendingFactor) < ZenItem._eps &&
            abs(lhs.TotalSpending - rhs.TotalSpending) < ZenItem._eps &&
            abs(lhs.ZenScore - rhs.ZenScore) < ZenItem._eps
    }
}

/**
 Zen Score. Represents user's financial health for a given date.
 */
public struct ZenScore {
    /**
     Date (day)
     */
    public var Date: Date {
        get {
            return ZenUtils.date(daySince1970: DaySince1970)
        }
    }
    
    internal var DaySince1970: Int
    
    /**
     Score. Falls in range (0; 1). The higher the score is the better user's financial health on the given day.
     */
    public var Score: Decimal
}
