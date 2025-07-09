//
//  HeroTableViewCell.swift
//  AppDragonBall
//
//  Created by Pablo Peragón Garrido on 9/7/25.
//

import UIKit

class HeroTableViewCell: UITableViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var title: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
