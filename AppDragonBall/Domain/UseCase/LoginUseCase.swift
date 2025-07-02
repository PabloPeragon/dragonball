//
//  LoginUseCase.swift
//  AppDragonBall
//
//  Created by Pablo Peragón Garrido on 1/7/25.
//

import Foundation
import KcLibraryswift

protocol LoginUseCaseProtocol {
    var repo: LoginRepositoryProtocol {get set}
    func loginApp(user: String, password: String) async -> Bool
    func logout() async -> Void
    func validateToken() async -> Bool
}


//implementamos el caso de uso
final class LoginUseCase: LoginUseCaseProtocol {
    var repo: LoginRepositoryProtocol
    
    init(repo: LoginRepositoryProtocol = DefaultLoginRepository(Network: NetworkLogin())) {
        self.repo = repo
    }
    
    func loginApp(user: String, password: String) async -> Bool {
        
        let token = await repo.loginApp(user: user, password: password)
        
        //guardar el token en keyChain
        if token != "" {
            //login success
            KeyChainKC().saveKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN, value: token)
            return true
        } else {
            //login error
            KeyChainKC().deleteKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
            return false
        }
    }
    
    func logout() async {
        //logout
        KeyChainKC().deleteKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
    }
    
    func validateToken() async -> Bool {
        if KeyChainKC().loadKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN) != "" {
            //tengo token
            return true
        } else {
            return false
        }
    }
}

final class LoginUseCaseFake: LoginUseCaseProtocol {
    var repo: LoginRepositoryProtocol
    
    init(repo: LoginRepositoryProtocol = DefaultLoginRepositoryFake()) {
        self.repo = repo
    }
    
    func loginApp(user: String, password: String) async -> Bool {
        
        let token = await repo.loginApp(user: user, password: password)
        
        //guardar el token en el keyChain
        if token != "" {
            //login success
            KeyChainKC().saveKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN, value: token)
            return true
        } else {
            //login error
            KeyChainKC().deleteKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
            return false
        }
    }
    
    func logout() async {
        //logout
        KeyChainKC().deleteKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
    }
    
    func validateToken() async -> Bool {
      true
    }
}
