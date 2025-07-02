//
//  LoginViewController.swift
//  AppDragonBall
//
//  Created by Pablo Peragón Garrido on 24/6/25.
//

import UIKit
import Combine
import CombineCocoa

class LoginViewController: UIViewController {

    @IBOutlet weak var textUser: UITextField!
    
    @IBOutlet weak var textPassword: UITextField!
    
    @IBOutlet weak var button: UIButton!
    
    
    //usuario y clave
    private var user: String = ""
    private var pass: String = ""
    
    //Combine
    private var suscriptors = Set<AnyCancellable>()
    
    
    private var appState: AppState?
    
    init(appState: AppState){
        self.appState = appState
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //suscriptores
    func bindingUI(){
        //usuario (email)
        if let textUser = self.textUser{
            textUser.textPublisher
                .receive(on: DispatchQueue.main)
                .sink {[weak self] data in
                    if let usr = data{
                        print(usr)
                        self?.user = usr
                    }
                }
                .store(in: &suscriptors)
        }
        
        //password
        if let textPassword = self.textPassword {
            textPassword.textPublisher
                .receive(on: DispatchQueue.main)
                .sink {[weak self] data in
                    if let password = data{
                        print(password)
                        self?.pass = password
                    }
                }
                .store(in: &suscriptors)
        }
        
        //boton del login
        
        if let button = self.button {
            button.tapPublisher
                .sink {[weak self] _ in
                    //llamamos al login
                    
                    if let user = self?.user,
                       let pass = self?.pass {
                        
                        self?.appState?.loginApp(user: user, pass: pass )
                    }
                }
                .store(in: &suscriptors)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindingUI()
    }
}
