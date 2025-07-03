//
//  HomeViewController.swift
//  AppDragonBall
//
//  Created by Pablo Peragón Garrido on 3/7/25.
//

import UIKit

class HomeViewController: UIViewController {
    private var appState: AppState?
    
    init(appState: AppState) {
        self.appState = appState
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //cerramos la sesion
    @IBAction func CloseSession(_ sender: Any) {
        self.appState?.closeSessionUser()
    }
}
