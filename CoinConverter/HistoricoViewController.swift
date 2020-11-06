//
//  HistoricoViewController.swift
//  CoinConverter
//
//  Created by Gabriel Perseguini on 05/11/20.
//  Copyright © 2020 Gabriel Perseguini. All rights reserved.
//

import UIKit
import CoreData

class HistoricoViewController: UIViewController {
    var selectedCoins : [String] = []
    var brlCoins : [String] = []
    var coinName : [String] = []
    var coin1 = ""
    var coin2 = ""

    @IBOutlet weak var historico: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        historico.delegate = self
        historico.dataSource = self
        historico.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
         
        // Do any additional setup after loading the view.
    }

}

extension HistoricoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return selectedCoins.count;
        return selectedCoins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = historico.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = coinName[indexPath.row] + ": " + selectedCoins[indexPath.row] + " BRL: " + brlCoins[indexPath.row] 
        return cell
    }

    
    func tableView(_ tableView:UITableView, didSelectRowAt indexPath: IndexPath){
        print("u tapped me")
        }
    }




