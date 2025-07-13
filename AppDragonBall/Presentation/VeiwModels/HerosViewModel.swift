//
//  HerosViewModel.swift
//  AppDragonBall
//
//  Created by Pablo Peragón Garrido on 8/7/25.
//

import Foundation
import Combine


@MainActor final class HerosViewModel: ObservableObject {
    @Published var herosData = [HerosModel]()
    //Transformaciones de un heroe seleccionado
    @Published var transformationHeroData = [TransformationModel]()
    
    private var userCaseHeros: herosUseCaseProtocol
    
    init(userCaseHeros: herosUseCaseProtocol = HeroUseCase()){
        self.userCaseHeros = userCaseHeros
        
        Task(priority: .high){
            await getHeros()
        }
    }
    
    //carga de los heroes
    func getHeros() async {
        let data = await userCaseHeros.getHeros(filter: "") //ahora no aplicamos el filtro
        self.herosData = data
        
        /*
        //asigno en el hilo principal para la actualizacion de la UI
        DispatchQueue.main.async {
            self.herosData = data
        }
         */
        
    }
    
    //Carga transformaciones de un hero
    
    func getHeroTransformation(idHero: String) async {
        
        let data = await userCaseHeros.getHeroTransformations(idHero: idHero)
        //self.transformationHeroData = data
        
        
        //asigno en el hilo pricipal para la act. de la UI
        DispatchQueue.main.async {
            self.transformationHeroData = data
        }
         
    }
}
