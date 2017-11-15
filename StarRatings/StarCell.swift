//
//  StarCell.swift
//  ExpandableLabel
//
//  Created by Ritu Raj on 24/02/17.
//  Copyright © 2017 Acknown Technologies. All rights reserved.
//

import UIKit

class StarCell: UITableViewCell {

    @IBOutlet weak var starRatingView: StarRatingView!
    
    @IBOutlet weak var ttLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
//        starRatingView.delegate = nil

    }

}
