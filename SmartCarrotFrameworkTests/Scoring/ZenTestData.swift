//
//  ZenTestData.swift
//  SmartCarrotFrameworkTests
//
//  Copyright © 2020 CarrotLabs gmbh. All rights reserved.
//

import Foundation
@testable import SmartCarrotFramework

internal struct ZenTestData {
    var Budgets = [Budget]()
    var Transactions = [Transaction]()
    var ZenItemsMid = [ZenItem]()
    var ZenItemsFull = [ZenItem]()
    
    var startDateSince1970: Int
    var endDateSince1970: Int
    
    var SpendingMatrix: [[Decimal]]
    var UtilisationMatrix: [[Decimal]]
    var UtilisationMatrixMid: [[Decimal]]
    
    init() {
        // MARK: - Budgets
        Budgets.append(Budget(id: UUID().uuidString,
            externalId: "1",
            name: "online_shopping",
            budgeted: 200,
            alert: 80,
            categoryId: TransactionCategory("online_shopping").getIntId(),
            frequencyType: BudgetFrequency.monthly))
        Budgets.append(Budget(id: UUID().uuidString,
            externalId: "2",
            name: "bars",
            budgeted: 100,
            alert: 80,
            categoryId: TransactionCategory("bars").getIntId(),
            frequencyType: BudgetFrequency.monthly))
        Budgets.append(Budget(id: UUID().uuidString,
            externalId: "3",
            name: "fastfood",
            budgeted: 100,
            alert: 80,
            categoryId: TransactionCategory("fastfood").getIntId(),
            frequencyType: BudgetFrequency.monthly))
        Budgets.append(Budget(id: UUID().uuidString,
            externalId: "4",
            name: "electronics",
            budgeted: 4000,
            alert: 80,
            categoryId: TransactionCategory("electronics").getIntId(),
            frequencyType: .annual))
        
        let transactionData = [
              TestTransactionR(
                  Date: "2018-12-04 00:00:00",
                  Category: "presents",
                  Amount: -1200
              ),
              TestTransactionR(
                  Date: "2018-12-24 00:00:00",
                  Category: "income",
                  Amount: 6768
              ),
              TestTransactionR(
                  Date: "2018-09-25 00:00:00",
                  Category: "bars",
                  Amount: -5.4
              ),
              TestTransactionR(
                  Date: "2018-09-25 00:00:00",
                  Category: "bars",
                  Amount: -15.7
              ),
              TestTransactionR(
                  Date: "2018-09-25 00:00:00",
                  Category: "furniture",
                  Amount: -83.9
              ),
              TestTransactionR(
                  Date: "2018-09-26 00:00:00",
                  Category: "income",
                  Amount: 10521.1
              ),
              TestTransactionR(
                  Date: "2018-09-27 00:00:00",
                  Category: "bankfees",
                  Amount: -45
              ),
              TestTransactionR(
                  Date: "2018-09-27 00:00:00",
                  Category: "save_invest",
                  Amount: -1500
              ),
              TestTransactionR(
                  Date: "2018-09-27 00:00:00",
                  Category: "household",
                  Amount: -6500
              ),
              TestTransactionR(
                  Date: "2018-10-01 00:00:00",
                  Category: "gas",
                  Amount: -108.75
              ),
              TestTransactionR(
                  Date: "2018-10-02 00:00:00",
                  Category: "vacations",
                  Amount: -22.5
              ),
              TestTransactionR(
                  Date: "2018-10-02 00:00:00",
                  Category: "presents",
                  Amount: -152
              ),
              TestTransactionR(
                  Date: "2018-10-02 00:00:00",
                  Category: "cash",
                  Amount: -400
              ),
              TestTransactionR(
                  Date: "2018-10-03 00:00:00",
                  Category: "public_transport",
                  Amount: -12
              ),
              TestTransactionR(
                  Date: "2018-10-03 00:00:00",
                  Category: "restaurants",
                  Amount: -79.8
              ),
              TestTransactionR(
                  Date: "2018-10-04 00:00:00",
                  Category: "groceries",
                  Amount: -10.5
              ),
              TestTransactionR(
                  Date: "2018-10-04 00:00:00",
                  Category: "public_transport",
                  Amount: -12
              ),
              TestTransactionR(
                  Date: "2018-10-04 00:00:00",
                  Category: "hotel",
                  Amount: -159.8
              ),
              TestTransactionR(
                  Date: "2018-10-05 00:00:00",
                  Category: "restaurants",
                  Amount: -215.7
              ),
              TestTransactionR(
                  Date: "2018-10-08 00:00:00",
                  Category: "groceries",
                  Amount: -6
              ),
              TestTransactionR(
                  Date: "2018-10-08 00:00:00",
                  Category: "public_transport",
                  Amount: -30
              ),
              TestTransactionR(
                  Date: "2018-10-08 00:00:00",
                  Category: "restaurants",
                  Amount: -85.1
              ),
              TestTransactionR(
                  Date: "2018-10-08 00:00:00",
                  Category: "cash",
                  Amount: -200
              ),
              TestTransactionR(
                  Date: "2018-10-08 00:00:00",
                  Category: "car_service",
                  Amount: -356.7
              ),
              TestTransactionR(
                  Date: "2018-10-09 00:00:00",
                  Category: "bars",
                  Amount: -3.6
              ),
              TestTransactionR(
                  Date: "2018-10-09 00:00:00",
                  Category: "bars",
                  Amount: -5.4
              ),
              TestTransactionR(
                  Date: "2018-10-09 00:00:00",
                  Category: "bars",
                  Amount: -7.2
              ),
              TestTransactionR(
                  Date: "2018-10-09 00:00:00",
                  Category: "groceries",
                  Amount: -50
              ),
              TestTransactionR(
                  Date: "2018-10-09 00:00:00",
                  Category: "restaurants",
                  Amount: -60
              ),
              TestTransactionR(
                  Date: "2018-10-09 00:00:00",
                  Category: "creditcard_payment",
                  Amount: -629.85
              ),
              TestTransactionR(
                  Date: "2018-10-10 00:00:00",
                  Category: "bars",
                  Amount: -5.7
              ),
              TestTransactionR(
                  Date: "2018-10-10 00:00:00",
                  Category: "groceries",
                  Amount: -5.7
              ),
              TestTransactionR(
                  Date: "2018-10-10 00:00:00",
                  Category: "bars",
                  Amount: -10.3
              ),
              TestTransactionR(
                  Date: "2018-10-10 00:00:00",
                  Category: "groceries",
                  Amount: -14.55
              ),
              TestTransactionR(
                  Date: "2018-10-11 00:00:00",
                  Category: "bars",
                  Amount: -7.2
              ),
              TestTransactionR(
                  Date: "2018-10-11 00:00:00",
                  Category: "bars",
                  Amount: -11.8
              ),
              TestTransactionR(
                  Date: "2018-10-12 00:00:00",
                  Category: "leisure_shopping",
                  Amount: -8.6
              ),
              TestTransactionR(
                  Date: "2018-10-12 00:00:00",
                  Category: "cash",
                  Amount: -354
              ),
              TestTransactionR(
                  Date: "2018-10-15 00:00:00",
                  Category: "restaurants",
                  Amount: -13
              ),
              TestTransactionR(
                  Date: "2018-10-15 00:00:00",
                  Category: "groceries",
                  Amount: -21.65
              ),
              TestTransactionR(
                  Date: "2018-10-15 00:00:00",
                  Category: "public_transport",
                  Amount: -103
              ),
              TestTransactionR(
                  Date: "2018-10-16 00:00:00",
                  Category: "groceries",
                  Amount: -8.6
              ),
              TestTransactionR(
                  Date: "2018-10-16 00:00:00",
                  Category: "bars",
                  Amount: -9.4
              ),
              TestTransactionR(
                  Date: "2018-10-16 00:00:00",
                  Category: "bars",
                  Amount: -12
              ),
              TestTransactionR(
                  Date: "2018-10-17 00:00:00",
                  Category: "bars",
                  Amount: -3.95
              ),
              TestTransactionR(
                  Date: "2018-10-17 00:00:00",
                  Category: "bars",
                  Amount: -5.1
              ),
              TestTransactionR(
                  Date: "2018-10-17 00:00:00",
                  Category: "groceries",
                  Amount: -11.1
              ),
              TestTransactionR(
                  Date: "2018-10-18 00:00:00",
                  Category: "groceries",
                  Amount: -36.95
              ),
              TestTransactionR(
                  Date: "2018-10-19 00:00:00",
                  Category: "bars",
                  Amount: -3.2
              ),
              TestTransactionR(
                  Date: "2018-10-19 00:00:00",
                  Category: "bars",
                  Amount: -9.1
              ),
              TestTransactionR(
                  Date: "2018-10-19 00:00:00",
                  Category: "bars",
                  Amount: -11.6
              ),
              TestTransactionR(
                  Date: "2018-10-19 00:00:00",
                  Category: "groceries",
                  Amount: -16.2
              ),
              TestTransactionR(
                  Date: "2018-10-19 00:00:00",
                  Category: "cash",
                  Amount: -200
              ),
              TestTransactionR(
                  Date: "2018-10-22 00:00:00",
                  Category: "groceries",
                  Amount: -29
              ),
              TestTransactionR(
                  Date: "2018-10-22 00:00:00",
                  Category: "bars",
                  Amount: -46.7
              ),
              TestTransactionR(
                  Date: "2018-10-22 00:00:00",
                  Category: "groceries",
                  Amount: -59.95
              ),
              TestTransactionR(
                  Date: "2018-10-22 00:00:00",
                  Category: "cash",
                  Amount: -300
              ),
              TestTransactionR(
                  Date: "2018-10-23 00:00:00",
                  Category: "bars",
                  Amount: -9.5
              ),
              TestTransactionR(
                  Date: "2018-10-23 00:00:00",
                  Category: "bars",
                  Amount: -13.5
              ),
              TestTransactionR(
                  Date: "2018-10-23 00:00:00",
                  Category: "restaurants",
                  Amount: -73.5
              ),
              TestTransactionR(
                  Date: "2018-10-23 00:00:00",
                  Category: "cash",
                  Amount: -300
              ),
              TestTransactionR(
                  Date: "2018-10-24 00:00:00",
                  Category: "bars",
                  Amount: -3.4
              ),
              TestTransactionR(
                  Date: "2018-10-24 00:00:00",
                  Category: "groceries",
                  Amount: -22.4
              ),
              TestTransactionR(
                  Date: "2018-10-25 00:00:00",
                  Category: "bars",
                  Amount: -7.5
              ),
              TestTransactionR(
                  Date: "2018-10-25 00:00:00",
                  Category: "bars",
                  Amount: -15.8
              ),
              TestTransactionR(
                  Date: "2018-10-26 00:00:00",
                  Category: "save_invest",
                  Amount: -1500
              ),
              TestTransactionR(
                  Date: "2018-10-26 00:00:00",
                  Category: "household",
                  Amount: -6500
              ),
              TestTransactionR(
                  Date: "2018-10-26 00:00:00",
                  Category: "income",
                  Amount: 10478.9
              ),
              TestTransactionR(
                  Date: "2018-10-29 00:00:00",
                  Category: "groceries",
                  Amount: -27.95
              ),
              TestTransactionR(
                  Date: "2018-10-29 00:00:00",
                  Category: "office",
                  Amount: -1990
              ),
              TestTransactionR(
                  Date: "2018-10-30 00:00:00",
                  Category: "bars",
                  Amount: -3.6
              ),
              TestTransactionR(
                  Date: "2018-10-30 00:00:00",
                  Category: "bars",
                  Amount: -3.8
              ),
              TestTransactionR(
                  Date: "2018-10-30 00:00:00",
                  Category: "shoes",
                  Amount: -106.9
              ),
              TestTransactionR(
                  Date: "2018-10-31 00:00:00",
                  Category: "bars",
                  Amount: -0.65
              ),
              TestTransactionR(
                  Date: "2018-10-31 00:00:00",
                  Category: "restaurants",
                  Amount: -3.5
              ),
              TestTransactionR(
                  Date: "2018-10-31 00:00:00",
                  Category: "groceries",
                  Amount: -5.7
              ),
              TestTransactionR(
                  Date: "2018-10-31 00:00:00",
                  Category: "bars",
                  Amount: -5.7
              ),
              TestTransactionR(
                  Date: "2018-10-31 00:00:00",
                  Category: "groceries",
                  Amount: -7.6
              ),
              TestTransactionR(
                  Date: "2018-10-31 00:00:00",
                  Category: "pharmacy",
                  Amount: -46.6
              ),
              TestTransactionR(
                  Date: "2018-11-01 00:00:00",
                  Category: "bars",
                  Amount: -7.2
              ),
              TestTransactionR(
                  Date: "2018-11-01 00:00:00",
                  Category: "bars",
                  Amount: -10.95
              ),
              TestTransactionR(
                  Date: "2018-11-01 00:00:00",
                  Category: "groceries",
                  Amount: -12.35
              ),
              TestTransactionR(
                  Date: "2018-11-02 00:00:00",
                  Category: "restaurants",
                  Amount: -37.8
              ),
              TestTransactionR(
                  Date: "2018-11-02 00:00:00",
                  Category: "presents",
                  Amount: -152
              ),
              TestTransactionR(
                  Date: "2018-11-05 00:00:00",
                  Category: "vacations",
                  Amount: -54
              ),
              TestTransactionR(
                  Date: "2018-11-05 00:00:00",
                  Category: "leisure_shopping",
                  Amount: -70
              ),
              TestTransactionR(
                  Date: "2018-11-06 00:00:00",
                  Category: "bars",
                  Amount: -5.4
              ),
              TestTransactionR(
                  Date: "2018-11-06 00:00:00",
                  Category: "bars",
                  Amount: -7.6
              ),
              TestTransactionR(
                  Date: "2018-11-06 00:00:00",
                  Category: "massage",
                  Amount: -8
              ),
              TestTransactionR(
                  Date: "2018-11-06 00:00:00",
                  Category: "bars",
                  Amount: -8.6
              ),
              TestTransactionR(
                  Date: "2018-11-06 00:00:00",
                  Category: "restaurants",
                  Amount: -19.45
              ),
              TestTransactionR(
                  Date: "2018-11-06 00:00:00",
                  Category: "gas",
                  Amount: -114.4
              ),
              TestTransactionR(
                  Date: "2018-11-07 00:00:00",
                  Category: "groceries",
                  Amount: -5.7
              ),
              TestTransactionR(
                  Date: "2018-11-07 00:00:00",
                  Category: "bars",
                  Amount: -7.2
              ),
              TestTransactionR(
                  Date: "2018-11-07 00:00:00",
                  Category: "groceries",
                  Amount: -8.6
              ),
              TestTransactionR(
                  Date: "2018-11-07 00:00:00",
                  Category: "groceries",
                  Amount: -12.4
              ),
              TestTransactionR(
                  Date: "2018-11-07 00:00:00",
                  Category: "groceries",
                  Amount: -50
              ),
              TestTransactionR(
                  Date: "2018-11-08 00:00:00",
                  Category: "bars",
                  Amount: -5.4
              ),
              TestTransactionR(
                  Date: "2018-11-08 00:00:00",
                  Category: "bars",
                  Amount: -5.65
              ),
              TestTransactionR(
                  Date: "2018-11-08 00:00:00",
                  Category: "bars",
                  Amount: -17.3
              ),
              TestTransactionR(
                  Date: "2018-11-08 00:00:00",
                  Category: "creditcard_payment",
                  Amount: -878.55
              ),
              TestTransactionR(
                  Date: "2018-11-09 00:00:00",
                  Category: "bars",
                  Amount: -9.4
              ),
              TestTransactionR(
                  Date: "2018-11-09 00:00:00",
                  Category: "bars",
                  Amount: -15.4
              ),
              TestTransactionR(
                  Date: "2018-11-12 00:00:00",
                  Category: "bars",
                  Amount: -1.7
              ),
              TestTransactionR(
                  Date: "2018-11-12 00:00:00",
                  Category: "groceries",
                  Amount: -4
              ),
              TestTransactionR(
                  Date: "2018-11-12 00:00:00",
                  Category: "bars",
                  Amount: -7.6
              ),
              TestTransactionR(
                  Date: "2018-11-12 00:00:00",
                  Category: "bars",
                  Amount: -8.6
              ),
              TestTransactionR(
                  Date: "2018-11-12 00:00:00",
                  Category: "bars",
                  Amount: -10.35
              ),
              TestTransactionR(
                  Date: "2018-11-12 00:00:00",
                  Category: "groceries",
                  Amount: -12.6
              ),
              TestTransactionR(
                  Date: "2018-11-12 00:00:00",
                  Category: "groceries",
                  Amount: -29.1
              ),
              TestTransactionR(
                  Date: "2018-11-12 00:00:00",
                  Category: "renovation",
                  Amount: -38.5
              ),
              TestTransactionR(
                  Date: "2018-11-13 00:00:00",
                  Category: "bars",
                  Amount: -5.6
              ),
              TestTransactionR(
                  Date: "2018-11-13 00:00:00",
                  Category: "groceries",
                  Amount: -7.2
              ),
              TestTransactionR(
                  Date: "2018-11-13 00:00:00",
                  Category: "bars",
                  Amount: -10.6
              ),
              TestTransactionR(
                  Date: "2018-11-13 00:00:00",
                  Category: "bars",
                  Amount: -13.8
              ),
              TestTransactionR(
                  Date: "2018-11-19 00:00:00",
                  Category: "massage",
                  Amount: -14.4
              ),
              TestTransactionR(
                  Date: "2018-11-19 00:00:00",
                  Category: "groceries",
                  Amount: -18.85
              ),
              TestTransactionR(
                  Date: "2018-11-19 00:00:00",
                  Category: "groceries",
                  Amount: -20.7
              ),
              TestTransactionR(
                  Date: "2018-11-19 00:00:00",
                  Category: "sport",
                  Amount: -26
              ),
              TestTransactionR(
                  Date: "2018-11-20 00:00:00",
                  Category: "bars",
                  Amount: -7.2
              ),
              TestTransactionR(
                  Date: "2018-11-20 00:00:00",
                  Category: "leisure_shopping",
                  Amount: -8.6
              ),
              TestTransactionR(
                  Date: "2018-11-20 00:00:00",
                  Category: "groceries",
                  Amount: -11.15
              ),
              TestTransactionR(
                  Date: "2018-11-20 00:00:00",
                  Category: "bars",
                  Amount: -11.4
              ),
              TestTransactionR(
                  Date: "2018-11-20 00:00:00",
                  Category: "sport",
                  Amount: -26
              ),
              TestTransactionR(
                  Date: "2018-11-21 00:00:00",
                  Category: "bars",
                  Amount: -7.2
              ),
              TestTransactionR(
                  Date: "2018-11-21 00:00:00",
                  Category: "bars",
                  Amount: -22.75
              ),
              TestTransactionR(
                  Date: "2018-11-22 00:00:00",
                  Category: "bars",
                  Amount: -7.55
              ),
              TestTransactionR(
                  Date: "2018-11-22 00:00:00",
                  Category: "bars",
                  Amount: -15.8
              ),
              TestTransactionR(
                  Date: "2018-11-22 00:00:00",
                  Category: "groceries",
                  Amount: -50
              ),
              TestTransactionR(
                  Date: "2018-11-23 00:00:00",
                  Category: "bars",
                  Amount: -7.4
              ),
              TestTransactionR(
                  Date: "2018-11-23 00:00:00",
                  Category: "groceries",
                  Amount: -9.15
              ),
              TestTransactionR(
                  Date: "2018-11-23 00:00:00",
                  Category: "bars",
                  Amount: -14.8
              ),
              TestTransactionR(
                  Date: "2018-11-26 00:00:00",
                  Category: "art",
                  Amount: -4.5
              ),
              TestTransactionR(
                  Date: "2018-11-26 00:00:00",
                  Category: "restaurants",
                  Amount: -6.5
              ),
              TestTransactionR(
                  Date: "2018-11-26 00:00:00",
                  Category: "bars",
                  Amount: -7.5
              ),
              TestTransactionR(
                  Date: "2018-11-26 00:00:00",
                  Category: "leisure_shopping",
                  Amount: -8.2
              ),
              TestTransactionR(
                  Date: "2018-11-26 00:00:00",
                  Category: "groceries",
                  Amount: -11.2
              ),
              TestTransactionR(
                  Date: "2018-11-26 00:00:00",
                  Category: "bars",
                  Amount: -14.15
              ),
              TestTransactionR(
                  Date: "2018-11-26 00:00:00",
                  Category: "groceries",
                  Amount: -39.7
              ),
              TestTransactionR(
                  Date: "2018-11-26 00:00:00",
                  Category: "income",
                  Amount: 10521.5
              ),
              TestTransactionR(
                  Date: "2018-11-27 00:00:00",
                  Category: "groceries",
                  Amount: -10.2
              ),
              TestTransactionR(
                  Date: "2018-11-27 00:00:00",
                  Category: "restaurants",
                  Amount: -53
              ),
              TestTransactionR(
                  Date: "2018-11-27 00:00:00",
                  Category: "cash",
                  Amount: -350
              ),
              TestTransactionR(
                  Date: "2018-11-27 00:00:00",
                  Category: "save_invest",
                  Amount: -1500
              ),
              TestTransactionR(
                  Date: "2018-11-27 00:00:00",
                  Category: "household",
                  Amount: -6500
              ),
              TestTransactionR(
                  Date: "2018-11-28 00:00:00",
                  Category: "bars",
                  Amount: -13.7
              ),
              TestTransactionR(
                  Date: "2018-11-29 00:00:00",
                  Category: "bars",
                  Amount: -5.7
              ),
              TestTransactionR(
                  Date: "2018-11-29 00:00:00",
                  Category: "groceries",
                  Amount: -10.9
              ),
              TestTransactionR(
                  Date: "2018-11-29 00:00:00",
                  Category: "groceries",
                  Amount: -15.8
              ),
              TestTransactionR(
                  Date: "2018-11-30 00:00:00",
                  Category: "bars",
                  Amount: -1.7
              ),
              TestTransactionR(
                  Date: "2018-11-30 00:00:00",
                  Category: "bars",
                  Amount: -3.6
              ),
              TestTransactionR(
                  Date: "2018-11-30 00:00:00",
                  Category: "groceries",
                  Amount: -8.6
              ),
              TestTransactionR(
                  Date: "2018-12-03 00:00:00",
                  Category: "presents",
                  Amount: -152
              ),
              TestTransactionR(
                  Date: "2018-12-04 00:00:00",
                  Category: "bars",
                  Amount: -3.6
              ),
              TestTransactionR(
                  Date: "2018-12-04 00:00:00",
                  Category: "groceries",
                  Amount: -3.8
              ),
              TestTransactionR(
                  Date: "2018-12-04 00:00:00",
                  Category: "bars",
                  Amount: -5.6
              ),
              TestTransactionR(
                  Date: "2018-12-04 00:00:00",
                  Category: "leisure_shopping",
                  Amount: -9.5
              ),
              TestTransactionR(
                  Date: "2018-12-04 00:00:00",
                  Category: "groceries",
                  Amount: -9.95
              ),
              TestTransactionR(
                  Date: "2018-12-04 00:00:00",
                  Category: "groceries",
                  Amount: -10.8
              ),
              TestTransactionR(
                  Date: "2018-12-04 00:00:00",
                  Category: "groceries",
                  Amount: -15.8
              ),
              TestTransactionR(
                  Date: "2018-12-04 00:00:00",
                  Category: "leisure_shopping",
                  Amount: -23.2
              ),
              TestTransactionR(
                  Date: "2018-12-04 00:00:00",
                  Category: "presents",
                  Amount: -1300
              ),
              TestTransactionR(
                  Date: "2018-12-04 00:00:00",
                  Category: "income",
                  Amount: 1200
              ),
              TestTransactionR(
                  Date: "2018-12-05 00:00:00",
                  Category: "bars",
                  Amount: -5.6
              ),
              TestTransactionR(
                  Date: "2018-12-05 00:00:00",
                  Category: "groceries",
                  Amount: -5.7
              ),
              TestTransactionR(
                  Date: "2018-12-05 00:00:00",
                  Category: "groceries",
                  Amount: -7.2
              ),
              TestTransactionR(
                  Date: "2018-12-05 00:00:00",
                  Category: "bars",
                  Amount: -17.1
              ),
              TestTransactionR(
                  Date: "2018-12-06 00:00:00",
                  Category: "bars",
                  Amount: -5.6
              ),
              TestTransactionR(
                  Date: "2018-12-06 00:00:00",
                  Category: "bars",
                  Amount: -7.2
              ),
              TestTransactionR(
                  Date: "2018-12-06 00:00:00",
                  Category: "groceries",
                  Amount: -7.6
              ),
              TestTransactionR(
                  Date: "2018-12-06 00:00:00",
                  Category: "leisure_shopping",
                  Amount: -8.2
              ),
              TestTransactionR(
                  Date: "2018-12-06 00:00:00",
                  Category: "groceries",
                  Amount: -8.6
              ),
              TestTransactionR(
                  Date: "2018-12-07 00:00:00",
                  Category: "bars",
                  Amount: -15.8
              ),
              TestTransactionR(
                  Date: "2018-12-10 00:00:00",
                  Category: "bars",
                  Amount: -15.8
              ),
              TestTransactionR(
                  Date: "2018-12-10 00:00:00",
                  Category: "creditcard_payment",
                  Amount: -870.05
              ),
              TestTransactionR(
                  Date: "2018-12-15 00:00:00",
                  Category: "bankfees",
                  Amount: -20
              ),
              TestTransactionR(
                  Date: "2018-12-15 00:00:00",
                  Category: "bankfees",
                  Amount: -55
              ),
              TestTransactionR(
                  Date: "2018-12-18 00:00:00",
                  Category: "mobility",
                  Amount: -88.05
              ),
              TestTransactionR(
                  Date: "2018-12-20 00:00:00",
                  Category: "income",
                  Amount: 10525.2
              ),
              TestTransactionR(
                  Date: "2018-12-24 00:00:00",
                  Category: "pension",
                  Amount: -6768
              ),
              TestTransactionR(
                  Date: "2018-09-27 00:00:00",
                  Category: "income",
                  Amount: 1500
              ),
              TestTransactionR(
                  Date: "2018-10-26 00:00:00",
                  Category: "income",
                  Amount: 1500
              ),
              TestTransactionR(
                  Date: "2018-11-27 00:00:00",
                  Category: "income",
                  Amount: 1500
              ),
              TestTransactionR(
                  Date: "2018-09-26 00:00:00",
                  Category: "electronics",
                  Amount: -21.7
              ),
              TestTransactionR(
                  Date: "2018-09-26 00:00:00",
                  Category: "online_shopping",
                  Amount: -16
              ),
              TestTransactionR(
                  Date: "2018-09-26 00:00:00",
                  Category: "online_shopping",
                  Amount: -8
              ),
              TestTransactionR(
                  Date: "2018-10-02 00:00:00",
                  Category: "office",
                  Amount: -11.85
              ),
              TestTransactionR(
                  Date: "2018-10-02 00:00:00",
                  Category: "online_shopping",
                  Amount: -40.55
              ),
              TestTransactionR(
                  Date: "2018-10-03 00:00:00",
                  Category: "online_shopping",
                  Amount: -20
              ),
              TestTransactionR(
                  Date: "2018-10-05 00:00:00",
                  Category: "electronics",
                  Amount: -57
              ),
              TestTransactionR(
                  Date: "2018-10-06 00:00:00",
                  Category: "online_shopping",
                  Amount: -21.45
              ),
              TestTransactionR(
                  Date: "2018-10-08 00:00:00",
                  Category: "online_shopping",
                  Amount: -21.4
              ),
              TestTransactionR(
                  Date: "2018-10-09 00:00:00",
                  Category: "online_shopping",
                  Amount: -11.8
              ),
              TestTransactionR(
                  Date: "2018-10-11 00:00:00",
                  Category: "phone_internet",
                  Amount: -86.45
              ),
              TestTransactionR(
                  Date: "2018-10-12 00:00:00",
                  Category: "electronics",
                  Amount: -79.9
              ),
              TestTransactionR(
                  Date: "2018-10-13 00:00:00",
                  Category: "hobbies",
                  Amount: -44.2
              ),
              TestTransactionR(
                  Date: "2018-10-14 00:00:00",
                  Category: "public_transport",
                  Amount: -6.7
              ),
              TestTransactionR(
                  Date: "2018-10-14 00:00:00",
                  Category: "public_transport",
                  Amount: -6.7
              ),
              TestTransactionR(
                  Date: "2018-10-16 00:00:00",
                  Category: "online_shopping",
                  Amount: -21.5
              ),
              TestTransactionR(
                  Date: "2018-10-16 00:00:00",
                  Category: "electronics",
                  Amount: -19.9
              ),
              TestTransactionR(
                  Date: "2018-10-17 00:00:00",
                  Category: "hobbies",
                  Amount: -30.7
              ),
              TestTransactionR(
                  Date: "2018-10-19 00:00:00",
                  Category: "online_shopping",
                  Amount: -21.5
              ),
              TestTransactionR(
                  Date: "2018-10-21 00:00:00",
                  Category: "office",
                  Amount: -5.4
              ),
              TestTransactionR(
                  Date: "2018-10-21 00:00:00",
                  Category: "online_shopping",
                  Amount: -16.1
              ),
              TestTransactionR(
                  Date: "2018-10-21 00:00:00",
                  Category: "online_shopping",
                  Amount: -43
              ),
              TestTransactionR(
                  Date: "2018-10-22 00:00:00",
                  Category: "online_shopping",
                  Amount: -43.1
              ),
              TestTransactionR(
                  Date: "2018-10-24 00:00:00",
                  Category: "electronics",
                  Amount: -43
              ),
              TestTransactionR(
                  Date: "2018-10-24 00:00:00",
                  Category: "hobbies",
                  Amount: -160
              ),
              TestTransactionR(
                  Date: "2018-10-26 00:00:00",
                  Category: "leisure_shopping",
                  Amount: -52
              ),
              TestTransactionR(
                  Date: "2018-10-26 00:00:00",
                  Category: "electronics",
                  Amount: -22.5
              ),
              TestTransactionR(
                  Date: "2018-11-02 00:00:00",
                  Category: "public_transport",
                  Amount: -18.6
              ),
              TestTransactionR(
                  Date: "2018-11-02 00:00:00",
                  Category: "public_transport",
                  Amount: -13.8
              ),
              TestTransactionR(
                  Date: "2018-11-03 00:00:00",
                  Category: "office",
                  Amount: -11.85
              ),
              TestTransactionR(
                  Date: "2018-11-04 00:00:00",
                  Category: "hobbies",
                  Amount: -40.95
              ),
              TestTransactionR(
                  Date: "2018-11-09 00:00:00",
                  Category: "online_shopping",
                  Amount: -11.85
              ),
              TestTransactionR(
                  Date: "2018-11-10 00:00:00",
                  Category: "online_shopping",
                  Amount: -42.85
              ),
              TestTransactionR(
                  Date: "2018-11-10 00:00:00",
                  Category: "online_shopping",
                  Amount: -42.85
              ),
              TestTransactionR(
                  Date: "2018-11-12 00:00:00",
                  Category: "electronics",
                  Amount: -69
              ),
              TestTransactionR(
                  Date: "2018-11-14 00:00:00",
                  Category: "online_shopping",
                  Amount: -21.4
              ),
              TestTransactionR(
                  Date: "2018-11-15 00:00:00",
                  Category: "electronics",
                  Amount: -19.9
              ),
              TestTransactionR(
                  Date: "2018-11-15 00:00:00",
                  Category: "hobbies",
                  Amount: -160
              ),
              TestTransactionR(
                  Date: "2018-11-15 00:00:00",
                  Category: "online_shopping",
                  Amount: -10.65
              ),
              TestTransactionR(
                  Date: "2018-11-21 00:00:00",
                  Category: "office",
                  Amount: -5.7
              ),
              TestTransactionR(
                  Date: "2018-11-21 00:00:00",
                  Category: "online_shopping",
                  Amount: -4
              ),
              TestTransactionR(
                  Date: "2018-11-23 00:00:00",
                  Category: "online_shopping",
                  Amount: -106.35
              ),
              TestTransactionR(
                  Date: "2018-11-24 00:00:00",
                  Category: "online_shopping",
                  Amount: -106.35
              ),
              TestTransactionR(
                  Date: "2018-11-25 00:00:00",
                  Category: "online_shopping",
                  Amount: -106.35
              ),
              TestTransactionR(
                  Date: "2018-11-26 00:00:00",
                  Category: "electronics",
                  Amount: -22.4
              ),
              TestTransactionR(
                  Date: "2018-11-27 00:00:00",
                  Category: "online_shopping",
                  Amount: -42.4
              ),
              TestTransactionR(
                  Date: "2018-12-02 00:00:00",
                  Category: "public_transport",
                  Amount: -45.2
              ),
              TestTransactionR(
                  Date: "2018-12-02 00:00:00",
                  Category: "office",
                  Amount: -11.85
              ),
              TestTransactionR(
                  Date: "2018-12-05 00:00:00",
                  Category: "online_shopping",
                  Amount: -42.45
              ),
              TestTransactionR(
                  Date: "2018-12-07 00:00:00",
                  Category: "restaurants",
                  Amount: -127.1
              ),
              TestTransactionR(
                  Date: "2018-12-07 00:00:00",
                  Category: "online_shopping",
                  Amount: -105.95
              ),
              TestTransactionR(
                  Date: "2018-12-07 00:00:00",
                  Category: "groceries",
                  Amount: -7.5
              ),
              TestTransactionR(
                  Date: "2018-12-08 00:00:00",
                  Category: "hairdresser",
                  Amount: -49
              ),
              TestTransactionR(
                  Date: "2018-12-08 00:00:00",
                  Category: "leisure_shopping",
                  Amount: -41.2
              ),
              TestTransactionR(
                  Date: "2018-12-09 00:00:00",
                  Category: "hobbies",
                  Amount: -30.75
              ),
              TestTransactionR(
                  Date: "2018-12-09 00:00:00",
                  Category: "online_shopping",
                  Amount: -11.7
              ),
              TestTransactionR(
                  Date: "2018-12-10 00:00:00",
                  Category: "groceries",
                  Amount: -7.6
              ),
              TestTransactionR(
                  Date: "2018-12-10 00:00:00",
                  Category: "groceries",
                  Amount: -17.3
              ),
              TestTransactionR(
                  Date: "2018-12-11 00:00:00",
                  Category: "groceries",
                  Amount: -12.2
              ),
              TestTransactionR(
                  Date: "2018-12-11 00:00:00",
                  Category: "cash",
                  Amount: -200
              ),
              TestTransactionR(
                  Date: "2018-12-12 00:00:00",
                  Category: "groceries",
                  Amount: -50
              ),
              TestTransactionR(
                  Date: "2018-12-12 00:00:00",
                  Category: "phone_internet",
                  Amount: -161.7
              ),
              TestTransactionR(
                  Date: "2018-12-12 00:00:00",
                  Category: "groceries",
                  Amount: -5.7
              ),
              TestTransactionR(
                  Date: "2018-12-12 00:00:00",
                  Category: "groceries",
                  Amount: -7.4
              ),
              TestTransactionR(
                  Date: "2018-12-12 00:00:00",
                  Category: "groceries",
                  Amount: -15.4
              ),
              TestTransactionR(
                  Date: "2018-12-13 00:00:00",
                  Category: "hobbies",
                  Amount: -160
              ),
              TestTransactionR(
                  Date: "2018-12-13 00:00:00",
                  Category: "online_shopping",
                  Amount: -84.65
              ),
              TestTransactionR(
                  Date: "2018-12-14 00:00:00",
                  Category: "electronics",
                  Amount: -435.9
              ),
              TestTransactionR(
                  Date: "2018-12-14 00:00:00",
                  Category: "groceries",
                  Amount: -59
              ),
              TestTransactionR(
                  Date: "2018-12-14 00:00:00",
                  Category: "groceries",
                  Amount: -18.5
              ),
              TestTransactionR(
                  Date: "2018-12-14 00:00:00",
                  Category: "presents",
                  Amount: -107.9
              ),
              TestTransactionR(
                  Date: "2018-12-14 00:00:00",
                  Category: "presents",
                  Amount: -15.6
              ),
              TestTransactionR(
                  Date: "2018-12-15 00:00:00",
                  Category: "electronics",
                  Amount: -199
              ),
              TestTransactionR(
                  Date: "2018-12-15 00:00:00",
                  Category: "electronics",
                  Amount: -33
              ),
              TestTransactionR(
                  Date: "2018-12-15 00:00:00",
                  Category: "electronics",
                  Amount: -19.9
              ),
              TestTransactionR(
                  Date: "2018-12-15 00:00:00",
                  Category: "restaurants",
                  Amount: -122.5
              ),
              TestTransactionR(
                  Date: "2018-12-15 00:00:00",
                  Category: "movies",
                  Amount: -34
              ),
              TestTransactionR(
                  Date: "2018-12-16 00:00:00",
                  Category: "electronics",
                  Amount: -23.5
              ),
              TestTransactionR(
                  Date: "2018-12-16 00:00:00",
                  Category: "electronics",
                  Amount: -173.1
              ),
              TestTransactionR(
                  Date: "2018-12-16 00:00:00",
                  Category: "groceries",
                  Amount: -14.3
              ),
              TestTransactionR(
                  Date: "2018-12-17 00:00:00",
                  Category: "leisure_shopping",
                  Amount: -129.95
              ),
              TestTransactionR(
                  Date: "2018-12-17 00:00:00",
                  Category: "electronics",
                  Amount: -60
              ),
              TestTransactionR(
                  Date: "2018-12-17 00:00:00",
                  Category: "groceries",
                  Amount: -7.2
              ),
              TestTransactionR(
                  Date: "2018-12-17 00:00:00",
                  Category: "groceries",
                  Amount: -15.8
              ),
              TestTransactionR(
                  Date: "2018-12-17 00:00:00",
                  Category: "groceries",
                  Amount: -5.65
              ),
              TestTransactionR(
                  Date: "2018-12-19 00:00:00",
                  Category: "fastfood",
                  Amount: -8.6
              ),
              TestTransactionR(
                  Date: "2018-12-19 00:00:00",
                  Category: "groceries",
                  Amount: -7.6
              ),
              TestTransactionR(
                  Date: "2018-12-19 00:00:00",
                  Category: "groceries",
                  Amount: -7.2
              ),
              TestTransactionR(
                  Date: "2018-12-19 00:00:00",
                  Category: "groceries",
                  Amount: -3.7
              ),
              TestTransactionR(
                  Date: "2018-12-19 00:00:00",
                  Category: "groceries",
                  Amount: -50
              ),
              TestTransactionR(
                  Date: "2018-12-20 00:00:00",
                  Category: "electronics",
                  Amount: -469
              ),
              TestTransactionR(
                  Date: "2018-12-20 00:00:00",
                  Category: "groceries",
                  Amount: -16.8
              ),
              TestTransactionR(
                  Date: "2018-12-20 00:00:00",
                  Category: "groceries",
                  Amount: -22.35
              ),
              TestTransactionR(
                  Date: "2018-12-21 00:00:00",
                  Category: "office",
                  Amount: -11.75
              ),
              TestTransactionR(
                  Date: "2018-12-21 00:00:00",
                  Category: "groceries",
                  Amount: -7.6
              ),
              TestTransactionR(
                  Date: "2018-12-21 00:00:00",
                  Category: "groceries",
                  Amount: -18.55
              ),
              TestTransactionR(
                  Date: "2018-12-21 00:00:00",
                  Category: "groceries",
                  Amount: -7.2
              ),
              TestTransactionR(
                  Date: "2018-12-21 00:00:00",
                  Category: "books",
                  Amount: -20.5
              ),
              TestTransactionR(
                  Date: "2018-12-21 00:00:00",
                  Category: "groceries",
                  Amount: -8.5
              ),
              TestTransactionR(
                  Date: "2018-12-22 00:00:00",
                  Category: "art",
                  Amount: -25
              ),
              TestTransactionR(
                  Date: "2018-12-22 00:00:00",
                  Category: "groceries",
                  Amount: -41.6
              ),
              TestTransactionR(
                  Date: "2018-12-22 00:00:00",
                  Category: "cash",
                  Amount: -150
              ),
              TestTransactionR(
                  Date: "2019-02-08 00:00:00",
                  Category: "groceries",
                  Amount: -19
              ),
              TestTransactionR(
                  Date: "2019-02-08 00:00:00",
                  Category: "office",
                  Amount: -150
              ),
              TestTransactionR(
                  Date: "2019-02-08 00:00:00",
                  Category: "creditcard_payment",
                  Amount: -1407.5
              ),
              TestTransactionR(
                  Date: "2019-02-04 00:00:00",
                  Category: "groceries",
                  Amount: -1.4
              ),
              TestTransactionR(
                  Date: "2019-02-04 00:00:00",
                  Category: "groceries",
                  Amount: -50.95
              ),
              TestTransactionR(
                  Date: "2019-02-04 00:00:00",
                  Category: "restaurants",
                  Amount: -94.2
              ),
              TestTransactionR(
                  Date: "2019-02-01 00:00:00",
                  Category: "groceries",
                  Amount: -12.65
              ),
              TestTransactionR(
                  Date: "2019-02-01 00:00:00",
                  Category: "renovation",
                  Amount: -130.6
              ),
              TestTransactionR(
                  Date: "2019-02-01 00:00:00",
                  Category: "presents",
                  Amount: -152
              ),
              TestTransactionR(
                  Date: "2019-01-31 00:00:00",
                  Category: "children",
                  Amount: -32
              ),
              TestTransactionR(
                  Date: "2019-01-30 00:00:00",
                  Category: "bars",
                  Amount: -5.7
              ),
              TestTransactionR(
                  Date: "2019-01-30 00:00:00",
                  Category: "bars",
                  Amount: -8.2
              ),
              TestTransactionR(
                  Date: "2019-01-30 00:00:00",
                  Category: "bars",
                  Amount: -10.6
              ),
              TestTransactionR(
                  Date: "2019-01-29 00:00:00",
                  Category: "groceries",
                  Amount: -7.6
              ),
              TestTransactionR(
                  Date: "2019-01-29 00:00:00",
                  Category: "bars",
                  Amount: -9.6
              ),
              TestTransactionR(
                  Date: "2019-01-29 00:00:00",
                  Category: "restaurants",
                  Amount: -13
              ),
              TestTransactionR(
                  Date: "2019-01-29 00:00:00",
                  Category: "movies",
                  Amount: -29.8
              ),
              TestTransactionR(
                  Date: "2019-01-29 00:00:00",
                  Category: "hairdresser",
                  Amount: -90
              ),
              TestTransactionR(
                  Date: "2019-01-28 00:00:00",
                  Category: "bars",
                  Amount: -9.5
              ),
              TestTransactionR(
                  Date: "2019-01-28 00:00:00",
                  Category: "groceries",
                  Amount: -17.6
              ),
              TestTransactionR(
                  Date: "2019-01-25 00:00:00",
                  Category: "restaurants",
                  Amount: -6.5
              ),
              TestTransactionR(
                  Date: "2019-01-25 00:00:00",
                  Category: "leisure_shopping",
                  Amount: -8.2
              ),
              TestTransactionR(
                  Date: "2019-01-25 00:00:00",
                  Category: "bars",
                  Amount: -15.5
              ),
              TestTransactionR(
                  Date: "2019-01-25 00:00:00",
                  Category: "restaurants",
                  Amount: -100.2
              ),
              TestTransactionR(
                  Date: "2019-01-25 00:00:00",
                  Category: "save_invest",
                  Amount: -1500
              ),
              TestTransactionR(
                  Date: "2019-01-25 00:00:00",
                  Category: "household",
                  Amount: -6500
              ),
              TestTransactionR(
                  Date: "2019-01-25 00:00:00",
                  Category: "income",
                  Amount: 10526.75
              ),
              TestTransactionR(
                  Date: "2019-01-24 00:00:00",
                  Category: "bars",
                  Amount: -13.05
              ),
              TestTransactionR(
                  Date: "2019-01-23 00:00:00",
                  Category: "bars",
                  Amount: -7.6
              ),
              TestTransactionR(
                  Date: "2019-01-23 00:00:00",
                  Category: "bars",
                  Amount: -13.05
              ),
              TestTransactionR(
                  Date: "2019-01-23 00:00:00",
                  Category: "groceries",
                  Amount: -20.3
              ),
              TestTransactionR(
                  Date: "2019-01-22 00:00:00",
                  Category: "bars",
                  Amount: -7.6
              ),
              TestTransactionR(
                  Date: "2019-01-22 00:00:00",
                  Category: "groceries",
                  Amount: -15.8
              ),
              TestTransactionR(
                  Date: "2019-01-21 00:00:00",
                  Category: "bars",
                  Amount: -9.55
              ),
              TestTransactionR(
                  Date: "2019-01-21 00:00:00",
                  Category: "groceries",
                  Amount: -15.8
              ),
              TestTransactionR(
                  Date: "2019-01-18 00:00:00",
                  Category: "restaurants",
                  Amount: -9.2
              ),
              TestTransactionR(
                  Date: "2019-01-18 00:00:00",
                  Category: "groceries",
                  Amount: -19.15
              ),
              TestTransactionR(
                  Date: "2019-01-17 00:00:00",
                  Category: "bars",
                  Amount: -2.95
              ),
              TestTransactionR(
                  Date: "2019-01-17 00:00:00",
                  Category: "groceries",
                  Amount: -8.6
              ),
              TestTransactionR(
                  Date: "2019-01-17 00:00:00",
                  Category: "groceries",
                  Amount: -11.7
              ),
              TestTransactionR(
                  Date: "2019-01-16 00:00:00",
                  Category: "bars",
                  Amount: -3.6
              ),
              TestTransactionR(
                  Date: "2019-01-16 00:00:00",
                  Category: "bars",
                  Amount: -7.2
              ),
              TestTransactionR(
                  Date: "2019-01-16 00:00:00",
                  Category: "groceries",
                  Amount: -7.2
              ),
              TestTransactionR(
                  Date: "2019-01-16 00:00:00",
                  Category: "bars",
                  Amount: -8.6
              ),
              TestTransactionR(
                  Date: "2019-01-15 00:00:00",
                  Category: "bars",
                  Amount: -3.6
              ),
              TestTransactionR(
                  Date: "2019-01-15 00:00:00",
                  Category: "groceries",
                  Amount: -7.2
              ),
              TestTransactionR(
                  Date: "2019-01-15 00:00:00",
                  Category: "groceries",
                  Amount: -14.3
              ),
              TestTransactionR(
                  Date: "2019-01-14 00:00:00",
                  Category: "groceries",
                  Amount: -7.1
              ),
              TestTransactionR(
                  Date: "2019-01-14 00:00:00",
                  Category: "renovation",
                  Amount: -18
              ),
              TestTransactionR(
                  Date: "2019-01-14 00:00:00",
                  Category: "groceries",
                  Amount: -45.1
              ),
              TestTransactionR(
                  Date: "2019-01-14 00:00:00",
                  Category: "cash",
                  Amount: -200
              ),
              TestTransactionR(
                  Date: "2019-01-10 00:00:00",
                  Category: "bars",
                  Amount: -5.7
              ),
              TestTransactionR(
                  Date: "2019-01-10 00:00:00",
                  Category: "bars",
                  Amount: -8
              ),
              TestTransactionR(
                  Date: "2019-01-09 00:00:00",
                  Category: "creditcard_payment",
                  Amount: -4901.35
              ),
              TestTransactionR(
                  Date: "2019-01-08 00:00:00",
                  Category: "groceries",
                  Amount: -5.4
              ),
              TestTransactionR(
                  Date: "2019-01-08 00:00:00",
                  Category: "bars",
                  Amount: -12.35
              ),
              TestTransactionR(
                  Date: "2019-01-08 00:00:00",
                  Category: "groceries",
                  Amount: -18.1
              ),
              TestTransactionR(
                  Date: "2019-01-07 00:00:00",
                  Category: "groceries",
                  Amount: -57.35
              ),
              TestTransactionR(
                  Date: "2019-01-07 00:00:00",
                  Category: "groceries",
                  Amount: -105.22
              ),
              TestTransactionR(
                  Date: "2019-01-04 00:00:00",
                  Category: "groceries",
                  Amount: -7.2
              ),
              TestTransactionR(
                  Date: "2019-01-04 00:00:00",
                  Category: "groceries",
                  Amount: -9.5
              ),
              TestTransactionR(
                  Date: "2019-01-04 00:00:00",
                  Category: "leisure_shopping",
                  Amount: -11.55
              ),
              TestTransactionR(
                  Date: "2019-01-04 00:00:00",
                  Category: "bars",
                  Amount: -16.9
              ),
              TestTransactionR(
                  Date: "2019-01-03 00:00:00",
                  Category: "groceries",
                  Amount: -7.6
              ),
              TestTransactionR(
                  Date: "2019-01-03 00:00:00",
                  Category: "bars",
                  Amount: -13.6
              ),
              TestTransactionR(
                  Date: "2019-01-03 00:00:00",
                  Category: "massage",
                  Amount: -36
              ),
              TestTransactionR(
                  Date: "2019-01-03 00:00:00",
                  Category: "presents",
                  Amount: -152
              ),
              TestTransactionR(
                  Date: "2018-12-31 00:00:00",
                  Category: "bars",
                  Amount: -9
              ),
              TestTransactionR(
                  Date: "2018-12-31 00:00:00",
                  Category: "groceries",
                  Amount: -16.4
              ),
              TestTransactionR(
                  Date: "2018-12-31 00:00:00",
                  Category: "furniture",
                  Amount: -325.6
              ),
              TestTransactionR(
                  Date: "2018-12-31 00:00:00",
                  Category: "income",
                  Amount: 9.46
              ),
              TestTransactionR(
                  Date: "2018-12-28 00:00:00",
                  Category: "bankfees",
                  Amount: -45
              ),
              TestTransactionR(
                  Date: "2018-12-27 00:00:00",
                  Category: "save_invest",
                  Amount: -1500
              ),
              TestTransactionR(
                  Date: "2018-12-27 00:00:00",
                  Category: "household",
                  Amount: -6500
              ),
              TestTransactionR(
                  Date: "2018-12-31 00:00:00",
                  Category: "income",
                  Amount: 16.01
              ),
              TestTransactionR(
                  Date: "2018-12-31 00:00:00",
                  Category: "income",
                  Amount: 2.64
              ),
              TestTransactionR(
                  Date: "2019-01-25 00:00:00",
                  Category: "income",
                  Amount: 1500
              ),
              TestTransactionR(
                  Date: "2018-12-31 00:00:00",
                  Category: "income",
                  Amount: 0.64
              ),
              TestTransactionR(
                  Date: "2018-12-27 00:00:00",
                  Category: "income",
                  Amount: 1500
              ),
              TestTransactionR(
                  Date: "2018-12-31 00:00:00",
                  Category: "invest",
                  Amount: -6769.15
              ),
              TestTransactionR(
                  Date: "2018-12-31 00:00:00",
                  Category: "income",
                  Amount: 0.42
              ),
              TestTransactionR(
                  Date: "2018-12-31 00:00:00",
                  Category: "income",
                  Amount: 6769.16
              ),
              TestTransactionR(
                  Date: "2019-02-06 00:00:00",
                  Category: "hobbies",
                  Amount: -160
              ),
              TestTransactionR(
                  Date: "2019-02-02 00:00:00",
                  Category: "office",
                  Amount: -11.85
              ),
              TestTransactionR(
                  Date: "2019-02-01 00:00:00",
                  Category: "sport",
                  Amount: -944.95
              ),
              TestTransactionR(
                  Date: "2019-01-27 00:00:00",
                  Category: "electronics",
                  Amount: -15
              ),
              TestTransactionR(
                  Date: "2019-01-26 00:00:00",
                  Category: "electronics",
                  Amount: -22.35
              ),
              TestTransactionR(
                  Date: "2019-01-21 00:00:00",
                  Category: "office",
                  Amount: -12.95
              ),
              TestTransactionR(
                  Date: "2019-01-15 00:00:00",
                  Category: "electronics",
                  Amount: -19.9
              ),
              TestTransactionR(
                  Date: "2019-01-13 00:00:00",
                  Category: "electronics",
                  Amount: -160.5
              ),
              TestTransactionR(
                  Date: "2019-01-14 00:00:00",
                  Category: "not_categorized",
                  Amount: -72.85
              ),
              TestTransactionR(
                  Date: "2019-01-12 00:00:00",
                  Category: "hobbies",
                  Amount: -160
              ),
              TestTransactionR(
                  Date: "2019-01-09 00:00:00",
                  Category: "online_shopping",
                  Amount: -11.65
              ),
              TestTransactionR(
                  Date: "2019-01-07 00:00:00",
                  Category: "online_shopping",
                  Amount: -105.45
              ),
              TestTransactionR(
                  Date: "2019-01-04 00:00:00",
                  Category: "income",
                  Amount: 129.95
              ),
              TestTransactionR(
                  Date: "2019-01-02 00:00:00",
                  Category: "sport",
                  Amount: -598.2
              ),
              TestTransactionR(
                  Date: "2019-01-02 00:00:00",
                  Category: "office",
                  Amount: -11.85
              ),
              TestTransactionR(
                  Date: "2018-12-31 00:00:00",
                  Category: "electronics",
                  Amount: -4
              ),
              TestTransactionR(
                  Date: "2018-12-31 00:00:00",
                  Category: "groceries",
                  Amount: -55.4
              ),
              TestTransactionR(
                  Date: "2018-12-30 00:00:00",
                  Category: "electronics",
                  Amount: -48.8
              ),
              TestTransactionR(
                  Date: "2018-12-29 00:00:00",
                  Category: "misc",
                  Amount: -31.8
              ),
              TestTransactionR(
                  Date: "2018-12-29 00:00:00",
                  Category: "hotel",
                  Amount: -103.4
              ),
              TestTransactionR(
                  Date: "2018-12-29 00:00:00",
                  Category: "groceries",
                  Amount: -26.45
              ),
              TestTransactionR(
                  Date: "2018-12-29 00:00:00",
                  Category: "not_categorized",
                  Amount: -296.7
              ),
              TestTransactionR(
                  Date: "2018-12-28 00:00:00",
                  Category: "online_shopping",
                  Amount: -105.85
              ),
              TestTransactionR(
                  Date: "2018-12-28 00:00:00",
                  Category: "online_shopping",
                  Amount: -4
              ),
              TestTransactionR(
                  Date: "2018-12-27 00:00:00",
                  Category: "hobbies",
                  Amount: -20.5
              ),
              TestTransactionR(
                  Date: "2018-12-26 00:00:00",
                  Category: "electronics",
                  Amount: -22.25
              ),
              TestTransactionR(
                  Date: "2018-12-25 00:00:00",
                  Category: "hobbies",
                  Amount: -30.75
              ),
              TestTransactionR(
                  Date: "2018-12-24 00:00:00",
                  Category: "groceries",
                  Amount: -25.1
              ),
              TestTransactionR(
                  Date: "2018-12-24 00:00:00",
                  Category: "groceries",
                  Amount: -14.8
              )
          ]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        
        Transactions = transactionData.map { Transaction(id: UUID().uuidString,
                                                         amount: $0.Amount,
                                                         currency: "CHF",
                                                         bookingText: TransactionCategory($0.Category).toString(),
                                                         bookingDate: dateFormatter.date(from: $0.Date)!,
                                                         categoryId: TransactionCategory($0.Category).getIntId()) }
        
        endDateSince1970 = ZenUtils.daySince1970(date: Transactions.map {$0.bookingDate }.reduce(Date.distantPast) { $0 > $1 ? $0 : $1 })
        startDateSince1970 = ZenUtils.daySince1970(date: Transactions.map {$0.bookingDate }.reduce(Date.distantFuture) { $0 < $1 ? $0 : $1 })
        
        SpendingMatrix = [
            [
                0,
                21.1,
                0,
                0
            ],
            [
                24,
                0,
                0,
                21.7
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                40.55,
                0,
                0,
                0
            ],
            [
                20,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                57
            ],
            [
                21.45,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                21.4,
                0,
                0,
                0
            ],
            [
                11.8,
                16.2,
                0,
                0
            ],
            [
                0,
                16,
                0,
                0
            ],
            [
                0,
                19,
                0,
                0
            ],
            [
                0,
                0,
                0,
                79.9
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                21.5,
                21.4,
                0,
                19.9
            ],
            [
                0,
                9.05,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                21.5,
                23.9,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                59.1,
                0,
                0,
                0
            ],
            [
                43.1,
                46.7,
                0,
                0
            ],
            [
                0,
                23,
                0,
                0
            ],
            [
                0,
                3.4,
                0,
                43
            ],
            [
                0,
                23.3,
                0,
                0
            ],
            [
                0,
                0,
                0,
                22.5
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                7.4,
                0,
                0
            ],
            [
                0,
                6.35,
                0,
                0
            ],
            [
                0,
                18.15,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                21.6,
                0,
                0
            ],
            [
                0,
                7.2,
                0,
                0
            ],
            [
                0,
                28.35,
                0,
                0
            ],
            [
                11.85,
                24.8,
                0,
                0
            ],
            [
                85.7,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                28.25,
                0,
                69
            ],
            [
                0,
                30,
                0,
                0
            ],
            [
                21.4,
                0,
                0,
                0
            ],
            [
                10.65,
                0,
                0,
                19.9
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                18.6,
                0,
                0
            ],
            [
                4,
                29.95,
                0,
                0
            ],
            [
                0,
                23.35,
                0,
                0
            ],
            [
                106.35,
                22.2,
                0,
                0
            ],
            [
                106.35,
                0,
                0,
                0
            ],
            [
                106.35,
                0,
                0,
                0
            ],
            [
                0,
                21.65,
                0,
                22.4
            ],
            [
                42.4,
                0,
                0,
                0
            ],
            [
                0,
                13.7,
                0,
                0
            ],
            [
                0,
                5.7,
                0,
                0
            ],
            [
                0,
                5.3,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                9.2,
                0,
                0
            ],
            [
                42.45,
                22.7,
                0,
                0
            ],
            [
                0,
                12.8,
                0,
                0
            ],
            [
                105.95,
                15.8,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                11.7,
                0,
                0,
                0
            ],
            [
                0,
                15.8,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                84.65,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                435.9
            ],
            [
                0,
                0,
                0,
                251.9
            ],
            [
                0,
                0,
                0,
                196.6
            ],
            [
                0,
                0,
                0,
                60
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                8.6,
                0
            ],
            [
                0,
                0,
                0,
                469
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                22.25
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                109.85,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                48.8
            ],
            [
                0,
                9,
                0,
                4
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                13.6,
                0,
                0
            ],
            [
                0,
                16.9,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                105.45,
                0,
                0,
                0
            ],
            [
                0,
                12.35,
                0,
                0
            ],
            [
                11.65,
                0,
                0,
                0
            ],
            [
                0,
                13.7,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                160.5
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                3.6,
                0,
                19.9
            ],
            [
                0,
                19.4,
                0,
                0
            ],
            [
                0,
                2.95,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                9.55,
                0,
                0
            ],
            [
                0,
                7.6,
                0,
                0
            ],
            [
                0,
                20.65,
                0,
                0
            ],
            [
                0,
                13.05,
                0,
                0
            ],
            [
                0,
                15.5,
                0,
                0
            ],
            [
                0,
                0,
                0,
                22.35
            ],
            [
                0,
                0,
                0,
                15
            ],
            [
                0,
                9.5,
                0,
                0
            ],
            [
                0,
                9.6,
                0,
                0
            ],
            [
                0,
                24.5,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ]
        ]
        
        UtilisationMatrix = [
            [
                0,
                0.2532,
                0,
                0
            ],
            [
                0.13846154,
                0.24346154,
                0,
                0.07511538
            ],
            [
                0.13333333,
                0.23444444,
                0,
                0.07233333
            ],
            [
                0.12857143,
                0.22607143,
                0,
                0.06975
            ],
            [
                0.12413793,
                0.21827586,
                0,
                0.06734483
            ],
            [
                0.12,
                0.211,
                0,
                0.0651
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                3.142625,
                0,
                0,
                0
            ],
            [
                3.12841667,
                0,
                0,
                0
            ],
            [
                2.3463125,
                0,
                0,
                0
            ],
            [
                1.87705,
                0,
                0,
                1.0602
            ],
            [
                2.11833333,
                0,
                0,
                0.8835
            ],
            [
                1.81571429,
                0,
                0,
                0.75728571
            ],
            [
                2.003375,
                0,
                0,
                0.662625
            ],
            [
                1.984,
                0.558,
                0,
                0.589
            ],
            [
                1.7856,
                0.9982,
                0,
                0.5301
            ],
            [
                1.62327273,
                1.44290909,
                0,
                0.48190909
            ],
            [
                1.488,
                1.32266667,
                0,
                1.060975
            ],
            [
                1.37353846,
                1.22092308,
                0,
                0.97936154
            ],
            [
                1.27542857,
                1.13371429,
                0,
                0.90940714
            ],
            [
                1.1904,
                1.05813333,
                0,
                0.84878
            ],
            [
                1.32428125,
                1.406625,
                0,
                0.9114
            ],
            [
                1.24638235,
                1.48891176,
                0,
                0.85778824
            ],
            [
                1.17713889,
                1.40619444,
                0,
                0.81013333
            ],
            [
                1.29057895,
                1.72213158,
                0,
                0.76749474
            ],
            [
                1.22605,
                1.636025,
                0,
                0.72912
            ],
            [
                1.60388095,
                1.55811905,
                0,
                0.6944
            ],
            [
                1.83463636,
                2.14534091,
                0,
                0.66283636
            ],
            [
                1.75486957,
                2.36206522,
                0,
                0.63401739
            ],
            [
                1.68175,
                2.3075625,
                0,
                0.774225
            ],
            [
                1.61448,
                2.50418,
                0,
                0.743256
            ],
            [
                1.55238462,
                2.40786538,
                0,
                0.79515
            ],
            [
                1.49488889,
                2.31868519,
                0,
                0.7657
            ],
            [
                1.4415,
                2.235875,
                0,
                0.73835357
            ],
            [
                1.3917931,
                2.15877586,
                0,
                0.7128931
            ],
            [
                1.3454,
                2.16328333,
                0,
                0.68913
            ],
            [
                1.302,
                2.157,
                0,
                0.6669
            ],
            [
                0,
                5.445,
                0,
                0
            ],
            [
                0,
                2.7225,
                0,
                0
            ],
            [
                0,
                1.815,
                0,
                0
            ],
            [
                0,
                1.36125,
                0,
                0
            ],
            [
                0,
                1.089,
                0,
                0
            ],
            [
                0,
                1.9875,
                0,
                0
            ],
            [
                0,
                2.01214286,
                0,
                0
            ],
            [
                0,
                2.82375,
                0,
                0
            ],
            [
                0.1975,
                3.33666667,
                0,
                0
            ],
            [
                1.46325,
                3.003,
                0,
                0
            ],
            [
                1.33022727,
                2.73,
                0,
                0
            ],
            [
                1.219375,
                3.20875,
                0,
                0.5175
            ],
            [
                1.12557692,
                3.65423077,
                0,
                0.47769231
            ],
            [
                1.27446429,
                3.39321429,
                0,
                0.44357143
            ],
            [
                1.296,
                3.167,
                0,
                0.5334
            ],
            [
                1.215,
                2.9690625,
                0,
                0.5000625
            ],
            [
                1.14352941,
                2.79441176,
                0,
                0.47064706
            ],
            [
                1.08,
                2.63916667,
                0,
                0.4445
            ],
            [
                1.02315789,
                2.50026316,
                0,
                0.42110526
            ],
            [
                0.972,
                2.65425,
                0,
                0.40005
            ],
            [
                0.95428571,
                2.95571429,
                0,
                0.381
            ],
            [
                0.91090909,
                3.13977273,
                0,
                0.36368182
            ],
            [
                1.5648913,
                3.29282609,
                0,
                0.34786957
            ],
            [
                2.164375,
                3.155625,
                0,
                0.333375
            ],
            [
                2.7159,
                3.0294,
                0,
                0.32004
            ],
            [
                2.61144231,
                3.16269231,
                0,
                0.38526923
            ],
            [
                2.75027778,
                3.04555556,
                0,
                0.371
            ],
            [
                2.65205357,
                3.08357143,
                0,
                0.35775
            ],
            [
                2.56060345,
                3.0362069,
                0,
                0.34541379
            ],
            [
                2.47525,
                2.988,
                0,
                0.3339
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0.713,
                0,
                0
            ],
            [
                1.31595,
                1.9778,
                0,
                0
            ],
            [
                1.096625,
                2.3095,
                0,
                0
            ],
            [
                3.286,
                2.67928571,
                0,
                0
            ],
            [
                2.87525,
                2.344375,
                0,
                0
            ],
            [
                2.75727778,
                2.08388889,
                0,
                0
            ],
            [
                2.48155,
                2.3653,
                0,
                0
            ],
            [
                2.25595455,
                2.15027273,
                0,
                0
            ],
            [
                2.06795833,
                1.97108333,
                0,
                0
            ],
            [
                2.91817308,
                1.81946154,
                0,
                0
            ],
            [
                2.70973214,
                1.6895,
                0,
                2.89562143
            ],
            [
                2.52908333,
                1.57686667,
                0,
                4.26436
            ],
            [
                2.37101563,
                1.4783125,
                0,
                5.140575
            ],
            [
                2.23154412,
                1.39135294,
                0,
                5.16642353
            ],
            [
                2.10756944,
                1.31405556,
                0,
                4.8794
            ],
            [
                1.99664474,
                1.24489474,
                0.14031579,
                4.62258947
            ],
            [
                1.8968125,
                1.18265,
                0.1333,
                6.57231
            ],
            [
                1.8064881,
                1.12633333,
                0.12695238,
                6.25934286
            ],
            [
                1.724375,
                1.07513636,
                0.12118182,
                5.97482727
            ],
            [
                1.64940217,
                1.0283913,
                0.11591304,
                5.71505217
            ],
            [
                1.58067708,
                0.98554167,
                0.11108333,
                5.476925
            ],
            [
                1.51745,
                0.94612,
                0.10664,
                5.257848
            ],
            [
                1.45908654,
                0.90973077,
                0.10253846,
                5.13520962
            ],
            [
                1.4050463,
                0.87603704,
                0.09874074,
                4.94501667
            ],
            [
                1.96296429,
                0.84475,
                0.09521429,
                4.76840893
            ],
            [
                1.89527586,
                0.81562069,
                0.09193103,
                4.60398103
            ],
            [
                1.8321,
                0.78843333,
                0.08886667,
                4.601795
            ],
            [
                1.773,
                0.853,
                0.086,
                4.46535
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                1.40533333,
                0,
                0
            ],
            [
                0,
                2.36375,
                0,
                0
            ],
            [
                0,
                1.891,
                0,
                0
            ],
            [
                0,
                1.57583333,
                0,
                0
            ],
            [
                2.33496429,
                1.35071429,
                0,
                0
            ],
            [
                2.04309375,
                1.6604375,
                0,
                0
            ],
            [
                2.01672222,
                1.47594444,
                0,
                0
            ],
            [
                1.81505,
                1.75305,
                0,
                0
            ],
            [
                1.65004545,
                1.59368182,
                0,
                0
            ],
            [
                1.51254167,
                1.460875,
                0,
                0
            ],
            [
                1.39619231,
                1.3485,
                0,
                1.14819231
            ],
            [
                1.29646429,
                1.25217857,
                0,
                1.06617857
            ],
            [
                1.21003333,
                1.2431,
                0,
                1.11848
            ],
            [
                1.13440625,
                1.54128125,
                0,
                1.048575
            ],
            [
                1.06767647,
                1.50441176,
                0,
                0.98689412
            ],
            [
                1.00836111,
                1.42083333,
                0,
                0.93206667
            ],
            [
                0.95528947,
                1.34605263,
                0,
                0.88301053
            ],
            [
                0.907525,
                1.27875,
                0,
                0.83886
            ],
            [
                0.86430952,
                1.35883333,
                0,
                0.79891429
            ],
            [
                0.82502273,
                1.40415909,
                0,
                0.7626
            ],
            [
                0.78915217,
                1.62143478,
                0,
                0.72944348
            ],
            [
                0.75627083,
                1.7224375,
                0,
                0.69905
            ],
            [
                0.72602,
                1.84574,
                0,
                0.671088
            ],
            [
                0.69809615,
                1.77475,
                0,
                0.72522115
            ],
            [
                0.67224074,
                1.70901852,
                0,
                0.75002778
            ],
            [
                0.64823214,
                1.75316071,
                0,
                0.72324107
            ],
            [
                0.62587931,
                1.79532759,
                0,
                0.69830172
            ],
            [
                0.60501667,
                1.98865,
                0,
                0.675025
            ],
            [
                0.5855,
                1.9245,
                0,
                0.65325
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ]
        ]
        
        UtilisationMatrixMid = [
            [
                0,
                25.32,
                0,
                0
            ],
            [
                27.69230769,
                24.34615385,
                0,
                25.03846154
            ],
            [
                26.66666667,
                23.44444444,
                0,
                24.11111111
            ],
            [
                25.71428571,
                22.60714286,
                0,
                23.25
            ],
            [
                24.82758621,
                21.82758621,
                0,
                22.44827586
            ],
            [
                24,
                21.1,
                0,
                21.7
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                628.525,
                0,
                0,
                0
            ],
            [
                625.68333333,
                0,
                0,
                0
            ],
            [
                469.2625,
                0,
                0,
                0
            ],
            [
                375.41,
                0,
                0,
                353.4
            ],
            [
                423.66666667,
                0,
                0,
                294.5
            ],
            [
                363.14285714,
                0,
                0,
                252.42857143
            ],
            [
                400.675,
                0,
                0,
                220.875
            ],
            [
                396.8,
                55.8,
                0,
                196.33333333
            ],
            [
                357.12,
                99.82,
                0,
                176.7
            ],
            [
                324.65454545,
                144.29090909,
                0,
                160.63636364
            ],
            [
                297.6,
                132.26666667,
                0,
                353.65833333
            ],
            [
                274.70769231,
                122.09230769,
                0,
                326.45384615
            ],
            [
                255.08571429,
                113.37142857,
                0,
                303.13571429
            ],
            [
                238.08,
                105.81333333,
                0,
                282.92666667
            ],
            [
                264.85625,
                140.6625,
                0,
                303.8
            ],
            [
                249.27647059,
                148.89117647,
                0,
                285.92941176
            ],
            [
                235.42777778,
                140.61944444,
                0,
                270.04444444
            ],
            [
                258.11578947,
                172.21315789,
                0,
                255.83157895
            ],
            [
                245.21,
                163.6025,
                0,
                243.04
            ],
            [
                320.77619048,
                155.81190476,
                0,
                231.46666667
            ],
            [
                366.92727273,
                214.53409091,
                0,
                220.94545455
            ],
            [
                350.97391304,
                236.20652174,
                0,
                211.33913043
            ],
            [
                336.35,
                230.75625,
                0,
                258.075
            ],
            [
                322.896,
                250.418,
                0,
                247.752
            ],
            [
                310.47692308,
                240.78653846,
                0,
                265.05
            ],
            [
                298.97777778,
                231.86851852,
                0,
                255.23333333
            ],
            [
                288.3,
                223.5875,
                0,
                246.11785714
            ],
            [
                278.35862069,
                215.87758621,
                0,
                237.63103448
            ],
            [
                269.08,
                216.32833333,
                0,
                229.71
            ],
            [
                260.4,
                215.7,
                0,
                222.3
            ],
            [
                0,
                544.5,
                0,
                0
            ],
            [
                0,
                272.25,
                0,
                0
            ],
            [
                0,
                181.5,
                0,
                0
            ],
            [
                0,
                136.125,
                0,
                0
            ],
            [
                0,
                108.9,
                0,
                0
            ],
            [
                0,
                198.75,
                0,
                0
            ],
            [
                0,
                201.21428571,
                0,
                0
            ],
            [
                0,
                282.375,
                0,
                0
            ],
            [
                39.5,
                333.66666667,
                0,
                0
            ],
            [
                292.65,
                300.3,
                0,
                0
            ],
            [
                266.04545455,
                273,
                0,
                0
            ],
            [
                243.875,
                320.875,
                0,
                172.5
            ],
            [
                225.11538462,
                365.42307692,
                0,
                159.23076923
            ],
            [
                254.89285714,
                339.32142857,
                0,
                147.85714286
            ],
            [
                259.2,
                316.7,
                0,
                177.8
            ],
            [
                243,
                296.90625,
                0,
                166.6875
            ],
            [
                228.70588235,
                279.44117647,
                0,
                156.88235294
            ],
            [
                216,
                263.91666667,
                0,
                148.16666667
            ],
            [
                204.63157895,
                250.02631579,
                0,
                140.36842105
            ],
            [
                194.4,
                265.425,
                0,
                133.35
            ],
            [
                190.85714286,
                295.57142857,
                0,
                127
            ],
            [
                182.18181818,
                313.97727273,
                0,
                121.22727273
            ],
            [
                312.97826087,
                329.2826087,
                0,
                115.95652174
            ],
            [
                432.875,
                315.5625,
                0,
                111.125
            ],
            [
                543.18,
                302.94,
                0,
                106.68
            ],
            [
                522.28846154,
                316.26923077,
                0,
                128.42307692
            ],
            [
                550.05555556,
                304.55555556,
                0,
                123.66666667
            ],
            [
                530.41071429,
                308.35714286,
                0,
                119.25
            ],
            [
                512.12068966,
                303.62068966,
                0,
                115.13793103
            ],
            [
                495.05,
                298.8,
                0,
                111.3
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                71.3,
                0,
                0
            ],
            [
                263.19,
                197.78,
                0,
                0
            ],
            [
                219.325,
                230.95,
                0,
                0
            ],
            [
                657.2,
                267.92857143,
                0,
                0
            ],
            [
                575.05,
                234.4375,
                0,
                0
            ],
            [
                551.45555556,
                208.38888889,
                0,
                0
            ],
            [
                496.31,
                236.53,
                0,
                0
            ],
            [
                451.19090909,
                215.02727273,
                0,
                0
            ],
            [
                413.59166667,
                197.10833333,
                0,
                0
            ],
            [
                583.63461538,
                181.94615385,
                0,
                0
            ],
            [
                541.94642857,
                168.95,
                0,
                965.20714286
            ],
            [
                505.81666667,
                157.68666667,
                0,
                1421.45333333
            ],
            [
                474.203125,
                147.83125,
                0,
                1713.525
            ],
            [
                446.30882353,
                139.13529412,
                0,
                1722.14117647
            ],
            [
                421.51388889,
                131.40555556,
                0,
                1626.46666667
            ],
            [
                399.32894737,
                124.48947368,
                14.03157895,
                1540.86315789
            ],
            [
                379.3625,
                118.265,
                13.33,
                2190.77
            ],
            [
                361.29761905,
                112.63333333,
                12.6952381,
                2086.44761905
            ],
            [
                344.875,
                107.51363636,
                12.11818182,
                1991.60909091
            ],
            [
                329.88043478,
                102.83913043,
                11.59130435,
                1905.0173913
            ],
            [
                316.13541667,
                98.55416667,
                11.10833333,
                1825.64166667
            ],
            [
                303.49,
                94.612,
                10.664,
                1752.616
            ],
            [
                291.81730769,
                90.97307692,
                10.25384615,
                1711.73653846
            ],
            [
                281.00925926,
                87.6037037,
                9.87407407,
                1648.33888889
            ],
            [
                392.59285714,
                84.475,
                9.52142857,
                1589.46964286
            ],
            [
                379.05517241,
                81.56206897,
                9.19310345,
                1534.66034483
            ],
            [
                366.42,
                78.84333333,
                8.88666667,
                1533.93166667
            ],
            [
                354.6,
                85.3,
                8.6,
                1488.45
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                140.53333333,
                0,
                0
            ],
            [
                0,
                236.375,
                0,
                0
            ],
            [
                0,
                189.1,
                0,
                0
            ],
            [
                0,
                157.58333333,
                0,
                0
            ],
            [
                466.99285714,
                135.07142857,
                0,
                0
            ],
            [
                408.61875,
                166.04375,
                0,
                0
            ],
            [
                403.34444444,
                147.59444444,
                0,
                0
            ],
            [
                363.01,
                175.305,
                0,
                0
            ],
            [
                330.00909091,
                159.36818182,
                0,
                0
            ],
            [
                302.50833333,
                146.0875,
                0,
                0
            ],
            [
                279.23846154,
                134.85,
                0,
                382.73076923
            ],
            [
                259.29285714,
                125.21785714,
                0,
                355.39285714
            ],
            [
                242.00666667,
                124.31,
                0,
                372.82666667
            ],
            [
                226.88125,
                154.128125,
                0,
                349.525
            ],
            [
                213.53529412,
                150.44117647,
                0,
                328.96470588
            ],
            [
                201.67222222,
                142.08333333,
                0,
                310.68888889
            ],
            [
                191.05789474,
                134.60526316,
                0,
                294.33684211
            ],
            [
                181.505,
                127.875,
                0,
                279.62
            ],
            [
                172.86190476,
                135.88333333,
                0,
                266.3047619
            ],
            [
                165.00454545,
                140.41590909,
                0,
                254.2
            ],
            [
                157.83043478,
                162.14347826,
                0,
                243.14782609
            ],
            [
                151.25416667,
                172.24375,
                0,
                233.01666667
            ],
            [
                145.204,
                184.574,
                0,
                223.696
            ],
            [
                139.61923077,
                177.475,
                0,
                241.74038462
            ],
            [
                134.44814815,
                170.90185185,
                0,
                250.00925926
            ],
            [
                129.64642857,
                175.31607143,
                0,
                241.08035714
            ],
            [
                125.17586207,
                179.53275862,
                0,
                232.76724138
            ],
            [
                121.00333333,
                198.865,
                0,
                225.00833333
            ],
            [
                117.1,
                192.45,
                0,
                217.75
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0
            ]
        ]
        
        var zenData = [
            TestZenR(
                ZenDate: "2018-09-25",
                AverageUtilization: 0.03452727,
                RawUtilizationScore: 0.03814978,
                DailyUtilizationScore: 0.50953629,
                UnbudgetedSpendingFactor: 0.20095238,
                TotalSpending: 105
            ),
            TestZenR(
                ZenDate: "2018-09-26",
                AverageUtilization: 0.1051049,
                RawUtilizationScore: 0.12725989,
                DailyUtilizationScore: 0.5317721,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 45.7
            ),
            TestZenR(
                ZenDate: "2018-09-27",
                AverageUtilization: 0.10121212,
                RawUtilizationScore: 0.12190886,
                DailyUtilizationScore: 0.53043953,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 8045
            ),
            TestZenR(
                ZenDate: "2018-09-28",
                AverageUtilization: 0.0975974,
                RawUtilizationScore: 0.11698901,
                DailyUtilizationScore: 0.52921394,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 0
            ),
            TestZenR(
                ZenDate: "2018-09-29",
                AverageUtilization: 0.09423197,
                RawUtilizationScore: 0.11245032,
                DailyUtilizationScore: 0.52808299,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 0
            ),
            TestZenR(
                ZenDate: "2018-09-30",
                AverageUtilization: 0.09109091,
                RawUtilizationScore: 0.10825019,
                DailyUtilizationScore: 0.52703615,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 0
            ),
            TestZenR(
                ZenDate: "2018-10-01",
                AverageUtilization: 0,
                RawUtilizationScore: 0,
                DailyUtilizationScore: 0.5,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 108.75
            ),
            TestZenR(
                ZenDate: "2018-10-02",
                AverageUtilization: 0.85707955,
                RawUtilizationScore: 8.5098926,
                DailyUtilizationScore: 0.99979858,
                UnbudgetedSpendingFactor: 0.06468336,
                TotalSpending: 626.9
            ),
            TestZenR(
                ZenDate: "2018-10-03",
                AverageUtilization: 0.85320455,
                RawUtilizationScore: 8.22582286,
                DailyUtilizationScore: 0.99973242,
                UnbudgetedSpendingFactor: 0.17889088,
                TotalSpending: 111.8
            ),
            TestZenR(
                ZenDate: "2018-10-04",
                AverageUtilization: 0.63990341,
                RawUtilizationScore: 2.24845553,
                DailyUtilizationScore: 0.90451723,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 182.3
            ),
            TestZenR(
                ZenDate: "2018-10-05",
                AverageUtilization: 0.99383182,
                RawUtilizationScore: 140.63628404,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 0.2090209,
                TotalSpending: 272.7
            ),
            TestZenR(
                ZenDate: "2018-10-06",
                AverageUtilization: 0.97931818,
                RawUtilizationScore: 64.82181524,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 21.45
            ),
            TestZenR(
                ZenDate: "2018-10-07",
                AverageUtilization: 0.83941558,
                RawUtilizationScore: 7.32955422,
                DailyUtilizationScore: 0.99934456,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 0
            ),
            TestZenR(
                ZenDate: "2018-10-08",
                AverageUtilization: 0.84756818,
                RawUtilizationScore: 7.83919724,
                DailyUtilizationScore: 0.99960617,
                UnbudgetedSpendingFactor: 0.03060641,
                TotalSpending: 699.2
            ),
            TestZenR(
                ZenDate: "2018-10-09",
                AverageUtilization: 0.88490909,
                RawUtilizationScore: 11.12810894,
                DailyUtilizationScore: 0.99998531,
                UnbudgetedSpendingFactor: 0.03646546,
                TotalSpending: 767.85
            ),
            TestZenR(
                ZenDate: "2018-10-10",
                AverageUtilization: 0.86405455,
                RawUtilizationScore: 9.06325471,
                DailyUtilizationScore: 0.99988417,
                UnbudgetedSpendingFactor: 0.44137931,
                TotalSpending: 36.25
            ),
            TestZenR(
                ZenDate: "2018-10-11",
                AverageUtilization: 0.85852066,
                RawUtilizationScore: 8.6196281,
                DailyUtilizationScore: 0.99981951,
                UnbudgetedSpendingFactor: 0.18018018,
                TotalSpending: 105.45
            ),
            TestZenR(
                ZenDate: "2018-10-12",
                AverageUtilization: 1.06844318,
                RawUtilizationScore: 29.47415881,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 0.18056497,
                TotalSpending: 442.5
            ),
            TestZenR(
                ZenDate: "2018-10-13",
                AverageUtilization: 0.98625524,
                RawUtilizationScore: 88.47024413,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 44.2
            ),
            TestZenR(
                ZenDate: "2018-10-14",
                AverageUtilization: 0.91580844,
                RawUtilizationScore: 16.08658383,
                DailyUtilizationScore: 0.9999999,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 13.4
            ),
            TestZenR(
                ZenDate: "2018-10-15",
                AverageUtilization: 0.85475455,
                RawUtilizationScore: 8.3375767,
                DailyUtilizationScore: 0.99976071,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 137.65
            ),
            TestZenR(
                ZenDate: "2018-10-16",
                AverageUtilization: 0.96725284,
                RawUtilizationScore: 43.21820377,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 0.87955182,
                TotalSpending: 71.4
            ),
            TestZenR(
                ZenDate: "2018-10-17",
                AverageUtilization: 0.93285963,
                RawUtilizationScore: 20.73916365,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 0.17797443,
                TotalSpending: 50.85
            ),
            TestZenR(
                ZenDate: "2018-10-18",
                AverageUtilization: 0.88103409,
                RawUtilizationScore: 10.6886648,
                DailyUtilizationScore: 0.9999772,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 36.95
            ),
            TestZenR(
                ZenDate: "2018-10-19",
                AverageUtilization: 0.93567344,
                RawUtilizationScore: 21.73457281,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 0.1735474,
                TotalSpending: 261.6
            ),
            TestZenR(
                ZenDate: "2018-10-20",
                AverageUtilization: 0.88888977,
                RawUtilizationScore: 11.61186562,
                DailyUtilizationScore: 0.99999094,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 0
            ),
            TestZenR(
                ZenDate: "2018-10-21",
                AverageUtilization: 0.96552922,
                RawUtilizationScore: 41.1683311,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 0.91627907,
                TotalSpending: 64.5
            ),
            TestZenR(
                ZenDate: "2018-10-22",
                AverageUtilization: 1.09419112,
                RawUtilizationScore: 18.59542351,
                DailyUtilizationScore: 0.99999999,
                UnbudgetedSpendingFactor: 0.1875718,
                TotalSpending: 478.75
            ),
            TestZenR(
                ZenDate: "2018-10-23",
                AverageUtilization: 1.08889032,
                RawUtilizationScore: 20.20117683,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 0.05800757,
                TotalSpending: 396.5
            ),
            TestZenR(
                ZenDate: "2018-10-24",
                AverageUtilization: 1.12524716,
                RawUtilizationScore: 12.38547886,
                DailyUtilizationScore: 0.99999582,
                UnbudgetedSpendingFactor: 0.2027972,
                TotalSpending: 228.8
            ),
            TestZenR(
                ZenDate: "2018-10-25",
                AverageUtilization: 1.11963545,
                RawUtilizationScore: 13.22319763,
                DailyUtilizationScore: 0.99999819,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 23.3
            ),
            TestZenR(
                ZenDate: "2018-10-26",
                AverageUtilization: 1.11315472,
                RawUtilizationScore: 14.31612256,
                DailyUtilizationScore: 0.99999939,
                UnbudgetedSpendingFactor: 0.00278655,
                TotalSpending: 8074.5
            ),
            TestZenR(
                ZenDate: "2018-10-27",
                AverageUtilization: 1.07192677,
                RawUtilizationScore: 27.41487384,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 0
            ),
            TestZenR(
                ZenDate: "2018-10-28",
                AverageUtilization: 1.03364367,
                RawUtilizationScore: 89.8493137,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 0
            ),
            TestZenR(
                ZenDate: "2018-10-29",
                AverageUtilization: 0.99800078,
                RawUtilizationScore: 201.10962966,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 2017.95
            ),
            TestZenR(
                ZenDate: "2018-10-30",
                AverageUtilization: 0.97516136,
                RawUtilizationScore: 55.52168569,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 0.06474191,
                TotalSpending: 114.3
            ),
            TestZenR(
                ZenDate: "2018-10-31",
                AverageUtilization: 0.95236364,
                RawUtilizationScore: 29.87694041,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 0.09103943,
                TotalSpending: 69.75
            ),
            TestZenR(
                ZenDate: "2018-11-01",
                AverageUtilization: 0.7425,
                RawUtilizationScore: 3.8218531,
                DailyUtilizationScore: 0.97858159,
                UnbudgetedSpendingFactor: 0.59508197,
                TotalSpending: 30.5
            ),
            TestZenR(
                ZenDate: "2018-11-02",
                AverageUtilization: 0.37125,
                RawUtilizationScore: 0.68354883,
                DailyUtilizationScore: 0.6645303,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 222.2
            ),
            TestZenR(
                ZenDate: "2018-11-03",
                AverageUtilization: 0.2475,
                RawUtilizationScore: 0.36858368,
                DailyUtilizationScore: 0.5911167,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 11.85
            ),
            TestZenR(
                ZenDate: "2018-11-04",
                AverageUtilization: 0.185625,
                RawUtilizationScore: 0.25161994,
                DailyUtilizationScore: 0.56257518,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 40.95
            ),
            TestZenR(
                ZenDate: "2018-11-05",
                AverageUtilization: 0.1485,
                RawUtilizationScore: 0.19084933,
                DailyUtilizationScore: 0.54756804,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 124
            ),
            TestZenR(
                ZenDate: "2018-11-06",
                AverageUtilization: 0.27102273,
                RawUtilizationScore: 0.41910822,
                DailyUtilizationScore: 0.60326983,
                UnbudgetedSpendingFactor: 0.1321505,
                TotalSpending: 163.45
            ),
            TestZenR(
                ZenDate: "2018-11-07",
                AverageUtilization: 0.27438312,
                RawUtilizationScore: 0.42663376,
                DailyUtilizationScore: 0.60506955,
                UnbudgetedSpendingFactor: 0.08581645,
                TotalSpending: 83.9
            ),
            TestZenR(
                ZenDate: "2018-11-08",
                AverageUtilization: 0.38505682,
                RawUtilizationScore: 0.72769587,
                DailyUtilizationScore: 0.67429944,
                UnbudgetedSpendingFactor: 0.03126034,
                TotalSpending: 906.9
            ),
            TestZenR(
                ZenDate: "2018-11-09",
                AverageUtilization: 0.50886364,
                RawUtilizationScore: 1.25011558,
                DailyUtilizationScore: 0.77731987,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 36.65
            ),
            TestZenR(
                ZenDate: "2018-11-10",
                AverageUtilization: 0.80856818,
                RawUtilizationScore: 5.80768743,
                DailyUtilizationScore: 0.99700463,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 85.7
            ),
            TestZenR(
                ZenDate: "2018-11-11",
                AverageUtilization: 0.73506198,
                RawUtilizationScore: 3.66359069,
                DailyUtilizationScore: 0.97500071,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 0
            ),
            TestZenR(
                ZenDate: "2018-11-12",
                AverageUtilization: 1.00534091,
                RawUtilizationScore: 618.44129582,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 0.53596032,
                TotalSpending: 181.45
            ),
            TestZenR(
                ZenDate: "2018-11-13",
                AverageUtilization: 1.02241259,
                RawUtilizationScore: 196.9467833,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 0.80645161,
                TotalSpending: 37.2
            ),
            TestZenR(
                ZenDate: "2018-11-14",
                AverageUtilization: 1.01191558,
                RawUtilizationScore: 1969.95618499,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 21.4
            ),
            TestZenR(
                ZenDate: "2018-11-15",
                AverageUtilization: 1.02777273,
                RawUtilizationScore: 127.23827524,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 0.16032537,
                TotalSpending: 190.55
            ),
            TestZenR(
                ZenDate: "2018-11-16",
                AverageUtilization: 0.96353693,
                RawUtilizationScore: 39.00608723,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 0
            ),
            TestZenR(
                ZenDate: "2018-11-17",
                AverageUtilization: 0.90685829,
                RawUtilizationScore: 14.31312945,
                DailyUtilizationScore: 0.99999939,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 0
            ),
            TestZenR(
                ZenDate: "2018-11-18",
                AverageUtilization: 0.85647727,
                RawUtilizationScore: 8.46470371,
                DailyUtilizationScore: 0.99978927,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 0
            ),
            TestZenR(
                ZenDate: "2018-11-19",
                AverageUtilization: 0.81139952,
                RawUtilizationScore: 5.92574537,
                DailyUtilizationScore: 0.99733729,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 79.95
            ),
            TestZenR(
                ZenDate: "2018-11-20",
                AverageUtilization: 0.808875,
                RawUtilizationScore: 5.82030368,
                DailyUtilizationScore: 0.99704207,
                UnbudgetedSpendingFactor: 0.28904429,
                TotalSpending: 64.35
            ),
            TestZenR(
                ZenDate: "2018-11-21",
                AverageUtilization: 0.83649351,
                RawUtilizationScore: 7.15969886,
                DailyUtilizationScore: 0.99922332,
                UnbudgetedSpendingFactor: 0.85624212,
                TotalSpending: 39.65
            ),
            TestZenR(
                ZenDate: "2018-11-22",
                AverageUtilization: 0.8418905,
                RawUtilizationScore: 7.47851446,
                DailyUtilizationScore: 0.99943522,
                UnbudgetedSpendingFactor: 0.31833674,
                TotalSpending: 73.35
            ),
            TestZenR(
                ZenDate: "2018-11-23",
                AverageUtilization: 1.03393281,
                RawUtilizationScore: 88.52611396,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 0.9335512,
                TotalSpending: 137.7
            ),
            TestZenR(
                ZenDate: "2018-11-24",
                AverageUtilization: 1.17213068,
                RawUtilizationScore: 7.82381966,
                DailyUtilizationScore: 0.99960007,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 106.35
            ),
            TestZenR(
                ZenDate: "2018-11-25",
                AverageUtilization: 1.29927273,
                RawUtilizationScore: 3.30070664,
                DailyUtilizationScore: 0.96445304,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 106.35
            ),
            TestZenR(
                ZenDate: "2018-11-26",
                AverageUtilization: 1.31861014,
                RawUtilizationScore: 2.9624063,
                DailyUtilizationScore: 0.95084658,
                UnbudgetedSpendingFactor: 0.38589575,
                TotalSpending: 114.15
            ),
            TestZenR(
                ZenDate: "2018-11-27",
                AverageUtilization: 1.33401515,
                RawUtilizationScore: 2.7242402,
                DailyUtilizationScore: 0.93844194,
                UnbudgetedSpendingFactor: 0.00501443,
                TotalSpending: 8455.6
            ),
            TestZenR(
                ZenDate: "2018-11-28",
                AverageUtilization: 1.30638799,
                RawUtilizationScore: 3.17062849,
                DailyUtilizationScore: 0.95971389,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 13.7
            ),
            TestZenR(
                ZenDate: "2018-11-29",
                AverageUtilization: 1.26938088,
                RawUtilizationScore: 3.93293746,
                DailyUtilizationScore: 0.98079019,
                UnbudgetedSpendingFactor: 0.17592593,
                TotalSpending: 32.4
            ),
            TestZenR(
                ZenDate: "2018-11-30",
                AverageUtilization: 1.23429545,
                RawUtilizationScore: 4.91312534,
                DailyUtilizationScore: 0.99270414,
                UnbudgetedSpendingFactor: 0.38129496,
                TotalSpending: 13.9
            ),
            TestZenR(
                ZenDate: "2018-12-01",
                AverageUtilization: 0,
                RawUtilizationScore: 0,
                DailyUtilizationScore: 0.5,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 0
            ),
            TestZenR(
                ZenDate: "2018-12-02",
                AverageUtilization: 0,
                RawUtilizationScore: 0,
                DailyUtilizationScore: 0.5,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 57.05
            ),
            TestZenR(
                ZenDate: "2018-12-03",
                AverageUtilization: 0,
                RawUtilizationScore: 0,
                DailyUtilizationScore: 0.5,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 152
            ),
            TestZenR(
                ZenDate: "2018-12-04",
                AverageUtilization: 0.09722727,
                RawUtilizationScore: 0.11648788,
                DailyUtilizationScore: 0.52908908,
                UnbudgetedSpendingFactor: 0.00356278,
                TotalSpending: 2582.25
            ),
            TestZenR(
                ZenDate: "2018-12-05",
                AverageUtilization: 0.62859545,
                RawUtilizationScore: 2.13178906,
                DailyUtilizationScore: 0.89395473,
                UnbudgetedSpendingFactor: 0.83472133,
                TotalSpending: 78.05
            ),
            TestZenR(
                ZenDate: "2018-12-06",
                AverageUtilization: 0.61401136,
                RawUtilizationScore: 1.99224852,
                DailyUtilizationScore: 0.87998082,
                UnbudgetedSpendingFactor: 0.34408602,
                TotalSpending: 37.2
            ),
            TestZenR(
                ZenDate: "2018-12-07",
                AverageUtilization: 1.26153896,
                RawUtilizationScore: 4.12612968,
                DailyUtilizationScore: 0.98411128,
                UnbudgetedSpendingFactor: 0.47493661,
                TotalSpending: 256.35
            ),
            TestZenR(
                ZenDate: "2018-12-08",
                AverageUtilization: 1.10384659,
                RawUtilizationScore: 16.17892958,
                DailyUtilizationScore: 0.99999991,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 90.2
            ),
            TestZenR(
                ZenDate: "2018-12-09",
                AverageUtilization: 1.03615152,
                RawUtilizationScore: 79.44104599,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 0.27561837,
                TotalSpending: 42.45
            ),
            TestZenR(
                ZenDate: "2018-12-10",
                AverageUtilization: 0.99932727,
                RawUtilizationScore: 231.34750448,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 0.01734834,
                TotalSpending: 910.75
            ),
            TestZenR(
                ZenDate: "2018-12-11",
                AverageUtilization: 0.90847934,
                RawUtilizationScore: 14.60888648,
                DailyUtilizationScore: 0.99999955,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 212.2
            ),
            TestZenR(
                ZenDate: "2018-12-12",
                AverageUtilization: 0.83277273,
                RawUtilizationScore: 6.95233332,
                DailyUtilizationScore: 0.99904451,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 240.2
            ),
            TestZenR(
                ZenDate: "2018-12-13",
                AverageUtilization: 1.04397378,
                RawUtilizationScore: 57.65945786,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 0.3460045,
                TotalSpending: 244.65
            ),
            TestZenR(
                ZenDate: "2018-12-14",
                AverageUtilization: 2.28559578,
                RawUtilizationScore: -0.59615136,
                DailyUtilizationScore: 0.3552247,
                UnbudgetedSpendingFactor: 0.68440886,
                TotalSpending: 636.9
            ),
            TestZenR(
                ZenDate: "2018-12-15",
                AverageUtilization: 2.84312273,
                RawUtilizationScore: -0.96861343,
                DailyUtilizationScore: 0.27515696,
                UnbudgetedSpendingFactor: 0.52110054,
                TotalSpending: 483.4
            ),
            TestZenR(
                ZenDate: "2018-12-16",
                AverageUtilization: 3.18485369,
                RawUtilizationScore: -1.12867914,
                DailyUtilizationScore: 0.24440494,
                UnbudgetedSpendingFactor: 0.93219535,
                TotalSpending: 210.9
            ),
            TestZenR(
                ZenDate: "2018-12-17",
                AverageUtilization: 3.14670722,
                RawUtilizationScore: -1.11220958,
                DailyUtilizationScore: 0.24745918,
                UnbudgetedSpendingFactor: 0.27447392,
                TotalSpending: 218.6
            ),
            TestZenR(
                ZenDate: "2018-12-18",
                AverageUtilization: 2.97189015,
                RawUtilizationScore: -1.03259739,
                DailyUtilizationScore: 0.26258086,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 88.05
            ),
            TestZenR(
                ZenDate: "2018-12-19",
                AverageUtilization: 2.83460885,
                RawUtilizationScore: -0.9641904,
                DailyUtilizationScore: 0.27603999,
                UnbudgetedSpendingFactor: 0.11154345,
                TotalSpending: 77.1
            ),
            TestZenR(
                ZenDate: "2018-12-20",
                AverageUtilization: 3.68417386,
                RawUtilizationScore: -1.32413296,
                DailyUtilizationScore: 0.2101315,
                UnbudgetedSpendingFactor: 0.92295582,
                TotalSpending: 508.15
            ),
            TestZenR(
                ZenDate: "2018-12-21",
                AverageUtilization: 3.50873701,
                RawUtilizationScore: -1.25890875,
                DailyUtilizationScore: 0.2211618,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 74.1
            ),
            TestZenR(
                ZenDate: "2018-12-22",
                AverageUtilization: 3.34924897,
                RawUtilizationScore: -1.19668782,
                DailyUtilizationScore: 0.23206496,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 216.6
            ),
            TestZenR(
                ZenDate: "2018-12-23",
                AverageUtilization: 3.20362945,
                RawUtilizationScore: -1.13668215,
                DailyUtilizationScore: 0.24293004,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 0
            ),
            TestZenR(
                ZenDate: "2018-12-24",
                AverageUtilization: 3.07014489,
                RawUtilizationScore: -1.07823577,
                DailyUtilizationScore: 0.25384003,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 6807.9
            ),
            TestZenR(
                ZenDate: "2018-12-25",
                AverageUtilization: 2.94733909,
                RawUtilizationScore: -1.02079085,
                DailyUtilizationScore: 0.26487338,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 30.75
            ),
            TestZenR(
                ZenDate: "2018-12-26",
                AverageUtilization: 2.87015559,
                RawUtilizationScore: -0.98248882,
                DailyUtilizationScore: 0.27239823,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 22.25
            ),
            TestZenR(
                ZenDate: "2018-12-27",
                AverageUtilization: 2.76385354,
                RawUtilizationScore: -0.92637969,
                DailyUtilizationScore: 0.28365977,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 8020.5
            ),
            TestZenR(
                ZenDate: "2018-12-28",
                AverageUtilization: 2.83098945,
                RawUtilizationScore: -0.96230219,
                DailyUtilizationScore: 0.27641749,
                UnbudgetedSpendingFactor: 0.70939619,
                TotalSpending: 154.85
            ),
            TestZenR(
                ZenDate: "2018-12-29",
                AverageUtilization: 2.73336912,
                RawUtilizationScore: -0.90946719,
                DailyUtilizationScore: 0.28710888,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 458.35
            ),
            TestZenR(
                ZenDate: "2018-12-30",
                AverageUtilization: 2.71102045,
                RawUtilizationScore: -0.89681041,
                DailyUtilizationScore: 0.2897064,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 48.8
            ),
            TestZenR(
                ZenDate: "2018-12-31",
                AverageUtilization: 2.64129545,
                RawUtilizationScore: -0.85579977,
                DailyUtilizationScore: 0.29821764,
                UnbudgetedSpendingFactor: 0.0018107,
                TotalSpending: 7179.55
            ),
            TestZenR(
                ZenDate: "2019-01-01",
                AverageUtilization: 0,
                RawUtilizationScore: 0,
                DailyUtilizationScore: 0.5,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 0
            ),
            TestZenR(
                ZenDate: "2019-01-02",
                AverageUtilization: 0,
                RawUtilizationScore: 0,
                DailyUtilizationScore: 0.5,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 610.05
            ),
            TestZenR(
                ZenDate: "2019-01-03",
                AverageUtilization: 0.19163636,
                RawUtilizationScore: 0.2620753,
                DailyUtilizationScore: 0.56514638,
                UnbudgetedSpendingFactor: 0.06500956,
                TotalSpending: 209.2
            ),
            TestZenR(
                ZenDate: "2019-01-04",
                AverageUtilization: 0.32232955,
                RawUtilizationScore: 0.54336866,
                DailyUtilizationScore: 0.63259571,
                UnbudgetedSpendingFactor: 0.37430786,
                TotalSpending: 45.15
            ),
            TestZenR(
                ZenDate: "2019-01-05",
                AverageUtilization: 0.25786364,
                RawUtilizationScore: 0.39039009,
                DailyUtilizationScore: 0.5963766,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 0
            ),
            TestZenR(
                ZenDate: "2019-01-06",
                AverageUtilization: 0.21488636,
                RawUtilizationScore: 0.30427206,
                DailyUtilizationScore: 0.57548652,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 0
            ),
            TestZenR(
                ZenDate: "2019-01-07",
                AverageUtilization: 0.82099675,
                RawUtilizationScore: 6.35506175,
                DailyUtilizationScore: 0.99826509,
                UnbudgetedSpendingFactor: 0.39344079,
                TotalSpending: 268.02
            ),
            TestZenR(
                ZenDate: "2019-01-08",
                AverageUtilization: 0.78363068,
                RawUtilizationScore: 4.90748395,
                DailyUtilizationScore: 0.99266317,
                UnbudgetedSpendingFactor: 0.34449093,
                TotalSpending: 35.85
            ),
            TestZenR(
                ZenDate: "2019-01-09",
                AverageUtilization: 0.7512803,
                RawUtilizationScore: 4.02168043,
                DailyUtilizationScore: 0.98239275,
                UnbudgetedSpendingFactor: 0.00237126,
                TotalSpending: 4913
            ),
            TestZenR(
                ZenDate: "2019-01-10",
                AverageUtilization: 0.73406591,
                RawUtilizationScore: 3.64311295,
                DailyUtilizationScore: 0.97449669,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 13.7
            ),
            TestZenR(
                ZenDate: "2019-01-11",
                AverageUtilization: 0.66733264,
                RawUtilizationScore: 2.56732612,
                DailyUtilizationScore: 0.92872891,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 0
            ),
            TestZenR(
                ZenDate: "2019-01-12",
                AverageUtilization: 0.61172159,
                RawUtilizationScore: 1.97137377,
                DailyUtilizationScore: 0.87775859,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 160
            ),
            TestZenR(
                ZenDate: "2019-01-13",
                AverageUtilization: 1.08657168,
                RawUtilizationScore: 20.98082204,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 160.5
            ),
            TestZenR(
                ZenDate: "2019-01-14",
                AverageUtilization: 1.00895942,
                RawUtilizationScore: 3436.20748106,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 343.05
            ),
            TestZenR(
                ZenDate: "2019-01-15",
                AverageUtilization: 1.00792273,
                RawUtilizationScore: 1581.93143677,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 0.52222222,
                TotalSpending: 45
            ),
            TestZenR(
                ZenDate: "2019-01-16",
                AverageUtilization: 0.99618324,
                RawUtilizationScore: 169.84474986,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 0.72932331,
                TotalSpending: 26.6
            ),
            TestZenR(
                ZenDate: "2019-01-17",
                AverageUtilization: 0.94491979,
                RawUtilizationScore: 25.67856179,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 0.12688172,
                TotalSpending: 23.25
            ),
            TestZenR(
                ZenDate: "2019-01-18",
                AverageUtilization: 0.89242424,
                RawUtilizationScore: 12.0716995,
                DailyUtilizationScore: 0.99999428,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 28.35
            ),
            TestZenR(
                ZenDate: "2019-01-19",
                AverageUtilization: 0.84545455,
                RawUtilizationScore: 7.70172022,
                DailyUtilizationScore: 0.99954816,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 0
            ),
            TestZenR(
                ZenDate: "2019-01-20",
                AverageUtilization: 0.80318182,
                RawUtilizationScore: 5.59291675,
                DailyUtilizationScore: 0.99628967,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 0
            ),
            TestZenR(
                ZenDate: "2019-01-21",
                AverageUtilization: 0.78415909,
                RawUtilizationScore: 4.92429142,
                DailyUtilizationScore: 0.99278457,
                UnbudgetedSpendingFactor: 0.24934726,
                TotalSpending: 38.3
            ),
            TestZenR(
                ZenDate: "2019-01-22",
                AverageUtilization: 0.7631188,
                RawUtilizationScore: 4.31611148,
                DailyUtilizationScore: 0.98682422,
                UnbudgetedSpendingFactor: 0.32478632,
                TotalSpending: 23.4
            ),
            TestZenR(
                ZenDate: "2019-01-23",
                AverageUtilization: 0.76789328,
                RawUtilizationScore: 4.44389222,
                DailyUtilizationScore: 0.98838635,
                UnbudgetedSpendingFactor: 0.5042735,
                TotalSpending: 40.95
            ),
            TestZenR(
                ZenDate: "2019-01-24",
                AverageUtilization: 0.75888352,
                RawUtilizationScore: 4.20724908,
                DailyUtilizationScore: 0.98533111,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 13.05
            ),
            TestZenR(
                ZenDate: "2019-01-25",
                AverageUtilization: 0.75473727,
                RawUtilizationScore: 4.10453772,
                DailyUtilizationScore: 0.98377011,
                UnbudgetedSpendingFactor: 0.00190643,
                TotalSpending: 8130.4
            ),
            TestZenR(
                ZenDate: "2019-01-26",
                AverageUtilization: 0.7620472,
                RawUtilizationScore: 4.28817874,
                DailyUtilizationScore: 0.98645605,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 22.35
            ),
            TestZenR(
                ZenDate: "2019-01-27",
                AverageUtilization: 0.75730808,
                RawUtilizationScore: 4.16778292,
                DailyUtilizationScore: 0.98474962,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 15
            ),
            TestZenR(
                ZenDate: "2019-01-28",
                AverageUtilization: 0.7446039,
                RawUtilizationScore: 3.86840287,
                DailyUtilizationScore: 0.97953582,
                UnbudgetedSpendingFactor: 0.35055351,
                TotalSpending: 27.1
            ),
            TestZenR(
                ZenDate: "2019-01-29",
                AverageUtilization: 0.73292163,
                RawUtilizationScore: 3.61978947,
                DailyUtilizationScore: 0.97391058,
                UnbudgetedSpendingFactor: 0.064,
                TotalSpending: 150
            ),
            TestZenR(
                ZenDate: "2019-01-30",
                AverageUtilization: 0.74301364,
                RawUtilizationScore: 3.83314267,
                DailyUtilizationScore: 0.97881694,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 24.5
            ),
            TestZenR(
                ZenDate: "2019-01-31",
                AverageUtilization: 0.71904545,
                RawUtilizationScore: 3.35306875,
                DailyUtilizationScore: 0.96620518,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 32
            ),
            TestZenR(
                ZenDate: "2019-02-01",
                AverageUtilization: 0,
                RawUtilizationScore: 0,
                DailyUtilizationScore: 0.5,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 1240.2
            ),
            TestZenR(
                ZenDate: "2019-02-02",
                AverageUtilization: 0,
                RawUtilizationScore: 0,
                DailyUtilizationScore: 0.5,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 11.85
            ),
            TestZenR(
                ZenDate: "2019-02-03",
                AverageUtilization: 0,
                RawUtilizationScore: 0,
                DailyUtilizationScore: 0.5,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 0
            ),
            TestZenR(
                ZenDate: "2019-02-04",
                AverageUtilization: 0,
                RawUtilizationScore: 0,
                DailyUtilizationScore: 0.5,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 146.55
            ),
            TestZenR(
                ZenDate: "2019-02-05",
                AverageUtilization: 0,
                RawUtilizationScore: 0,
                DailyUtilizationScore: 0.5,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 0
            ),
            TestZenR(
                ZenDate: "2019-02-06",
                AverageUtilization: 0,
                RawUtilizationScore: 0,
                DailyUtilizationScore: 0.5,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 160
            ),
            TestZenR(
                ZenDate: "2019-02-07",
                AverageUtilization: 0,
                RawUtilizationScore: 0,
                DailyUtilizationScore: 0.5,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 0
            ),
            TestZenR(
                ZenDate: "2019-02-08",
                AverageUtilization: 0,
                RawUtilizationScore: 0,
                DailyUtilizationScore: 0.5,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 1576.5
            )
        ]

        dateFormatter.dateFormat = "yyyy-MM-dd"

        ZenItemsMid = zenData.map { ZenItem(DateSince1970: ZenUtils.daySince1970(date: dateFormatter.date(from: $0.ZenDate)!),
                                         AverageUtilisation: $0.AverageUtilization,
                                         RawUtilisatinScore: $0.RawUtilizationScore,
                                         DailyUtilizationScore: $0.DailyUtilizationScore,
                                         UnbudgetedSpendingFactor: $0.UnbudgetedSpendingFactor,
                                         TotalSpending: $0.TotalSpending) }
        
        
        zenData = [
            TestZenR(
                ZenDate: "2018-09-25",
                AverageUtilization: 0.03452727,
                RawUtilizationScore: 0.03814978,
                DailyUtilizationScore: 0.50953629,
                UnbudgetedSpendingFactor: 0.20095238,
                TotalSpending: 105,
                RawSpendingScore: 0.10239253,
                ZENScore: 0
            ),
            TestZenR(
                ZenDate: "2018-09-26",
                AverageUtilization: 0.1051049,
                RawUtilizationScore: 0.12725989,
                DailyUtilizationScore: 0.5317721,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 45.7,
                RawSpendingScore: 0.5317721,
                ZENScore: 0.01063544
            ),
            TestZenR(
                ZenDate: "2018-09-27",
                AverageUtilization: 0.10121212,
                RawUtilizationScore: 0.12190886,
                DailyUtilizationScore: 0.53043953,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 8045,
                RawSpendingScore: 0,
                ZENScore: 0.01235523
            ),
            TestZenR(
                ZenDate: "2018-09-28",
                AverageUtilization: 0.0975974,
                RawUtilizationScore: 0.11698901,
                DailyUtilizationScore: 0.52921394,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 0,
                RawSpendingScore: 0.52921394,
                ZENScore: 0.0226924
            ),
            TestZenR(
                ZenDate: "2018-09-29",
                AverageUtilization: 0.09423197,
                RawUtilizationScore: 0.11245032,
                DailyUtilizationScore: 0.52808299,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 0,
                RawSpendingScore: 0.52808299,
                ZENScore: 0.03280022
            ),
            TestZenR(
                ZenDate: "2018-09-30",
                AverageUtilization: 0.09109091,
                RawUtilizationScore: 0.10825019,
                DailyUtilizationScore: 0.52703615,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 0,
                RawSpendingScore: 0.52703615,
                ZENScore: 0.04268493
            ),
            TestZenR(
                ZenDate: "2018-10-01",
                AverageUtilization: 0,
                RawUtilizationScore: 0,
                DailyUtilizationScore: 0.5,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 108.75,
                RawSpendingScore: 0,
                ZENScore: 0.04894882
            ),
            TestZenR(
                ZenDate: "2018-10-02",
                AverageUtilization: 0.85707955,
                RawUtilizationScore: 8.5098926,
                DailyUtilizationScore: 0.99979858,
                UnbudgetedSpendingFactor: 0.06468336,
                TotalSpending: 626.9,
                RawSpendingScore: 0.06467033,
                ZENScore: 0.04926325
            ),
            TestZenR(
                ZenDate: "2018-10-03",
                AverageUtilization: 0.85320455,
                RawUtilizationScore: 8.22582286,
                DailyUtilizationScore: 0.99973242,
                UnbudgetedSpendingFactor: 0.17889088,
                TotalSpending: 111.8,
                RawSpendingScore: 0.17884301,
                ZENScore: 0.05185485
            ),
            TestZenR(
                ZenDate: "2018-10-04",
                AverageUtilization: 0.63990341,
                RawUtilizationScore: 2.24845553,
                DailyUtilizationScore: 0.90451723,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 182.3,
                RawSpendingScore: 0,
                ZENScore: 0.05924249
            ),
            TestZenR(
                ZenDate: "2018-10-05",
                AverageUtilization: 0.99383182,
                RawUtilizationScore: 140.63628404,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 0.2090209,
                TotalSpending: 272.7,
                RawSpendingScore: 0.2090209,
                ZENScore: 0.06223806
            ),
            TestZenR(
                ZenDate: "2018-10-06",
                AverageUtilization: 0.97931818,
                RawUtilizationScore: 64.82181524,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 21.45,
                RawSpendingScore: 1,
                ZENScore: 0.0809933
            ),
            TestZenR(
                ZenDate: "2018-10-07",
                AverageUtilization: 0.83941558,
                RawUtilizationScore: 7.32955422,
                DailyUtilizationScore: 0.99934456,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 0,
                RawSpendingScore: 0.99934456,
                ZENScore: 0.09936032
            ),
            TestZenR(
                ZenDate: "2018-10-08",
                AverageUtilization: 0.84756818,
                RawUtilizationScore: 7.83919724,
                DailyUtilizationScore: 0.99960617,
                UnbudgetedSpendingFactor: 0.03060641,
                TotalSpending: 699.2,
                RawSpendingScore: 0.03059435,
                ZENScore: 0.10763277
            ),
            TestZenR(
                ZenDate: "2018-10-09",
                AverageUtilization: 0.88490909,
                RawUtilizationScore: 11.12810894,
                DailyUtilizationScore: 0.99998531,
                UnbudgetedSpendingFactor: 0.03646546,
                TotalSpending: 767.85,
                RawSpendingScore: 0.03646492,
                ZENScore: 0.11591941
            ),
            TestZenR(
                ZenDate: "2018-10-10",
                AverageUtilization: 0.86405455,
                RawUtilizationScore: 9.06325471,
                DailyUtilizationScore: 0.99988417,
                UnbudgetedSpendingFactor: 0.44137931,
                TotalSpending: 36.25,
                RawSpendingScore: 0.44132818,
                ZENScore: 0.12242759
            ),
            TestZenR(
                ZenDate: "2018-10-11",
                AverageUtilization: 0.85852066,
                RawUtilizationScore: 8.6196281,
                DailyUtilizationScore: 0.99981951,
                UnbudgetedSpendingFactor: 0.18018018,
                TotalSpending: 105.45,
                RawSpendingScore: 0.18014766,
                ZENScore: 0.12358199
            ),
            TestZenR(
                ZenDate: "2018-10-12",
                AverageUtilization: 1.06844318,
                RawUtilizationScore: 29.47415881,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 0.18056497,
                TotalSpending: 442.5,
                RawSpendingScore: 0.18056497,
                ZENScore: 0.12472165
            ),
            TestZenR(
                ZenDate: "2018-10-13",
                AverageUtilization: 0.98625524,
                RawUtilizationScore: 88.47024413,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 44.2,
                RawSpendingScore: 0,
                ZENScore: 0.13824936
            ),
            TestZenR(
                ZenDate: "2018-10-14",
                AverageUtilization: 0.91580844,
                RawUtilizationScore: 16.08658383,
                DailyUtilizationScore: 0.9999999,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 13.4,
                RawSpendingScore: 0,
                ZENScore: 0.15237157
            ),
            TestZenR(
                ZenDate: "2018-10-15",
                AverageUtilization: 0.85475455,
                RawUtilizationScore: 8.3375767,
                DailyUtilizationScore: 0.99976071,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 137.65,
                RawSpendingScore: 0,
                ZENScore: 0.16693219
            ),
            TestZenR(
                ZenDate: "2018-10-16",
                AverageUtilization: 0.96725284,
                RawUtilizationScore: 43.21820377,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 0.87955182,
                TotalSpending: 71.4,
                RawSpendingScore: 0.87955182,
                ZENScore: 0.18118458
            ),
            TestZenR(
                ZenDate: "2018-10-17",
                AverageUtilization: 0.93285963,
                RawUtilizationScore: 20.73916365,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 0.17797443,
                TotalSpending: 50.85,
                RawSpendingScore: 0.17797443,
                ZENScore: 0.18144818
            ),
            TestZenR(
                ZenDate: "2018-10-18",
                AverageUtilization: 0.88103409,
                RawUtilizationScore: 10.6886648,
                DailyUtilizationScore: 0.9999772,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 36.95,
                RawSpendingScore: 0,
                ZENScore: 0.19632527
            ),
            TestZenR(
                ZenDate: "2018-10-19",
                AverageUtilization: 0.93567344,
                RawUtilizationScore: 21.73457281,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 0.1735474,
                TotalSpending: 261.6,
                RawSpendingScore: 0.1735474,
                ZENScore: 0.19803471
            ),
            TestZenR(
                ZenDate: "2018-10-20",
                AverageUtilization: 0.88888977,
                RawUtilizationScore: 11.61186562,
                DailyUtilizationScore: 0.99999094,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 0,
                RawSpendingScore: 0.99999094,
                ZENScore: 0.21407384
            ),
            TestZenR(
                ZenDate: "2018-10-21",
                AverageUtilization: 0.96552922,
                RawUtilizationScore: 41.1683311,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 0.91627907,
                TotalSpending: 64.5,
                RawSpendingScore: 0.91627907,
                ZENScore: 0.22811794
            ),
            TestZenR(
                ZenDate: "2018-10-22",
                AverageUtilization: 1.09419112,
                RawUtilizationScore: 18.59542351,
                DailyUtilizationScore: 0.99999999,
                UnbudgetedSpendingFactor: 0.1875718,
                TotalSpending: 478.75,
                RawSpendingScore: 0.1875718,
                ZENScore: 0.23055929
            ),
            TestZenR(
                ZenDate: "2018-10-23",
                AverageUtilization: 1.08889032,
                RawUtilizationScore: 20.20117683,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 0.05800757,
                TotalSpending: 396.5,
                RawSpendingScore: 0.05800757,
                ZENScore: 0.24075232
            ),
            TestZenR(
                ZenDate: "2018-10-24",
                AverageUtilization: 1.12524716,
                RawUtilizationScore: 12.38547886,
                DailyUtilizationScore: 0.99999582,
                UnbudgetedSpendingFactor: 0.2027972,
                TotalSpending: 228.8,
                RawSpendingScore: 0.20279636,
                ZENScore: 0.24281392
            ),
            TestZenR(
                ZenDate: "2018-10-25",
                AverageUtilization: 1.11963545,
                RawUtilizationScore: 13.22319763,
                DailyUtilizationScore: 0.99999819,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 23.3,
                RawSpendingScore: 0.99999819,
                ZENScore: 0.25795761
            ),
            TestZenR(
                ZenDate: "2018-10-26",
                AverageUtilization: 1.11315472,
                RawUtilizationScore: 14.31612256,
                DailyUtilizationScore: 0.99999939,
                UnbudgetedSpendingFactor: 0.00278655,
                TotalSpending: 8074.5,
                RawSpendingScore: 0.00278655,
                ZENScore: 0.26976857
            ),
            TestZenR(
                ZenDate: "2018-10-27",
                AverageUtilization: 1.07192677,
                RawUtilizationScore: 27.41487384,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 0,
                RawSpendingScore: 1,
                ZENScore: 0.2843732
            ),
            TestZenR(
                ZenDate: "2018-10-28",
                AverageUtilization: 1.03364367,
                RawUtilizationScore: 89.8493137,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 0,
                RawSpendingScore: 1,
                ZENScore: 0.29868573
            ),
            TestZenR(
                ZenDate: "2018-10-29",
                AverageUtilization: 0.99800078,
                RawUtilizationScore: 201.10962966,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 2017.95,
                RawSpendingScore: 0,
                ZENScore: 0.30683388
            ),
            TestZenR(
                ZenDate: "2018-10-30",
                AverageUtilization: 0.97516136,
                RawUtilizationScore: 55.52168569,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 0.06474191,
                TotalSpending: 114.3,
                RawSpendingScore: 0.06474191,
                ZENScore: 0.3125176
            ),
            TestZenR(
                ZenDate: "2018-10-31",
                AverageUtilization: 0.95236364,
                RawUtilizationScore: 29.87694041,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 0.09103943,
                TotalSpending: 69.75,
                RawSpendingScore: 0.09103943,
                ZENScore: 0.31712991
            ),
            TestZenR(
                ZenDate: "2018-11-01",
                AverageUtilization: 0.7425,
                RawUtilizationScore: 3.8218531,
                DailyUtilizationScore: 0.97858159,
                UnbudgetedSpendingFactor: 0.59508197,
                TotalSpending: 30.5,
                RawSpendingScore: 0.58233625,
                ZENScore: 0.32243404
            ),
            TestZenR(
                ZenDate: "2018-11-02",
                AverageUtilization: 0.37125,
                RawUtilizationScore: 0.68354883,
                DailyUtilizationScore: 0.6645303,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 222.2,
                RawSpendingScore: 0,
                ZENScore: 0.32765664
            ),
            TestZenR(
                ZenDate: "2018-11-03",
                AverageUtilization: 0.2475,
                RawUtilizationScore: 0.36858368,
                DailyUtilizationScore: 0.5911167,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 11.85,
                RawSpendingScore: 0,
                ZENScore: 0.33216528
            ),
            TestZenR(
                ZenDate: "2018-11-04",
                AverageUtilization: 0.185625,
                RawUtilizationScore: 0.25161994,
                DailyUtilizationScore: 0.56257518,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 40.95,
                RawSpendingScore: 0,
                ZENScore: 0.33603706
            ),
            TestZenR(
                ZenDate: "2018-11-05",
                AverageUtilization: 0.1485,
                RawUtilizationScore: 0.19084933,
                DailyUtilizationScore: 0.54756804,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 124,
                RawSpendingScore: 0,
                ZENScore: 0.33934682
            ),
            TestZenR(
                ZenDate: "2018-11-06",
                AverageUtilization: 0.27102273,
                RawUtilizationScore: 0.41910822,
                DailyUtilizationScore: 0.60326983,
                UnbudgetedSpendingFactor: 0.1321505,
                TotalSpending: 163.45,
                RawSpendingScore: 0.07972241,
                ZENScore: 0.34150295
            ),
            TestZenR(
                ZenDate: "2018-11-07",
                AverageUtilization: 0.27438312,
                RawUtilizationScore: 0.42663376,
                DailyUtilizationScore: 0.60506955,
                UnbudgetedSpendingFactor: 0.08581645,
                TotalSpending: 83.9,
                RawSpendingScore: 0.05192492,
                ZENScore: 0.34361647
            ),
            TestZenR(
                ZenDate: "2018-11-08",
                AverageUtilization: 0.38505682,
                RawUtilizationScore: 0.72769587,
                DailyUtilizationScore: 0.67429944,
                UnbudgetedSpendingFactor: 0.03126034,
                TotalSpending: 906.9,
                RawSpendingScore: 0.02107883,
                ZENScore: 0.34565243
            ),
            TestZenR(
                ZenDate: "2018-11-09",
                AverageUtilization: 0.50886364,
                RawUtilizationScore: 1.25011558,
                DailyUtilizationScore: 0.77731987,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 36.65,
                RawSpendingScore: 0.77731987,
                ZENScore: 0.35428578
            ),
            TestZenR(
                ZenDate: "2018-11-10",
                AverageUtilization: 0.80856818,
                RawUtilizationScore: 5.80768743,
                DailyUtilizationScore: 0.99700463,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 85.7,
                RawSpendingScore: 0.99700463,
                ZENScore: 0.36714016
            ),
            TestZenR(
                ZenDate: "2018-11-11",
                AverageUtilization: 0.73506198,
                RawUtilizationScore: 3.66359069,
                DailyUtilizationScore: 0.97500071,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 0,
                RawSpendingScore: 0.97500071,
                ZENScore: 0.37929737
            ),
            TestZenR(
                ZenDate: "2018-11-12",
                AverageUtilization: 1.00534091,
                RawUtilizationScore: 618.44129582,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 0.53596032,
                TotalSpending: 181.45,
                RawSpendingScore: 0.53596032,
                ZENScore: 0.38243063
            ),
            TestZenR(
                ZenDate: "2018-11-13",
                AverageUtilization: 1.02241259,
                RawUtilizationScore: 196.9467833,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 0.80645161,
                TotalSpending: 37.2,
                RawSpendingScore: 0.80645161,
                ZENScore: 0.39091105
            ),
            TestZenR(
                ZenDate: "2018-11-14",
                AverageUtilization: 1.01191558,
                RawUtilizationScore: 1969.95618499,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 21.4,
                RawSpendingScore: 1,
                ZENScore: 0.40309282
            ),
            TestZenR(
                ZenDate: "2018-11-15",
                AverageUtilization: 1.02777273,
                RawUtilizationScore: 127.23827524,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 0.16032537,
                TotalSpending: 190.55,
                RawSpendingScore: 0.16032537,
                ZENScore: 0.39788708
            ),
            TestZenR(
                ZenDate: "2018-11-16",
                AverageUtilization: 0.96353693,
                RawUtilizationScore: 39.00608723,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 0,
                RawSpendingScore: 1,
                ZENScore: 0.40992934
            ),
            TestZenR(
                ZenDate: "2018-11-17",
                AverageUtilization: 0.90685829,
                RawUtilizationScore: 14.31312945,
                DailyUtilizationScore: 0.99999939,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 0,
                RawSpendingScore: 0.99999939,
                ZENScore: 0.42173074
            ),
            TestZenR(
                ZenDate: "2018-11-18",
                AverageUtilization: 0.85647727,
                RawUtilizationScore: 8.46470371,
                DailyUtilizationScore: 0.99978927,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 0,
                RawSpendingScore: 0.99978927,
                ZENScore: 0.43329191
            ),
            TestZenR(
                ZenDate: "2018-11-19",
                AverageUtilization: 0.81139952,
                RawUtilizationScore: 5.92574537,
                DailyUtilizationScore: 0.99733729,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 79.95,
                RawSpendingScore: 0,
                ZENScore: 0.41789435
            ),
            TestZenR(
                ZenDate: "2018-11-20",
                AverageUtilization: 0.808875,
                RawUtilizationScore: 5.82030368,
                DailyUtilizationScore: 0.99704207,
                UnbudgetedSpendingFactor: 0.28904429,
                TotalSpending: 64.35,
                RawSpendingScore: 0.28818932,
                ZENScore: 0.41421713
            ),
            TestZenR(
                ZenDate: "2018-11-21",
                AverageUtilization: 0.83649351,
                RawUtilizationScore: 7.15969886,
                DailyUtilizationScore: 0.99922332,
                UnbudgetedSpendingFactor: 0.85624212,
                TotalSpending: 39.65,
                RawSpendingScore: 0.85557709,
                ZENScore: 0.42304433
            ),
            TestZenR(
                ZenDate: "2018-11-22",
                AverageUtilization: 0.8418905,
                RawUtilizationScore: 7.47851446,
                DailyUtilizationScore: 0.99943522,
                UnbudgetedSpendingFactor: 0.31833674,
                TotalSpending: 73.35,
                RawSpendingScore: 0.31815695,
                ZENScore: 0.41981862
            ),
            TestZenR(
                ZenDate: "2018-11-23",
                AverageUtilization: 1.03393281,
                RawUtilizationScore: 88.52611396,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 0.9335512,
                TotalSpending: 137.7,
                RawSpendingScore: 0.9335512,
                ZENScore: 0.43009327
            ),
            TestZenR(
                ZenDate: "2018-11-24",
                AverageUtilization: 1.17213068,
                RawUtilizationScore: 7.82381966,
                DailyUtilizationScore: 0.99960007,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 106.35,
                RawSpendingScore: 0.99960007,
                ZENScore: 0.4414834
            ),
            TestZenR(
                ZenDate: "2018-11-25",
                AverageUtilization: 1.29927273,
                RawUtilizationScore: 3.30070664,
                DailyUtilizationScore: 0.96445304,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 106.35,
                RawSpendingScore: 0.96445304,
                ZENScore: 0.4519428
            ),
            TestZenR(
                ZenDate: "2018-11-26",
                AverageUtilization: 1.31861014,
                RawUtilizationScore: 2.9624063,
                DailyUtilizationScore: 0.95084658,
                UnbudgetedSpendingFactor: 0.38589575,
                TotalSpending: 114.15,
                RawSpendingScore: 0.36692766,
                ZENScore: 0.44818173
            ),
            TestZenR(
                ZenDate: "2018-11-27",
                AverageUtilization: 1.33401515,
                RawUtilizationScore: 2.7242402,
                DailyUtilizationScore: 0.93844194,
                UnbudgetedSpendingFactor: 0.00501443,
                TotalSpending: 8455.6,
                RawSpendingScore: 0.00470575,
                ZENScore: 0.42934074
            ),
            TestZenR(
                ZenDate: "2018-11-28",
                AverageUtilization: 1.30638799,
                RawUtilizationScore: 3.17062849,
                DailyUtilizationScore: 0.95971389,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 13.7,
                RawSpendingScore: 0.95971389,
                ZENScore: 0.4399482
            ),
            TestZenR(
                ZenDate: "2018-11-29",
                AverageUtilization: 1.26938088,
                RawUtilizationScore: 3.93293746,
                DailyUtilizationScore: 0.98079019,
                UnbudgetedSpendingFactor: 0.17592593,
                TotalSpending: 32.4,
                RawSpendingScore: 0.17254642,
                ZENScore: 0.42961513
            ),
            TestZenR(
                ZenDate: "2018-11-30",
                AverageUtilization: 1.23429545,
                RawUtilizationScore: 4.91312534,
                DailyUtilizationScore: 0.99270414,
                UnbudgetedSpendingFactor: 0.38129496,
                TotalSpending: 13.9,
                RawSpendingScore: 0.37851309,
                ZENScore: 0.42788684
            ),
            TestZenR(
                ZenDate: "2018-12-01",
                AverageUtilization: 0,
                RawUtilizationScore: 0,
                DailyUtilizationScore: 0.5,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 0,
                RawSpendingScore: 0.5,
                ZENScore: 0.4293291
            ),
            TestZenR(
                ZenDate: "2018-12-02",
                AverageUtilization: 0,
                RawUtilizationScore: 0,
                DailyUtilizationScore: 0.5,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 57.05,
                RawSpendingScore: 0,
                ZENScore: 0.41486633
            ),
            TestZenR(
                ZenDate: "2018-12-03",
                AverageUtilization: 0,
                RawUtilizationScore: 0,
                DailyUtilizationScore: 0.5,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 152,
                RawSpendingScore: 0,
                ZENScore: 0.40369082
            ),
            TestZenR(
                ZenDate: "2018-12-04",
                AverageUtilization: 0.09722727,
                RawUtilizationScore: 0.11648788,
                DailyUtilizationScore: 0.52908908,
                UnbudgetedSpendingFactor: 0.00356278,
                TotalSpending: 2582.25,
                RawSpendingScore: 0.00188503,
                ZENScore: 0.39496264
            ),
            TestZenR(
                ZenDate: "2018-12-05",
                AverageUtilization: 0.62859545,
                RawUtilizationScore: 2.13178906,
                DailyUtilizationScore: 0.89395473,
                UnbudgetedSpendingFactor: 0.83472133,
                TotalSpending: 78.05,
                RawSpendingScore: 0.74620308,
                ZENScore: 0.40198745
            ),
            TestZenR(
                ZenDate: "2018-12-06",
                AverageUtilization: 0.61401136,
                RawUtilizationScore: 1.99224852,
                DailyUtilizationScore: 0.87998082,
                UnbudgetedSpendingFactor: 0.34408602,
                TotalSpending: 37.2,
                RawSpendingScore: 0.3027891,
                ZENScore: 0.39991148
            ),
            TestZenR(
                ZenDate: "2018-12-07",
                AverageUtilization: 1.26153896,
                RawUtilizationScore: 4.12612968,
                DailyUtilizationScore: 0.98411128,
                UnbudgetedSpendingFactor: 0.47493661,
                TotalSpending: 256.35,
                RawSpendingScore: 0.46739048,
                ZENScore: 0.40126106
            ),
            TestZenR(
                ZenDate: "2018-12-08",
                AverageUtilization: 1.10384659,
                RawUtilizationScore: 16.17892958,
                DailyUtilizationScore: 0.99999991,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 90.2,
                RawSpendingScore: 0,
                ZENScore: 0.3929997
            ),
            TestZenR(
                ZenDate: "2018-12-09",
                AverageUtilization: 1.03615152,
                RawUtilizationScore: 79.44104599,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 0.27561837,
                TotalSpending: 42.45,
                RawSpendingScore: 0.27561837,
                ZENScore: 0.39103553
            ),
            TestZenR(
                ZenDate: "2018-12-10",
                AverageUtilization: 0.99932727,
                RawUtilizationScore: 231.34750448,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 0.01734834,
                TotalSpending: 910.75,
                RawSpendingScore: 0.01734834,
                ZENScore: 0.38512508
            ),
            TestZenR(
                ZenDate: "2018-12-11",
                AverageUtilization: 0.90847934,
                RawUtilizationScore: 14.60888648,
                DailyUtilizationScore: 0.99999955,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 212.2,
                RawSpendingScore: 0,
                ZENScore: 0.38009597
            ),
            TestZenR(
                ZenDate: "2018-12-12",
                AverageUtilization: 0.83277273,
                RawUtilizationScore: 6.95233332,
                DailyUtilizationScore: 0.99904451,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 240.2,
                RawSpendingScore: 0,
                ZENScore: 0.37602459
            ),
            TestZenR(
                ZenDate: "2018-12-13",
                AverageUtilization: 1.04397378,
                RawUtilizationScore: 57.65945786,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 0.3460045,
                TotalSpending: 244.65,
                RawSpendingScore: 0.3460045,
                ZENScore: 0.37576007
            ),
            TestZenR(
                ZenDate: "2018-12-14",
                AverageUtilization: 2.28559578,
                RawUtilizationScore: -0.59615136,
                DailyUtilizationScore: 0.3552247,
                UnbudgetedSpendingFactor: 0.68440886,
                TotalSpending: 636.9,
                RawSpendingScore: 0.24311893,
                ZENScore: 0.37460768
            ),
            TestZenR(
                ZenDate: "2018-12-15",
                AverageUtilization: 2.84312273,
                RawUtilizationScore: -0.96861343,
                DailyUtilizationScore: 0.27515696,
                UnbudgetedSpendingFactor: 0.52110054,
                TotalSpending: 483.4,
                RawSpendingScore: 0.14338444,
                ZENScore: 0.37272315
            ),
            TestZenR(
                ZenDate: "2018-12-16",
                AverageUtilization: 3.18485369,
                RawUtilizationScore: -1.12867914,
                DailyUtilizationScore: 0.24440494,
                UnbudgetedSpendingFactor: 0.93219535,
                TotalSpending: 210.9,
                RawSpendingScore: 0.22783315,
                ZENScore: 0.37166969
            ),
            TestZenR(
                ZenDate: "2018-12-17",
                AverageUtilization: 3.14670722,
                RawUtilizationScore: -1.11220958,
                DailyUtilizationScore: 0.24745918,
                UnbudgetedSpendingFactor: 0.27447392,
                TotalSpending: 218.6,
                RawSpendingScore: 0.06792109,
                ZENScore: 0.36961052
            ),
            TestZenR(
                ZenDate: "2018-12-18",
                AverageUtilization: 2.97189015,
                RawUtilizationScore: -1.03259739,
                DailyUtilizationScore: 0.26258086,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 88.05,
                RawSpendingScore: 0,
                ZENScore: 0.36746003
            ),
            TestZenR(
                ZenDate: "2018-12-19",
                AverageUtilization: 2.83460885,
                RawUtilizationScore: -0.9641904,
                DailyUtilizationScore: 0.27603999,
                UnbudgetedSpendingFactor: 0.11154345,
                TotalSpending: 77.1,
                RawSpendingScore: 0.03079045,
                ZENScore: 0.36583908
            ),
            TestZenR(
                ZenDate: "2018-12-20",
                AverageUtilization: 3.68417386,
                RawUtilizationScore: -1.32413296,
                DailyUtilizationScore: 0.2101315,
                UnbudgetedSpendingFactor: 0.92295582,
                TotalSpending: 508.15,
                RawSpendingScore: 0.19394209,
                ZENScore: 0.36514148
            ),
            TestZenR(
                ZenDate: "2018-12-21",
                AverageUtilization: 3.50873701,
                RawUtilizationScore: -1.25890875,
                DailyUtilizationScore: 0.2211618,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 74.1,
                RawSpendingScore: 0,
                ZENScore: 0.36377852
            ),
            TestZenR(
                ZenDate: "2018-12-22",
                AverageUtilization: 3.34924897,
                RawUtilizationScore: -1.19668782,
                DailyUtilizationScore: 0.23206496,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 216.6,
                RawSpendingScore: 0,
                ZENScore: 0.36265203
            ),
            TestZenR(
                ZenDate: "2018-12-23",
                AverageUtilization: 3.20362945,
                RawUtilizationScore: -1.13668215,
                DailyUtilizationScore: 0.24293004,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 0,
                RawSpendingScore: 0.24293004,
                ZENScore: 0.36234423
            ),
            TestZenR(
                ZenDate: "2018-12-24",
                AverageUtilization: 3.07014489,
                RawUtilizationScore: -1.07823577,
                DailyUtilizationScore: 0.25384003,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 6807.9,
                RawSpendingScore: 0,
                ZENScore: 0.36146471
            ),
            TestZenR(
                ZenDate: "2018-12-25",
                AverageUtilization: 2.94733909,
                RawUtilizationScore: -1.02079085,
                DailyUtilizationScore: 0.26487338,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 30.75,
                RawSpendingScore: 0,
                ZENScore: 0.36073568
            ),
            TestZenR(
                ZenDate: "2018-12-26",
                AverageUtilization: 2.87015559,
                RawUtilizationScore: -0.98248882,
                DailyUtilizationScore: 0.27239823,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 22.25,
                RawSpendingScore: 0.27239823,
                ZENScore: 0.36058757
            ),
            TestZenR(
                ZenDate: "2018-12-27",
                AverageUtilization: 2.76385354,
                RawUtilizationScore: -0.92637969,
                DailyUtilizationScore: 0.28365977,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 8020.5,
                RawSpendingScore: 0,
                ZENScore: 0.36000791
            ),
            TestZenR(
                ZenDate: "2018-12-28",
                AverageUtilization: 2.83098945,
                RawUtilizationScore: -0.96230219,
                DailyUtilizationScore: 0.27641749,
                UnbudgetedSpendingFactor: 0.70939619,
                TotalSpending: 154.85,
                RawSpendingScore: 0.19608952,
                ZENScore: 0.35978875
            ),
            TestZenR(
                ZenDate: "2018-12-29",
                AverageUtilization: 2.73336912,
                RawUtilizationScore: -0.90946719,
                DailyUtilizationScore: 0.28710888,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 458.35,
                RawSpendingScore: 0,
                ZENScore: 0.3593445
            ),
            TestZenR(
                ZenDate: "2018-12-30",
                AverageUtilization: 2.71102045,
                RawUtilizationScore: -0.89681041,
                DailyUtilizationScore: 0.2897064,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 48.8,
                RawSpendingScore: 0.2897064,
                ZENScore: 0.35927295
            ),
            TestZenR(
                ZenDate: "2018-12-31",
                AverageUtilization: 2.64129545,
                RawUtilizationScore: -0.85579977,
                DailyUtilizationScore: 0.29821764,
                UnbudgetedSpendingFactor: 0.0018107,
                TotalSpending: 7179.55,
                RawSpendingScore: 0.00053998,
                ZENScore: 0.35891636
            ),
            TestZenR(
                ZenDate: "2019-01-01",
                AverageUtilization: 0,
                RawUtilizationScore: 0,
                DailyUtilizationScore: 0.5,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 0,
                RawSpendingScore: 0.5,
                ZENScore: 0.36173803
            ),
            TestZenR(
                ZenDate: "2019-01-02",
                AverageUtilization: 0,
                RawUtilizationScore: 0,
                DailyUtilizationScore: 0.5,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 610.05,
                RawSpendingScore: 0,
                ZENScore: 0.36096231
            ),
            TestZenR(
                ZenDate: "2019-01-03",
                AverageUtilization: 0.19163636,
                RawUtilizationScore: 0.2620753,
                DailyUtilizationScore: 0.56514638,
                UnbudgetedSpendingFactor: 0.06500956,
                TotalSpending: 209.2,
                RawSpendingScore: 0.03673992,
                ZENScore: 0.36038442
            ),
            TestZenR(
                ZenDate: "2019-01-04",
                AverageUtilization: 0.32232955,
                RawUtilizationScore: 0.54336866,
                DailyUtilizationScore: 0.63259571,
                UnbudgetedSpendingFactor: 0.37430786,
                TotalSpending: 45.15,
                RawSpendingScore: 0.23678555,
                ZENScore: 0.36019744
            ),
            TestZenR(
                ZenDate: "2019-01-05",
                AverageUtilization: 0.25786364,
                RawUtilizationScore: 0.39039009,
                DailyUtilizationScore: 0.5963766,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 0,
                RawSpendingScore: 0.5963766,
                ZENScore: 0.36492103
            ),
            TestZenR(
                ZenDate: "2019-01-06",
                AverageUtilization: 0.21488636,
                RawUtilizationScore: 0.30427206,
                DailyUtilizationScore: 0.57548652,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 0,
                RawSpendingScore: 0.57548652,
                ZENScore: 0.36913234
            ),
            TestZenR(
                ZenDate: "2019-01-07",
                AverageUtilization: 0.82099675,
                RawUtilizationScore: 6.35506175,
                DailyUtilizationScore: 0.99826509,
                UnbudgetedSpendingFactor: 0.39344079,
                TotalSpending: 268.02,
                RawSpendingScore: 0.3927582,
                ZENScore: 0.36960485
            ),
            TestZenR(
                ZenDate: "2019-01-08",
                AverageUtilization: 0.78363068,
                RawUtilizationScore: 4.90748395,
                DailyUtilizationScore: 0.99266317,
                UnbudgetedSpendingFactor: 0.34449093,
                TotalSpending: 35.85,
                RawSpendingScore: 0.34196346,
                ZENScore: 0.3694441
            ),
            TestZenR(
                ZenDate: "2019-01-09",
                AverageUtilization: 0.7512803,
                RawUtilizationScore: 4.02168043,
                DailyUtilizationScore: 0.98239275,
                UnbudgetedSpendingFactor: 0.00237126,
                TotalSpending: 4913,
                RawSpendingScore: 0.00232951,
                ZENScore: 0.36733665
            ),
            TestZenR(
                ZenDate: "2019-01-10",
                AverageUtilization: 0.73406591,
                RawUtilizationScore: 3.64311295,
                DailyUtilizationScore: 0.97449669,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 13.7,
                RawSpendingScore: 0.97449669,
                ZENScore: 0.37947985
            ),
            TestZenR(
                ZenDate: "2019-01-11",
                AverageUtilization: 0.66733264,
                RawUtilizationScore: 2.56732612,
                DailyUtilizationScore: 0.92872891,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 0,
                RawSpendingScore: 0.92872891,
                ZENScore: 0.39046483
            ),
            TestZenR(
                ZenDate: "2019-01-12",
                AverageUtilization: 0.61172159,
                RawUtilizationScore: 1.97137377,
                DailyUtilizationScore: 0.87775859,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 160,
                RawSpendingScore: 0,
                ZENScore: 0.38439301
            ),
            TestZenR(
                ZenDate: "2019-01-13",
                AverageUtilization: 1.08657168,
                RawUtilizationScore: 20.98082204,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 160.5,
                RawSpendingScore: 1,
                ZENScore: 0.39670515
            ),
            TestZenR(
                ZenDate: "2019-01-14",
                AverageUtilization: 1.00895942,
                RawUtilizationScore: 3436.20748106,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 343.05,
                RawSpendingScore: 0,
                ZENScore: 0.38938102
            ),
            TestZenR(
                ZenDate: "2019-01-15",
                AverageUtilization: 1.00792273,
                RawUtilizationScore: 1581.93143677,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 0.52222222,
                TotalSpending: 45,
                RawSpendingScore: 0.52222222,
                ZENScore: 0.39203784
            ),
            TestZenR(
                ZenDate: "2019-01-16",
                AverageUtilization: 0.99618324,
                RawUtilizationScore: 169.84474986,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 0.72932331,
                TotalSpending: 26.6,
                RawSpendingScore: 0.72932331,
                ZENScore: 0.39878355
            ),
            TestZenR(
                ZenDate: "2019-01-17",
                AverageUtilization: 0.94491979,
                RawUtilizationScore: 25.67856179,
                DailyUtilizationScore: 1,
                UnbudgetedSpendingFactor: 0.12688172,
                TotalSpending: 23.25,
                RawSpendingScore: 0.12688172,
                ZENScore: 0.39349987
            ),
            TestZenR(
                ZenDate: "2019-01-18",
                AverageUtilization: 0.89242424,
                RawUtilizationScore: 12.0716995,
                DailyUtilizationScore: 0.99999428,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 28.35,
                RawSpendingScore: 0,
                ZENScore: 0.38682351
            ),
            TestZenR(
                ZenDate: "2019-01-19",
                AverageUtilization: 0.84545455,
                RawUtilizationScore: 7.70172022,
                DailyUtilizationScore: 0.99954816,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 0,
                RawSpendingScore: 0.99954816,
                ZENScore: 0.399078
            ),
            TestZenR(
                ZenDate: "2019-01-20",
                AverageUtilization: 0.80318182,
                RawUtilizationScore: 5.59291675,
                DailyUtilizationScore: 0.99628967,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 0,
                RawSpendingScore: 0.99628967,
                ZENScore: 0.41102224
            ),
            TestZenR(
                ZenDate: "2019-01-21",
                AverageUtilization: 0.78415909,
                RawUtilizationScore: 4.92429142,
                DailyUtilizationScore: 0.99278457,
                UnbudgetedSpendingFactor: 0.24934726,
                TotalSpending: 38.3,
                RawSpendingScore: 0.24754811,
                ZENScore: 0.40691189
            ),
            TestZenR(
                ZenDate: "2019-01-22",
                AverageUtilization: 0.7631188,
                RawUtilizationScore: 4.31611148,
                DailyUtilizationScore: 0.98682422,
                UnbudgetedSpendingFactor: 0.32478632,
                TotalSpending: 23.4,
                RawSpendingScore: 0.32050701,
                ZENScore: 0.40490509
            ),
            TestZenR(
                ZenDate: "2019-01-23",
                AverageUtilization: 0.76789328,
                RawUtilizationScore: 4.44389222,
                DailyUtilizationScore: 0.98838635,
                UnbudgetedSpendingFactor: 0.5042735,
                TotalSpending: 40.95,
                RawSpendingScore: 0.49841705,
                ZENScore: 0.40677533
            ),
            TestZenR(
                ZenDate: "2019-01-24",
                AverageUtilization: 0.75888352,
                RawUtilizationScore: 4.20724908,
                DailyUtilizationScore: 0.98533111,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 13.05,
                RawSpendingScore: 0.98533111,
                ZENScore: 0.41834644
            ),
            TestZenR(
                ZenDate: "2019-01-25",
                AverageUtilization: 0.75473727,
                RawUtilizationScore: 4.10453772,
                DailyUtilizationScore: 0.98377011,
                UnbudgetedSpendingFactor: 0.00190643,
                TotalSpending: 8130.4,
                RawSpendingScore: 0.00187548,
                ZENScore: 0.40645134
            ),
            TestZenR(
                ZenDate: "2019-01-26",
                AverageUtilization: 0.7620472,
                RawUtilizationScore: 4.28817874,
                DailyUtilizationScore: 0.98645605,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 22.35,
                RawSpendingScore: 0.98645605,
                ZENScore: 0.41805143
            ),
            TestZenR(
                ZenDate: "2019-01-27",
                AverageUtilization: 0.75730808,
                RawUtilizationScore: 4.16778292,
                DailyUtilizationScore: 0.98474962,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 15,
                RawSpendingScore: 0.98474962,
                ZENScore: 0.42938539
            ),
            TestZenR(
                ZenDate: "2019-01-28",
                AverageUtilization: 0.7446039,
                RawUtilizationScore: 3.86840287,
                DailyUtilizationScore: 0.97953582,
                UnbudgetedSpendingFactor: 0.35055351,
                TotalSpending: 27.1,
                RawSpendingScore: 0.34337972,
                ZENScore: 0.42648587
            ),
            TestZenR(
                ZenDate: "2019-01-29",
                AverageUtilization: 0.73292163,
                RawUtilizationScore: 3.61978947,
                DailyUtilizationScore: 0.97391058,
                UnbudgetedSpendingFactor: 0.064,
                TotalSpending: 150,
                RawSpendingScore: 0.06233028,
                ZENScore: 0.41470177
            ),
            TestZenR(
                ZenDate: "2019-01-30",
                AverageUtilization: 0.74301364,
                RawUtilizationScore: 3.83314267,
                DailyUtilizationScore: 0.97881694,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 24.5,
                RawSpendingScore: 0.97881694,
                ZENScore: 0.42598407
            ),
            TestZenR(
                ZenDate: "2019-01-31",
                AverageUtilization: 0.71904545,
                RawUtilizationScore: 3.35306875,
                DailyUtilizationScore: 0.96620518,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 32,
                RawSpendingScore: 0,
                ZENScore: 0.41229895
            ),
            TestZenR(
                ZenDate: "2019-02-01",
                AverageUtilization: 0,
                RawUtilizationScore: 0,
                DailyUtilizationScore: 0.5,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 1240.2,
                RawSpendingScore: 0,
                ZENScore: 0.40168658
            ),
            TestZenR(
                ZenDate: "2019-02-02",
                AverageUtilization: 0,
                RawUtilizationScore: 0,
                DailyUtilizationScore: 0.5,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 11.85,
                RawSpendingScore: 0,
                ZENScore: 0.39333669
            ),
            TestZenR(
                ZenDate: "2019-02-03",
                AverageUtilization: 0,
                RawUtilizationScore: 0,
                DailyUtilizationScore: 0.5,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 0,
                RawSpendingScore: 0.5,
                ZENScore: 0.39546996
            ),
            TestZenR(
                ZenDate: "2019-02-04",
                AverageUtilization: 0,
                RawUtilizationScore: 0,
                DailyUtilizationScore: 0.5,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 146.55,
                RawSpendingScore: 0,
                ZENScore: 0.38839659
            ),
            TestZenR(
                ZenDate: "2019-02-05",
                AverageUtilization: 0,
                RawUtilizationScore: 0,
                DailyUtilizationScore: 0.5,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 0,
                RawSpendingScore: 0.5,
                ZENScore: 0.39062866
            ),
            TestZenR(
                ZenDate: "2019-02-06",
                AverageUtilization: 0,
                RawUtilizationScore: 0,
                DailyUtilizationScore: 0.5,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 160,
                RawSpendingScore: 0,
                ZENScore: 0.38452442
            ),
            TestZenR(
                ZenDate: "2019-02-07",
                AverageUtilization: 0,
                RawUtilizationScore: 0,
                DailyUtilizationScore: 0.5,
                UnbudgetedSpendingFactor: 1,
                TotalSpending: 0,
                RawSpendingScore: 0.5,
                ZENScore: 0.38683393
            ),
            TestZenR(
                ZenDate: "2019-02-08",
                AverageUtilization: 0,
                RawUtilizationScore: 0,
                DailyUtilizationScore: 0.5,
                UnbudgetedSpendingFactor: 0,
                TotalSpending: 1576.5,
                RawSpendingScore: 0,
                ZENScore: 0.38147402
            )
        ]
        
        ZenItemsFull = zenData.map { ZenItem(DateSince1970: ZenUtils.daySince1970(date: dateFormatter.date(from: $0.ZenDate)!),
                                        AverageUtilisation: $0.AverageUtilization,
                                        RawUtilisatinScore: $0.RawUtilizationScore,
                                        DailyUtilizationScore: $0.DailyUtilizationScore,
                                        UnbudgetedSpendingFactor: $0.UnbudgetedSpendingFactor,
                                        TotalSpending: $0.TotalSpending,
                                        ZenScore: $0.ZENScore) }
    }
}
		
internal struct TestTransactionR {
    internal var Date: String
    internal var Category: String
    internal var Amount: Decimal
}

internal struct TestZenR {
    internal var ZenDate: String
    internal var AverageUtilization: Decimal
    internal var RawUtilizationScore: Decimal
    internal var DailyUtilizationScore: Decimal
    internal var UnbudgetedSpendingFactor: Decimal
    internal var TotalSpending: Decimal
    internal var RawSpendingScore: Decimal = 0
    internal var ZENScore: Decimal = 0
}
