//
//  TransformationModel.swift
//  AppDragonBall
//
//  Created by Pablo Peragón Garrido on 12/7/25.
//

import Foundation

struct TransformationModel: Codable {
    let id: UUID
    let name: String
    let description: String
    let photo: String

}


struct TransformationModelRequest: Codable {
    let id: String
}
