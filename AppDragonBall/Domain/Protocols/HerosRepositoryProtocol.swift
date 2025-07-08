//
//  HerosRepositoryProtocol.swift
//  AppDragonBall
//
//  Created by Pablo Peragón Garrido on 8/7/25.
//

import Foundation

protocol HerosRepositoryProtocol {
    func getHeros(filter: String) async -> [HerosModel]
}
