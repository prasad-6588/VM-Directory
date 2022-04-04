//
//  PersonTableViewCell.swift
//  VM Directory
//
//  Created by Prasad on 03/04/22.
//

import UIKit

class PersonTableViewCell: UITableViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelJobTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
