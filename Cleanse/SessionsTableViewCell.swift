//
//  SessionsTableViewCell.swift
//  Cleanse
//
//  Created by Alek Matthiessen on 4/15/20.
//  Copyright © 2020 The Matthiessen Group, LLC. All rights reserved.
//

import UIKit

class SessionsTableViewCell: UITableViewCell {

    @IBOutlet weak var datelabel: UILabel!
    @IBOutlet weak var textlabel: UILabel!
    @IBOutlet weak var titlelabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
