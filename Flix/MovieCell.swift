//
//  MovieCell.swift
//  Flix
//
//  Created by Yao on 9/27/20.
//  Copyright © 2020 Yao. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var voteLabel: UILabel!
   
    @IBOutlet weak var summaryLabel: UILabel!
    
    @IBOutlet weak var posterImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
