//
//  acTableViewCell.swift
//  hashTagTest
//
//  Created by 笹倉一也 on 2021/12/21.
//

import UIKit
import ActiveLabel

class acTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    @IBOutlet weak var dddd: ActiveLabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
