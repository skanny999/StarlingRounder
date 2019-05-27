//
//  ViewController.swift
//  StarlingRounder
//
//  Created by Riccardo on 26/05/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import UIKit


protocol RounderDelegate: class {
    
    func accountViewControllerDidTapRound(_ viewController: AccountViewController)
}

class AccountViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var savingGoalLabel: UILabel!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    
    @IBOutlet weak var goalNameLabel: UILabel!
    @IBOutlet weak var amountSavedLabel: UILabel!
    @IBOutlet weak var targetAmountLabel: UILabel!
    @IBOutlet weak var percentageSavedLabel: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var accountViewModel: AccountViewModel!
    weak var delegate: RounderDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accountViewModel = AccountViewModel()
        delegate = accountViewModel
        configureTableView()
        configureViewUpdater()
        configureActivityIndicatorView()
        configureStaticLabels()
        configureViewForLoadingData()
    }

    private func configureTableView() {
        tableView.dataSource = accountViewModel
        tableView.register(TransactionCell.nib, forCellReuseIdentifier: TransactionCell.identifier)
    }
    
    private func configureViewUpdater() {
        
        accountViewModel.updateTransactions = {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
        
        accountViewModel.updateSavingGoalViews = {[weak self] (savingGoalData) in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.configureSavingLabels(with: savingGoalData)
                self?.hideSavingLabels(false)
            }
        }
        
        accountViewModel.showLoadingData = {
            DispatchQueue.main.async { [weak self] in
                self?.activityIndicator.startAnimating()
                self?.hideSavingLabels(true)
            }
        }

        accountViewModel.showErrorMessage = { (message) in
            DispatchQueue.main.async { [weak self] in
                self?.showError(withMessage: message)
            }
        }
    }
    
    private func configureActivityIndicatorView() {
        activityIndicator.transform = CGAffineTransform(scaleX: 3, y: 3)
        activityIndicator.hidesWhenStopped = true
    }
    
    private func configureStaticLabels() {
        
        savingGoalLabel.text = "SAVING GOAL"
        targetLabel.text = "TARGET"
        percentageLabel.text = "PERCENTAGE"
    }
    
    private func configureViewForLoadingData() {
        
        hideSavingLabels(true)
        activityIndicator.startAnimating()
    }
    
    private func hideSavingLabels(_ hide: Bool) {
        
        goalNameLabel.isHidden = hide
        amountSavedLabel.isHidden = hide
        targetAmountLabel.isHidden = hide
        percentageSavedLabel.isHidden = hide
        savingGoalLabel.isHidden = hide
        targetLabel.isHidden = hide
        percentageLabel.isHidden = hide
    }
    
    private func configureSavingLabels(with savingGoal: SavingGoalViewData) {
        
        DispatchQueue.main.async { [weak self] in
            self?.goalNameLabel.text = savingGoal.name
            self?.amountSavedLabel.text = savingGoal.amount
            self?.targetAmountLabel.text = savingGoal.savingGoalTarget
            self?.percentageSavedLabel.text = savingGoal.percentageReached
        }
    }
    
    private func showError(withMessage message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func roundButtonTapped(_ sender: Any) {
        
        delegate?.accountViewControllerDidTapRound(self)
    }
}

