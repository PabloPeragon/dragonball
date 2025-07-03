//
//  ErrorViewController.swift
//  AppDragonBall
//
//  Created by Pablo Peragón Garrido on 3/7/25.
//

import UIKit
import Combine
import CombineCocoa

class ErrorViewController: UIViewController {
    
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var buttonBack: UIButton!
    
    private var suscriptors = Set<AnyCancellable>()
    private var error: String?
    private var appState: AppState?
    
    init(appState: AppState, error: String){
        self.error = error
        self.appState = appState
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //muestro el error en la label
        self.lblError.text = self.error
        
        //suscriptor del boton
        self.buttonBack.tapPublisher
            .sink {[weak self] _ in
                self?.appState?.statusLogin = .none
            }
            .store(in: &suscriptors)
    }
}
