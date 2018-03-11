//
//  SetsTableViewCell.swift
//  Swipeable-View-Stack
//
//  Created by Piotrek on 10.03.2018.
//  Copyright © 2018 Piotr Knapczyk. All rights reserved.


import UIKit

class SetsTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var timeLeft: UILabel!
    @IBOutlet weak var percentageLearned: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        timeLeft.layer.borderColor = UIColor.red.cgColor
        timeLeft.layer.cornerRadius = 10
        timeLeft.layer.borderWidth = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
