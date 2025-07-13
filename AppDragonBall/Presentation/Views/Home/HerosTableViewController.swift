//
//  HerosTableViewController.swift
//  AppDragonBall
//
//  Created by Pablo Peragón Garrido on 9/7/25.
//

import UIKit
import Combine

class HerosTableViewController: UITableViewController {
    
    //viewModel appState, heroes
    private var appState: AppState
    private var viewModel: HerosViewModel
    
    //Combine
    private var suscriptors = Set<AnyCancellable>()
    
    init(appState: AppState, viewModel: HerosViewModel) {
        self.appState = appState
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //registro de celda personalizada
        tableView.register(UINib(nibName: "HeroTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        //titulo en el navigation controller
        self.title = "Lista de Heroes"
        
        //Color del titulo Lista de Horoes
        if let textNameList = self.navigationController?.navigationBar {
            if let customColor = UIColor(named: "textColor") {
                textNameList.titleTextAttributes = [NSAttributedString.Key.foregroundColor: customColor]
            }
        }
        
        //añadir un boton para cerrar sesion
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeSession))
        
        //binding de la vista del viewModel
        binding()
        
        //color del fondo de la tabla
        tableView.backgroundColor = .baseTable
        
        //color de los botones de navegacion
        self.navigationController?.navigationBar.tintColor = UIColor(named: "textColor")
    }
    
    @objc func closeSession() {
        appState.closeSessionUser()
    }
    
    func binding() {
        self.viewModel.$herosData
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { _ in
                //recargamos la tabla
                self.tableView.reloadData()
            })
            .store(in: &suscriptors)
    }
    
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.viewModel.herosData.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HeroTableViewCell
        
        //el modelo
        let hero = viewModel.herosData[indexPath.row]
        
        //compongo la celda
        cell.title.text = hero.name
        cell.photo.loadImageRemote(url: URL(string: hero.photo)!)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let hero = viewModel.herosData[indexPath.row]
        
        //Cargo el controlador sobre el navegador y le pasamos eh heroe y el viewModel. La vista lanzara la carga necesaria.
        let vm = TransformationsTableViewController(HeroSelected: hero, vmHeros: self.viewModel)
        self.navigationController?.pushViewController(vm, animated: true)
    }
}
