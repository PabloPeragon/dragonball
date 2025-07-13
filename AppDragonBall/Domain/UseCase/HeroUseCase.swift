//
//  HeroUseCase.swift
//  AppDragonBall
//
//  Created by Pablo Peragón Garrido on 8/7/25.
//

import Foundation

protocol herosUseCaseProtocol{
    var repo: HerosRepositoryProtocol {get set}
    func getHeros(filter: String) async -> [HerosModel]
    func getHeroTransformations(idHero: String) async -> [TransformationModel]
    
}

//real
final class HeroUseCase: herosUseCaseProtocol{
    
    var repo: HerosRepositoryProtocol
    
    init(repo: HerosRepositoryProtocol = HerosRepository(network: NetworkHeros())){
        self.repo = repo
    }

    func getHeros(filter: String) async -> [HerosModel] {
        await repo.getHeros(filter: filter)
    }
    
    func getHeroTransformations(idHero: String) async -> [TransformationModel] {
        await repo.getHeroTransformations(idHero: idHero)
    }
}


//Fake
final class HeroUseCaseFake: herosUseCaseProtocol {
    
    var repo: HerosRepositoryProtocol
    
    init(repo: HerosRepositoryProtocol = HerosRepository(network: NetworkHerosFake())) {
        self.repo = repo
    }
    
    func getHeros(filter: String) async -> [HerosModel] {
        await repo.getHeros(filter: filter)
    }
    
    func getHeroTransformations(idHero: String) async -> [TransformationModel] {
        await repo.getHeroTransformations(idHero: idHero)
    }
}
