//
//  ZenParams.swift
//  SmartCarrotFramework
//
//  Copyright © 2020 CarrotLabs gmbh. All rights reserved.
//

import Foundation

/**
 ZenScore Parameters
 */
public struct ZenParams {
    internal static let STRIKE_DATA : ([(Int, Decimal)]) = [
        (TransactionCategory(String().c.l.o.t.h.e.s).getIntId() , 0.0351),
        (TransactionCategory(String().f.e.e.s.underscore.t.a.x.underscore.c.h.a.r.g.e.s).getIntId() , 0.0786),
        (TransactionCategory(String().g.r.o.c.e.r.i.e.s).getIntId() , 0.1523),
        (TransactionCategory(String().h.e.a.l.t.h).getIntId() , 0.0222),
        (TransactionCategory(String().h.e.a.l.t.h.underscore.i.n.s.u.r.a.n.c.e).getIntId() , 0.1536),
        (TransactionCategory(String().h.o.u.s.e.h.o.l.d.underscore.i.n.s.u.r.a.n.c.e).getIntId() , 0.0071),
        (TransactionCategory(String().h.o.u.s.e.h.o.l.d.underscore.s.u.p.p.l.i.e.s).getIntId() , 0.0283),
        (TransactionCategory(String().l.e.i.s.u.r.e.underscore.s.h.o.p.p.i.n.g).getIntId() , 0.0407),
        (TransactionCategory(String().m.i.s.c).getIntId() , 0.1514),
        (TransactionCategory(String().m.o.b.i.l.i.t.y).getIntId() , 0.0226),
        (TransactionCategory(String().h.o.u.s.e.h.o.l.d).getIntId() , 0.025),
        (TransactionCategory(String().h.o.u.s.i.n.g).getIntId() , 0.2619),
        (TransactionCategory(String().l.e.i.s.u.r.e.underscore.s.h.o.p.p.i.n.g).getIntId() , 0.0088),
        (TransactionCategory(String().h.o.u.s.i.n.g).getIntId() , 0.0098),
        (TransactionCategory(String().h.o.u.s.e.h.o.l.d).getIntId() , 0.0035)
        
        
//        (TransactionCategory("clothes").getIntId() , 0.0351),
//        (TransactionCategory("fees_tax_charges").getIntId() , 0.0786),
//        (TransactionCategory("groceries").getIntId() , 0.1523),
//        (TransactionCategory("health").getIntId() , 0.0222),
//        (TransactionCategory("health_insurance").getIntId() , 0.1536),
//        (TransactionCategory("household_insurance").getIntId() , 0.0071),
//        (TransactionCategory("household_supplies").getIntId() , 0.0283),
//        (TransactionCategory("leisure_shopping").getIntId() , 0.0407),
//        (TransactionCategory("misc").getIntId() , 0.1514),
//        (TransactionCategory("mobility").getIntId() , 0.0226),
//        (TransactionCategory("household").getIntId() , 0.025),
//        (TransactionCategory("housing").getIntId() , 0.2619),
//        (TransactionCategory("leisure_shopping").getIntId() , 0.0088),
//        (TransactionCategory("housing").getIntId() , 0.0098),
//        (TransactionCategory("household").getIntId() , 0.0035)
    ]
    
    internal static let alpha : Decimal = 0.99
    internal static let beta : Decimal = 0.15
    internal static let gamma : Decimal = 1.2
    internal static let delta : Decimal = 3
    internal static let minSalary : Decimal = 6000
    internal static let kickInPoint : Decimal = 0.4
    internal static let finalValue : Decimal = 0.7
    
#if DEBUG
    // this value should be uncommented for tests
    internal static let lambda : Decimal = 0.98
#else
    internal static let lambda : Decimal = 0.95
#endif
    
    /// I MUST BE MADE INTERNAL !!!
//    public static var alpha : Decimal = 0.99
//    public static var beta : Decimal = 0.15
//    public static var gamma : Decimal = 1.2
//    public static var delta : Decimal = 3
//    public static var lambda : Decimal = 0.98
//    public static var minSalary : Decimal = 6000
//    public static var kickInPoint : Decimal = 0.1
//    public static var finalValue : Decimal = 0.5
    
    internal static func getStrike(categoryId: Int) -> Decimal {
        let strike = STRIKE_DATA.filter { $0.0 == categoryId }
        if strike.count > 0 {
            return strike[0].1
        } else {
            return 0.05
        }
    }
    
    /**
     Maximum `ZenScore` sequence calculation time interval in days.
     */
    public static let MAX_INTERVAL = 3 * 365
}
