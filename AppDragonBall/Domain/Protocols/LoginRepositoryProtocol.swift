//
//  LoginRepositoryProtocol.swift
//  AppDragonBall
//
//  Created by Pablo Peragón Garrido on 1/7/25.
//

import Foundation

protocol LoginRepositoryProtocol {
    func loginApp(user: String, password: String) async -> String //devuelve el toke jwt
}

