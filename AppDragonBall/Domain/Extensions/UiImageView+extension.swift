//
//  UiImageView+extension.swift
//  AppDragonBall
//
//  Created by Pablo Peragón Garrido on 9/7/25.
//

import UIKit

extension UIImageView {
    func loadImageRemote(url: URL) {
        DispatchQueue.global().async {[weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data){
                    //todo ok.
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
