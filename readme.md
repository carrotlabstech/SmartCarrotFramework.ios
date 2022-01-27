# SmartCarrotFramework
Version 1.0.16

**On device Personal Finance Manager.**

## Installation
The simplest way to integrate **SmartCarrotFramework** is to use CocoaPods.

```
source 'https://github.com/.../SmartCarrotFramework.specs.git'
source 'https://github.com/CocoaPods/Specs.git'

target :YourTargetName do
    use_frameworks!

    pod 'SmartCarrotFramework' 
end
```

**SmartCarrotFramework** is supplied as a "fat" library and contains code for both Mac and iOS devices. Therefore you can run it in a simulator, as well as on the iOS device. Thus, it is possible that XCode cannot build the application due to the code unneccesary for the mobile devices. You can bypass such a limitation by adding this script to the project **Build Phases**, as the last step:

```bash
echo "Target architectures: $ARCHS"

APP_PATH="${TARGET_BUILD_DIR}/${WRAPPER_NAME}"

find "$APP_PATH" -name '*.framework' -type d | while read -r FRAMEWORK
do
FRAMEWORK_EXECUTABLE_NAME=$(defaults read "$FRAMEWORK/Info.plist" CFBundleExecutable)
FRAMEWORK_EXECUTABLE_PATH="$FRAMEWORK/$FRAMEWORK_EXECUTABLE_NAME"
echo "Executable is $FRAMEWORK_EXECUTABLE_PATH"
echo $(lipo -info "$FRAMEWORK_EXECUTABLE_PATH")

FRAMEWORK_TMP_PATH="$FRAMEWORK_EXECUTABLE_PATH-tmp"

# remove simulator's archs if location is not simulator's directory
case "${TARGET_BUILD_DIR}" in
*"iphonesimulator")
echo "No need to remove archs"
;;
*)
if $(lipo "$FRAMEWORK_EXECUTABLE_PATH" -verify_arch "i386") ; then
lipo -output "$FRAMEWORK_TMP_PATH" -remove "i386" "$FRAMEWORK_EXECUTABLE_PATH"
echo "i386 architecture removed"
rm "$FRAMEWORK_EXECUTABLE_PATH"
mv "$FRAMEWORK_TMP_PATH" "$FRAMEWORK_EXECUTABLE_PATH"
fi
if $(lipo "$FRAMEWORK_EXECUTABLE_PATH" -verify_arch "x86_64") ; then
lipo -output "$FRAMEWORK_TMP_PATH" -remove "x86_64" "$FRAMEWORK_EXECUTABLE_PATH"
echo "x86_64 architecture removed"
rm "$FRAMEWORK_EXECUTABLE_PATH"
mv "$FRAMEWORK_TMP_PATH" "$FRAMEWORK_EXECUTABLE_PATH"
fi
;;
esac

echo "Completed for executable $FRAMEWORK_EXECUTABLE_PATH"
echo $(lipo -info "$FRAMEWORK_EXECUTABLE_PATH")

done
```

## Licensing
Licenses are granted on per module basis. You share your application bundle id with **CarrotLabs**, and we will send you a mail with the license and instructions. 

How to set the license:

```swift
import SmartCarrotFramework

...

func setLicense(license: String) {
    let carrotContext = CarrotContext()

    do {
        try carrotContext.setLicense(license: license)
    } catch {
        ...
    }
}
```

## Modules
**SmartCarrotFramework** consists of few modules:
- `CategorisationAPI` to categorise transactions.
- `TransactionAPI` to categorise, manipulate, and store transactions.
- `BudgetAPI` to set incremental budgets on transactions and be able to receive alerts if a budget did overspent, or did reach its spend threshold.
- `ZenAPI` to let the end user carefully look after own financial health and form positive habits.

The full power of the **SmartCarrotFramework** can be obtained only when all the building blocks are used jointly.

## Categorisation
It is very easy to categorise a transaction: use a `CategorisationAPI` object for that:

```swift
import SmartCarrotFramework

...

func doCategorise(transactionDescription: String, transactionAmount: Decimal) {
    do {
        let categorisationAPI = try _carrotContext.getCategorisationAPI()

        let categoryId = try categorisationAPI.categorise(description: transactionDescription, amount: transactionAmount)
        print("Transaction category is \(TransactionCategory(categoryId).toString())")
    } catch {
        ...
    }
}
```

## Transaction Categorisation
You don't need to categorise transactions in a separate method call. At the time of `TransactionAPI.upsert(transactions:categorise:)` transactions do categorise automatically.

## Budgets
* `BudgetFrequency.monthly` budget takes into account all the transactions whose `Transaction.bookingDate` belongs to the **current month**.
* `BudgetFrequency.annual` budget takes into account all the transactions whose `Transaction.bookingDate` belongs to the **current year**.
* `BudgetAPI.getRunningTotal(budget:)` is always positive, it is a sum of all the transactions per budget. If a budget's category is a top level category than transactions of the category's sub categories are not added. Budget of the `TransactionCategory.UNCATEGORISED` category is allowed.
* `BudgetAPI.getBalance(budget:)` is **positive** if budget's running total is less than the budgeted amount and is **negative** otherwise.

When a budget gets saved:
* its `Budget.id` is trimmed
* Negative `Budget.budgeted` amount is set to **0**
* Negative `Budget.alert` amount is set to **0**
* Negative `Budget.categoryId` is set to `TransactionCategory.UNCATEGORISED_INT_ID`


## Persistence
All entities are encrypted and stored in the [core data persistent store](https://developer.apple.com/documentation/coredata). The encryption key should be provided by the customer and set right after the license validation:

```swift
import SmartCarrotFramework

...

func setLicense(license: String) {
    var carrotContext = CarrotContext()

    do {
        try carrotContext.setLicense(license: license)
        carrotContext.setEncryption(key: "thisIsGreatKey!", iv: "1234567890123456")
    } catch {
        ...
    }
}
```

the encryption key consists of:
* the **key** by itself,
* **initialisation vector**, **must be of 16 characters long.**

## Entity Ids
The Framework is not responsible for entity (`Transaction`, `Budget`) unique identifiers. They should be maintained by the customer. The ids are of type `String` and the customer can use either own backend entity ids or `UUID` values.


If an entity id is empty, the entity can't be saved into the persistent storage and a respective `CarrotContextError.emptyEntityId` is thrown.

Entity Ids are trimmed before being saved.

## Events
At the moment these four types of events are emitted:
* `Notification.Name.transactionListDidUpdate` if a transaction in the persistent storage got updated, inserted, deleted or categorised.
* `Notification.Name.budgetListDidUpdate` if a budget in the persistent storage got updated, inserted or deleted.
* `Notification.Name.budgetDidAlert` if a budget's `runningTotal` exceeded its `alert` value but less than its `budgeted` value.
* `Notification.Name.budgetDidOverSpend` if the budget's `runningTotal` exceeded its `budgeted` value.

How to subscribe to events:

```swift
import SmartCarrotFramework

...

func subscribeToBudgetNotification() {
    NotificationCenter.default.addObserver(forName: .budgetDidAlert, object: nil, queue: nil, using: budgetDidAlert(_:))
    NotificationCenter.default.addObserver(forName: .budgetDidOverSpend, object: nil, queue: nil, using: budgetDidOverSpend(_:))
}


func budgetDidAlert(_ notification: Notification) {
        let budget = notification.object as! Budget
        
        print("budget alert: \((notification.object as! Budget).name)")
}

func budgetDidOverSpend(_ notification: Notification) {
    ...
}
```


## Zen Score
Zen Score represents a user's financial health score. It falls in range (0; 1) and a higher value means better financial health.

Zen Scores are caclulated for a consequent range of dates (days), the maximum time period is defined by `ZenParams.MAX_INTERVAL`. If the requested time interval exceeds the maximum time interval than the scores will be caclulated only for the number of days defined by `ZenParams.MAX_INTERVAL`. The **closest** date of the requested time interval will be included into the result set.

Zen Scores require at least one `Budget` to be created, otherwise `ZenAPI` will throw an error.
