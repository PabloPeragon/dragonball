//
//  TransformationsTableViewController.swift
//  AppDragonBall
//
//  Created by Pablo Peragón Garrido on 12/7/25.
//

import UIKit
import Combine

class TransformationsTableViewController: UITableViewController {
    
    private var Hero: HerosModel
    private var vm: HerosViewModel
    
    //Combine
    private var suscriptors = Set<AnyCancellable>()
    
    init(HeroSelected: HerosModel, vmHeros: HerosViewModel){
        self.Hero = HeroSelected
        self.vm = vmHeros
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "TransformationsTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
       
        //Titulo del heroe
        self.title = self.Hero.name
        
        
        //binding de la vista con el view model
        binding()
        
        tableView.backgroundColor = .baseTable
        
        //lanzamos la carga de las transformaciones
        Task {
            await self.vm.getHeroTransformation(idHero: self.Hero.id.uuidString)
        }

    }
    
    private func binding(){
        
        self.vm.$transformationHeroData
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { dataRecived in
                //recargamos la tabla al llegar la transformaciones
                self.tableView.reloadData()
            })
            .store(in: &suscriptors)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // si no hay datos mostramos el alert
        if vm.transformationHeroData.count == 0 {
            return 1
        } else {
            return vm.transformationHeroData.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TransformationsTableViewCell
        
        if vm.transformationHeroData.count == 0 {
            cell.title.text = "\(self.Hero.name) no tiene transformaicones."
            cell.descript.text = ""
            //imagen por defecto
            cell.photo.image = UIImage(named: "goku")
        } else {
            //el modelo de la transformacion
            let TransModel = self.vm.transformationHeroData[indexPath.row]
            
            //compongo la celda
            cell.title.text = TransModel.name
            cell.photo.loadImageRemote(url: URL(string: TransModel.photo)!)
            cell.descript.text = TransModel.description
            
        }
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 550
    }
}

