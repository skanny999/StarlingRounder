# StarlingRounder
TestCode

by Riccardo Scanavacca

Enter your User authorization token in the `Constrants.swift` file

# Assumptions

* The User has transactions to round up
* The User has one Savings Goal

# Structure

The main view controller is the `AccountViewController`.
It is updated by the `AccountViewModel` with the support of the `TransactionCellViewModel` and the `SavingGoalViewModel`.

The `AccountViewModel` gets the data through the `DataManager`, which gets it with the `NetworkProvider` and process it with the `DataProcessor`. The namings is a bit boring, I know. 

Once the data is downloaded and processed it displays it in the `AccountViewController`. 

When the `Round` button is tapped, the `AccountViewModel` rounds the transactions and send them up with the `DataManager` through the same providers and processors. Once received the confirmation that it's done, it refreshes the view. 
