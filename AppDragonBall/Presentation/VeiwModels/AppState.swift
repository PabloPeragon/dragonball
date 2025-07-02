//
//  AppState.swift
//  AppDragonBall
//
//  Created by Pablo Peragón Garrido on 1/7/25.
//

import Foundation
import Combine

//Contro del stado de la app
enum LoginStatus {
    case none
    case success
    case error
    case notValidate
}


//View Model
final class AppState {
    // estado de login
    @Published var statusLogin: LoginStatus = .none
    
    private var loginUseCase: LoginUseCaseProtocol
    
    init(loginUseCase: LoginUseCaseProtocol = LoginUseCase()) {
        self.loginUseCase = loginUseCase
    }
    
    //funcion de login
    func loginApp(user: String, pass: String){
        
        Task {
            if (await loginUseCase.loginApp(user: user, password: pass)) {
                //login success
                self.statusLogin = .success
            } else {
                //login error
                self.statusLogin = .error
            }
        }
    }
    
    //evaluo autologin
    func validateControlLogin(){
        Task {
            if (await loginUseCase.validateToken()){
                //esta logado ya.
                self.statusLogin = .success
            } else {
                self.statusLogin = .notValidate
            }
        }
    }
    
    func closeSessionUser() {
        Task {
            await loginUseCase.logout()
            self.statusLogin = .none //que vaya al login
        }
    }
}
