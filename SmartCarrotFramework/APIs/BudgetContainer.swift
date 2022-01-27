//
//  BudgetContainer.swift
//  SmartCarrotFramework
//
//  Copyright © 2020 CarrotLabs gmbh. All rights reserved.
//

import Foundation

internal class BudgetContainer {
    internal var budget: Budget
    internal var runningTotal: Decimal
    
    init(budget: Budget, runningTotal: Decimal) {
        self.budget = budget
        self.runningTotal = 0
        
        validateAndPostBudgetOverspent(newRunningTotal: runningTotal)
    }

    internal func validateAndPostBudgetOverspent(newRunningTotal: Decimal) {
        if runningTotal != newRunningTotal {
            runningTotal = newRunningTotal
            
            if runningTotal > budget.budgeted {
                NotificationCenter.default.post(name: .budgetDidOverSpend, object: self.budget)
            } else if runningTotal > budget.alert {
                NotificationCenter.default.post(name: .budgetDidAlert, object: self.budget)
            }
        }
    }
}
