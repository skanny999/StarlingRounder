//
//  TableViewCell.swift
//  StarlingRounder
//
//  Created by Riccardo on 26/05/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import UIKit

class TransactionCell: UITableViewCell {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    var cellData: TransactionCellData? {
        
        didSet {
            categoryLabel.text = cellData?.category
            dateLabel.text = cellData?.date
            amountLabel.text = cellData?.amount
        }
    }
    
    static var identifier: String {
        
        return String(describing: self)
    }
    
    static var nib: UINib {
        
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.isUserInteractionEnabled = false
    }
}
