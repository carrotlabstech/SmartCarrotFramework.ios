	//
//  Category.swift
//  SmartCarrotFramework
//
//  Copyright © 2019 CarrotLabs gmbh. All rights reserved.
//

import Foundation

/**
    The type used for Transaction Categories, their hierarchies, identfiers and id mappings.
*/
public struct TransactionCategory {
    /// Category String Id
    public var idName:String
    /// Uncategorised category idName : `String`
    public static let UNCATEGORISED_IDNAME:String = "not_categorized"
    /// Uncategorised `TransactionCategory`
    public static let UNCATEGORISED:TransactionCategory = TransactionCategory()
    /// Uncategorised category id : `Int`
    public static let UNCATEGORISED_INT_ID = 104
    /// Number of supported categories
    public static let NUMBER_OF_CATEGORIES = 108
    
    /// :nodoc:
    public static let DEFAULT_GOAL_ID = "goal"
    
    /**
     Public constructor. if the category `id` is not set then category is initialised to the `UNCATEGORISED`.
     
     - Parameter idName: Transaction Category String id
     
     - Returns: A TransactionCategory struct.
     */
    public init(_ idName: String?) {
        if let idval = idName	 {
            self.idName = idval
        } else {
            self.idName = TransactionCategory.UNCATEGORISED_IDNAME
        }
    }

    /**
     Public constructor. if the category `id` is not set then category is initialised to the `UNCATEGORISED`.
     
     - Parameter intId: Transaction Category int id
     
     - Returns: A TransactionCategory struct.
     */
    public init(_ intId: Int?) {
        if let intIdVal = intId {
            self.idName = TransactionCategory.getCategory(intId: intIdVal).idName
        } else {
            self.idName = TransactionCategory.UNCATEGORISED_IDNAME
        }
    }
    
    /**
     Public constructor.
     
     Returns: The `UNCATEGORISED` Transaction Category.
     */
    public init() {
        self.init(TransactionCategory.UNCATEGORISED_IDNAME)
    }
    
    /**
     Prints a full `idName` path to the category.
     
     Returns: `idName` for a top-level category and `parent.idName / idName` for a sub-category.
     */
    public func toString() -> String {
        let parentCategory = getParentCategory()
        if parentCategory == nil {
            return "\(self.idName)"
        } else {
            return "\(parentCategory!.idName) / \(self.idName)"
        }
    }
    
    /// Prints `idName`
    public func toStringShort() -> String {
        return self.idName
    }
    
    /**
     Returns the parent category of a sub-category.
     
     - Returns:
       * the parent category for a sub-category
       * `nil` for a top-level category
     */
    public func getParentCategory() -> TransactionCategory? {
        if isParent() {
            return nil
        }
        
        for item in CARROTLABS_CATEGORIES {
            if item.1.first(where: { $0 == self.idName }) != nil {
                return TransactionCategory(item.0)
            }
        }
        
        return nil
    }
    
    /**
     Finds whether a category is a top-level category.
     
     - Returns: `true` if the category is a top-level category, `false` otherwise.
     */
    public func isParent() -> Bool {
        return idName == "cash" || idName == "account_transfer" || idName == TransactionCategory.UNCATEGORISED_IDNAME || getSubCategories() != nil
    }

    /**
     Finds whether a category is a sub-category.
     
     - Returns: `true` if the category is a sub-category, `false` otherwise.
     */
    public func isSub() -> Bool {
        return !isParent()
    }
    
    
    /// Returns category `Int Id`
    public func getIntId() -> Int {
        return TransactionCategory.getIntId(idName: self.idName)
    }
    
    /// Returns an array of all top-level `TransactionCategory`
    public static func getParentCategories() -> [TransactionCategory] {
        return [
            TransactionCategory("not_categorized"),
            TransactionCategory("cash"),
            TransactionCategory("fees_tax_charges"),
            TransactionCategory("health"),
            TransactionCategory("household"),
            TransactionCategory("housing"),
            TransactionCategory("income"),
            TransactionCategory("insurance"),
            TransactionCategory("leisure_shopping"),
            TransactionCategory("misc"),
            TransactionCategory("payments"),
            TransactionCategory("save_invest"),
            TransactionCategory("travel"),
            TransactionCategory("mobility"),
            TransactionCategory("account_transfer")]
    }
    
    /// Determines category `Int Id` by its `idName`
    public static func getIntId(idName: String) -> Int {
        var result = TransactionCategory.UNCATEGORISED_INT_ID
        
        switch idName {
        case "accountfees" :result=1
        case "agency" :result=2
        case "bankfees" :result=3
        case "canton_tax" :result=4
        case "church_tax" :result=5
        case "creditcardfees" :result=6
        case "federal_tax" :result=7
        case "interest_payment" :result=8
        case "latefees" :result=9
        case "military_tax" :result=10
        case "municipal_tax" :result=11
        case "withholding_tax" :result=12
        case "alternative_medicine" :result=13
        case "beauty" :result=14
        case "dentist" :result=15
        case "doctor" :result=16
        case "eye_doctor" :result=17
        case "hairdresser" :result=18
        case "massage" :result=19
        case "pharmacy" :result=20
        case "children" :result=21
        case "cleaning_services" :result=22
        case "cloths_cleaning" :result=23
        case "groceries" :result=24
        case "household_supplies" :result=25
        case "office" :result=26
        case "phone_internet" :result=27
        case "tv" :result=28
        case "amortisation" :result=29
        case "furniture" :result=30
        case "garden" :result=31
        case "mortgage" :result=32
        case "mortgage_interest" :result=33
        case "renovation" :result=34
        case "rent" :result=35
        case "utilities" :result=36
        case "bonus" :result=37
        case "heritage" :result=38
        case "interest_income" :result=39
        case "received_present" :result=40
        case "refund" :result=41
        case "rental_income" :result=42
        case "wage" :result=43
        case "building_insurance" :result=44
        case "car_insurance" :result=45
        case "health_insurance" :result=46
        case "household_insurance" :result=47
        case "legal_insurance" :result=48
        case "life_insurance" :result=49
        case "art" :result=50
        case "bars" :result=51
        case "books" :result=52
        case "clothes" :result=53
        case "electronics" :result=54
        case "fastfood" :result=55
        case "hobbies" :result=56
        case "jewellery" :result=57
        case "movies" :result=58
        case "music" :result=59
        case "newspapers" :result=60
        case "online_shopping" :result=61
        case "restaurants" :result=62
        case "shoes" :result=63
        case "sport" :result=64
        case "tabak" :result=65
        case "wine" :result=66
        case "alimony" :result=67
        case "donations" :result=68
        case "education" :result=69
        case "lawyers" :result=70
        case "memberfees" :result=71
        case "personal_events" :result=72
        case "pets" :result=73
        case "presents" :result=74
        case "professional_expenses" :result=75
        case "car_buy" :result=76
        case "car_leasing" :result=77
        case "car_rental" :result=78
        case "car_service" :result=79
        case "gas" :result=80
        case "parking" :result=81
        case "public_transport" :result=82
        case "taxi" :result=83
        case "traffic_fine" :result=84
        case "check" :result=85
        case "creditcard_payment" :result=86
        case "financial_advices" :result=87
        case "invest" :result=88
        case "pension" :result=89
        case "save" :result=90
        case "airplane" :result=91
        case "hotel" :result=92
        case "vacations" :result=93
        case "cash" :result=94
        case "fees_tax_charges" :result=95
        case "health" :result=96
        case "household" :result=97
        case "housing" :result=98
        case "income" :result=99
        case "insurance" :result=100
        case "leisure_shopping" :result=101
        case "misc" :result=102
        case "mobility" :result=103
        case "not_categorized" :result=104
        case "payments" :result=105
        case "save_invest" :result=106
        case "travel" :result=107
        case "account_transfer" :result=108
        default: result = TransactionCategory.UNCATEGORISED_INT_ID
        }
        
        return result
    }
    
    /**
     Returns a `TransactionCategory` struct by its `Int Id`.
     
     - Parameter intId: category int id
     
     - Returns: `TransactionCategory` if it found a category with `int Id`, `UNCATEGORISED` otherwise.
     */
    public static func getCategory(intId: Int) -> TransactionCategory {
        switch intId {
        case 0: return TransactionCategory()
        case UNCATEGORISED_INT_ID: return TransactionCategory()
        case 94: return TransactionCategory("cash")
        case 95: return TransactionCategory("fees_tax_charges")
        case 7: return TransactionCategory("federal_tax")
        case 12: return TransactionCategory("withholding_tax")
        case 2: return TransactionCategory("agency")
        case 6: return TransactionCategory("creditcardfees")
        case 8: return TransactionCategory("interest_payment")
        case 1: return TransactionCategory("accountfees")
        case 3: return TransactionCategory("bankfees")
        case 9: return TransactionCategory("latefees")
        case 5: return TransactionCategory("church_tax")
        case 11: return TransactionCategory("municipal_tax")
        case 4: return TransactionCategory("canton_tax")
        case 10: return TransactionCategory("military_tax")
        case 96: return TransactionCategory("health")
        case 14: return TransactionCategory("beauty")
        case 15: return TransactionCategory("dentist")
        case 13: return TransactionCategory("alternative_medicine")
        case 19: return TransactionCategory("massage")
        case 20: return TransactionCategory("pharmacy")
        case 17: return TransactionCategory("eye_doctor")
        case 18: return TransactionCategory("hairdresser")
        case 16: return TransactionCategory("doctor")
        case 97: return TransactionCategory("household")
        case 26: return TransactionCategory("office")
        case 24: return TransactionCategory("groceries")
        case 25: return TransactionCategory("household_supplies")
        case 21: return TransactionCategory("children")
        case 27: return TransactionCategory("phone_internet")
        case 22: return TransactionCategory("cleaning_services")
        case 28: return TransactionCategory("tv")
        case 23: return TransactionCategory("cloths_cleaning")
        case 98: return TransactionCategory("housing")
        case 29: return TransactionCategory("amortisation")
        case 31: return TransactionCategory("garden")
        case 36: return TransactionCategory("utilities")
        case 33: return TransactionCategory("mortgage_interest")
        case 30: return TransactionCategory("furniture")
        case 35: return TransactionCategory("rent")
        case 32: return TransactionCategory("mortgage")
        case 34: return TransactionCategory("renovation")
        case 99: return TransactionCategory("income")
        case 38: return TransactionCategory("heritage")
        case 41: return TransactionCategory("refund")
        case 42: return TransactionCategory("rental_income")
        case 40: return TransactionCategory("received_present")
        case 37: return TransactionCategory("bonus")
        case 39: return TransactionCategory("interest_income")
        case 43: return TransactionCategory("wage")
        case 100: return TransactionCategory("insurance")
        case 48: return TransactionCategory("legal_insurance")
        case 44: return TransactionCategory("building_insurance")
        case 47: return TransactionCategory("household_insurance")
        case 46: return TransactionCategory("health_insurance")
        case 45: return TransactionCategory("car_insurance")
        case 49: return TransactionCategory("life_insurance")
        case 101: return TransactionCategory("leisure_shopping")
        case 54: return TransactionCategory("electronics")
        case 62: return TransactionCategory("restaurants")
        case 58: return TransactionCategory("movies")
        case 64: return TransactionCategory("sport")
        case 53: return TransactionCategory("clothes")
        case 60: return TransactionCategory("newspapers")
        case 51: return TransactionCategory("bars")
        case 55: return TransactionCategory("fastfood")
        case 52: return TransactionCategory("books")
        case 63: return TransactionCategory("shoes")
        case 66: return TransactionCategory("wine")
        case 59: return TransactionCategory("music")
        case 61: return TransactionCategory("online_shopping")
        case 50: return TransactionCategory("art")
        case 56: return TransactionCategory("hobbies")
        case 57: return TransactionCategory("jewellery")
        case 65: return TransactionCategory("tabak")
        case 102: return TransactionCategory("misc")
        case 74: return TransactionCategory("presents")
        case 72: return TransactionCategory("personal_events")
        case 71: return TransactionCategory("memberfees")
        case 69: return TransactionCategory("education")
        case 70: return TransactionCategory("lawyers")
        case 68: return TransactionCategory("donations")
        case 67: return TransactionCategory("alimony")
        case 75: return TransactionCategory("professional_expenses")
        case 73: return TransactionCategory("pets")
        case 105: return TransactionCategory("payments")
        case 85: return TransactionCategory("check")
        case 86: return TransactionCategory("creditcard_payment")
        case 106: return TransactionCategory("save_invest")
        case 88: return TransactionCategory("invest")
        case 89: return TransactionCategory("pension")
        case 90: return TransactionCategory("save")
        case 87: return TransactionCategory("financial_advices")
        case 107: return TransactionCategory("travel")
        case 91: return TransactionCategory("airplane")
        case 93: return TransactionCategory("vacations")
        case 92: return TransactionCategory("hotel")
        case 103: return TransactionCategory("mobility")
        case 80: return TransactionCategory("gas")
        case 82: return TransactionCategory("public_transport")
        case 81: return TransactionCategory("parking")
        case 79: return TransactionCategory("car_service")
        case 76: return TransactionCategory("car_buy")
        case 77: return TransactionCategory("car_leasing")
        case 78: return TransactionCategory("car_rental")
        case 83: return TransactionCategory("taxi")
        case 84: return TransactionCategory("traffic_fine")
        case 108: return TransactionCategory("account_transfer")
            
        default: return TransactionCategory()
        }
    }
    
    /**
     Provides category sub-categories.
     
     - Returns: an array of `TransactionCategory` for a top-level category, otherwise returns `nil`.
     */
    public func getSubCategories() -> [TransactionCategory]? {
        switch self.idName {
        case TransactionCategory.UNCATEGORISED_IDNAME : return nil
        case "cash" : return [TransactionCategory]()
        case "fees_tax_charges" : return [TransactionCategory("federal_tax"),
            TransactionCategory("withholding_tax"),
            TransactionCategory("agency"),
            TransactionCategory("creditcardfees"),
            TransactionCategory("interest_payment"),
            TransactionCategory("accountfees"),
            TransactionCategory("bankfees"),
            TransactionCategory("latefees"),
            TransactionCategory("church_tax"),
            TransactionCategory("municipal_tax"),
            TransactionCategory("canton_tax"),
            TransactionCategory("military_tax")]
        case "health": return [TransactionCategory("beauty"),
            TransactionCategory("dentist"),
            TransactionCategory("alternative_medicine"),
            TransactionCategory("massage"),
            TransactionCategory("pharmacy"),
            TransactionCategory("eye_doctor"),
            TransactionCategory("hairdresser"),
            TransactionCategory("doctor")]
        case "household": return [TransactionCategory("office"),
            TransactionCategory("groceries"),
            TransactionCategory("household_supplies"),
            TransactionCategory("children"),
            TransactionCategory("phone_internet"),
            TransactionCategory("cleaning_services"),
            TransactionCategory("tv"),
            TransactionCategory("cloths_cleaning")]
        case "housing": return [TransactionCategory("amortisation"),
            TransactionCategory("garden"),
            TransactionCategory("utilities"),
            TransactionCategory("mortgage_interest"),
            TransactionCategory("furniture"),
            TransactionCategory("rent"),
            TransactionCategory("mortgage"),
            TransactionCategory("renovation")]
        case "income": return [TransactionCategory("heritage"),
            TransactionCategory("refund"),
            TransactionCategory("rental_income"),
            TransactionCategory("received_present"),
            TransactionCategory("bonus"),
            TransactionCategory("interest_income"),
            TransactionCategory("wage")]
        case "insurance": return [TransactionCategory("legal_insurance"),
            TransactionCategory("building_insurance"),
            TransactionCategory("household_insurance"),
            TransactionCategory("health_insurance"),
            TransactionCategory("car_insurance"),
            TransactionCategory("life_insurance")]
        case "leisure_shopping": return [TransactionCategory("electronics"),
            TransactionCategory("restaurants"),
            TransactionCategory("movies"),
            TransactionCategory("sport"),
            TransactionCategory("clothes"),
            TransactionCategory("newspapers"),
            TransactionCategory("bars"),
            TransactionCategory("fastfood"),
            TransactionCategory("books"),
            TransactionCategory("shoes"),
            TransactionCategory("wine"),
            TransactionCategory("music"),
            TransactionCategory("online_shopping"),
            TransactionCategory("art"),
            TransactionCategory("hobbies"),
            TransactionCategory("jewellery"),
            TransactionCategory("tabak")]
        case "misc": return [TransactionCategory("presents"),
            TransactionCategory("personal_events"),
            TransactionCategory("memberfees"),
            TransactionCategory("education"),
            TransactionCategory("lawyers"),
            TransactionCategory("donations"),
            TransactionCategory("alimony"),
            TransactionCategory("professional_expenses"),
            TransactionCategory("pets")]
        case "payments": return [TransactionCategory("check"),
            TransactionCategory("creditcard_payment")]
        case "save_invest": return [TransactionCategory("invest"),
            TransactionCategory("pension"),
            TransactionCategory("save"),
            TransactionCategory("financial_advices")]
        case "travel": return [TransactionCategory("airplane"),
            TransactionCategory("vacations"),
            TransactionCategory("hotel")]
        case "mobility": return [TransactionCategory("gas"),
            TransactionCategory("public_transport"),
            TransactionCategory("parking"),
            TransactionCategory("car_service"),
            TransactionCategory("car_buy"),
            TransactionCategory("car_leasing"),
            TransactionCategory("car_rental"),
            TransactionCategory("taxi"),
            TransactionCategory("traffic_fine")]
        case "account_transfer": return [TransactionCategory]()
        default: return nil
        }
    }
}
    
/// Global list of TransactionCategories
internal let CARROTLABS_CATEGORIES: [(String, [String])] = [
    ("not_categorized",[""]),
    ("cash", [""]),
    ("fees_tax_charges", ["", "federal_tax", "withholding_tax", "agency", "creditcardfees","interest_payment","accountfees","bankfees","latefees","church_tax","municipal_tax","canton_tax","military_tax"]),
    ("health", ["", "beauty", "dentist" ,"alternative_medicine","massage","pharmacy","eye_doctor","hairdresser","doctor"]),
    ("household", ["", "office","groceries","household_supplies","children","phone_internet","cleaning_services","tv","cloths_cleaning"]),
    ("housing", ["", "amortisation","garden","utilities","mortgage_interest","furniture","rent","mortgage","renovation"]),
    ("income", ["", "heritage","refund","rental_income","received_present","bonus","interest_income","wage"]),
    ("insurance",["", "legal_insurance","building_insurance","household_insurance","health_insurance","car_insurance","life_insurance"]),
    ("leisure_shopping", ["", "electronics","restaurants","movies","sport","clothes","newspapers","bars","fastfood","books","shoes","wine","music","online_shopping","art","hobbies","jewellery","tabak"]),
    ("misc", ["", "presents","personal_events","memberfees","education","lawyers","donations","alimony","professional_expenses","pets"]),
    ("payments",["", "check","creditcard_payment"]),
    ("save_invest",["", "invest","pension","save","financial_advices"]),
    ("travel", ["", "airplane","vacations","hotel"]),
    ("account_transfer", [""]),
    
    ("mobility", ["", "gas", "public_transport", "parking", "car_service", "car_buy", "car_leasing", "car_rental", "taxi", "traffic_fine"]),
    ("goal", ["", "Rolls_Royce_Phantom", "patek_philippe_watch"])
]

/// :nodoc:
internal let INCOME_CATEGORY_INT_IDS : [Int] = [99, 38, 41, 42, 40, 37, 39, 43]
