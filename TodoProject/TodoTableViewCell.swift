//
//  TodoTableViewCell.swift
//  TodoProject
//
//  Created by Davide Gatti on 01.05.17.
//  Copyright © 2017 Davide Gatti. All rights reserved.
//

import UIKit

class TodoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var TodoImageView: UIImageView!
    @IBOutlet weak var TodoLabelTitle: UILabel!
    @IBOutlet weak var TodoLabelDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
