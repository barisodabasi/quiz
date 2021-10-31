//
//  OptionCell.swift
//  Trivial
//
//  Created by BarisOdabasi on 13.12.2020.
//

import UIKit

class OptionCell: UITableViewCell {

    @IBOutlet weak var optionTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
