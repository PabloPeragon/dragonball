//
//  TransformationsTableViewCell.swift
//  AppDragonBall
//
//  Created by Pablo Peragón Garrido on 12/7/25.
//

import UIKit

class TransformationsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descript: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    
    }
    
}
