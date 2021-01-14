//
//  locationTVC.swift
//  Positive_Reactions
//
//  Created by Ali Hassan on 07/01/2021.
//

import UIKit

class locationTVC: UITableViewCell {

    @IBOutlet weak var currentlocation: UILabel!
    @IBOutlet weak var addresslbl: UILabel!
     
    @IBOutlet weak var uperbtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
