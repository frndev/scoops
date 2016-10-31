//
//  NewsTableViewCell.swift
//  Scoops
//
//  Created by Antonio Benavente del Moral on 29/10/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBOutlet weak var ImageNew: UIImageView!
    
    @IBOutlet weak var textNew: UILabel!
    
    @IBOutlet weak var situacionNew: UILabel!
    
    
    @IBAction func changeSituation(_ sender: AnyObject) {
    }
    
    @IBOutlet weak var changeSituacionValue: UIButton!

    
   

    
    
    
}
