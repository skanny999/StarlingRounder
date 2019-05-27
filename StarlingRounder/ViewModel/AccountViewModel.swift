//
//  AccountViewModel.swift
//  StarlingRounder
//
//  Created by Riccardo on 26/05/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation
import UIKit


class AccountViewModel: NSObject {

    private var account: Account?
    
    private var savingGoal: SavingGoal? {
        didSet {
            if let updatedSavingGoal = savingGoal {
                let savingGoalData = SavingGoalViewData(savingGoal: updatedSavingGoal)
                updateSavingGoalViews?(savingGoalData)
            } else {
                showErrorMessage?("Couldn't get saving goals")
            }
        }
    }
    
    private var transactions: [Transaction]? {
        didSet {
            if transactions != nil {
                updateTransactions?()
            } else {
                showErrorMessage?("Couldn't get recent transactions")
            }
        }
    }
    
    override init() {
        super.init()
        
        loadData { [weak self] (success) in
            if !success {
                self?.showErrorMessage?("Couldn't load the data")
            }
        }
    }
    
    // MARK: - View Updater properties
    
    var showErrorMessage: ((String) -> Void)?
    var updateTransactions: (() -> Void)?
    var updateSavingGoalViews: ((SavingGoalViewData) -> Void)?
    var showLoadingData:(() -> Void)?

}

// MARK: - Data Loader

private extension AccountViewModel {
    
    func loadData(completion: @escaping (Bool) -> Void) {
        DataManager.getAccount { (account, error) in
            if let error = error {
                print(error)
                completion(false)
            }
            
            guard let account = account else {
                completion(false)
                return
            }
            
            self.account = account
            
            DataManager.getSavingGoal(forAccount: account, completion: { (savingGoal, error) in
                if let error = error {
                    print(error)
                }
                self.savingGoal = savingGoal
            })
            
            DataManager.getTransactions(for: account, completion: { (transactions, error) in
                if let error = error {
                    print(error)
                    completion(false)
                }
                self.transactions = transactions
            })
            completion(true)
        }
    }
}

// MARK: - Data Source for TableView

extension AccountViewModel: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: TransactionCell.identifier, for: indexPath) as? TransactionCell,
            let transaction = transactions?[indexPath.row] {
            let cellData = TransactionCellData(transaction: transaction)
            cell.cellData = cellData
            return cell
        }
        return UITableViewCell()
    }
}

// MARK: - RoundUp function

extension AccountViewModel: RounderDelegate {
    
    func accountViewControllerDidTapRound(_ viewController: AccountViewController) {
        
        roundUpTransactions()
    }
    
    
    func roundUpTransactions() {
        
        guard let account = account, let savingGoal = savingGoal else {
            showErrorMessage?("Can't round up, accounts anavailable")
            return
        }
        
        //filter outward transaction, gets the value and sums up the roundings
        guard let roundUp = transactions?.filter({ $0.direction == "OUT"})
            .compactMap({$0.amount?.minorUnits})
            .reduce(0, {$0 + 100 - $1 % 100}) else {
                showErrorMessage?("Cannot find transactions to round up")
                return
        }
        
        DataManager.transferMoney(roundUp, from: account, toSavingGoal: savingGoal) { [weak self] (success, errorMessage) in
            
            guard success else {
                self?.showErrorMessage?(errorMessage ?? "Couldn't process the transfer")
                return
            }
            
            self?.loadData(completion: { (success) in
                if !success {
                    self?.showErrorMessage?("Couldn't load data")
                }
            })
        }
    }
}
    
 





    

    

