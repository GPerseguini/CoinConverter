//
//  ViewController.swift
//  CoinConverter
//
//  Created by Gabriel Perseguini on 04/11/20.
//  Copyright © 2020 Gabriel Perseguini. All rights reserved.
//

import UIKit
class CellClass: UITableViewCell{
    
}
class ViewController: UIViewController {
    
    
    @IBOutlet weak var selectedCoin: UITextField!
    @IBOutlet weak var BRL: UITextField!
    @IBOutlet weak var coin1btn: UIButton!
    @IBOutlet weak var done: UIButton!
    @IBOutlet weak var realLb: UILabel!
    @IBOutlet weak var titleLb: UILabel!
    
    let transparentView = UIView()
    let tableView = UITableView()
    
    var selectedButton = UIButton()
    var dataSource = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
        coin1btn.layer.cornerRadius = 10
        coin1btn.layer.borderWidth = 1
        coin1btn.layer.borderColor = UIColor.link.cgColor
        done.layer.cornerRadius = 10
        BRL.layer.masksToBounds = true
        BRL.layer.cornerRadius = 10
        BRL.layer.borderWidth = 1
        BRL.layer.borderColor = UIColor.lightGray.cgColor
        selectedCoin.layer.masksToBounds = true
        selectedCoin.layer.cornerRadius = 10
        selectedCoin.layer.borderWidth = 1
        selectedCoin.layer.borderColor = UIColor.lightGray.cgColor
        
        
    }
   
    
    func addTransparentView(frames: CGRect){
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)
        tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        self.view.addSubview(tableView)
        tableView.layer.cornerRadius = 5
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        tableView.reloadData()
        
        let tapgest = UITapGestureRecognizer(target: self, action:#selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgest)
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1.0,initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {self.transparentView.alpha = 0.5
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: CGFloat(self.dataSource.count * 50))
        } , completion: nil)
    }
    
  var coinName : [String] = []
  var selectedCoins : [String] = []
  var brlCoins : [String] = []
    
     
      @IBAction func done(_ sender: Any) {
        performSegue(withIdentifier: "name", sender: "self")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        var vc = segue.destination as! HistoricoViewController
        vc.selectedCoins = self.selectedCoins
        vc.brlCoins = self.brlCoins
        vc.coinName = self.coinName
        
    }
    
    
    
    @objc func removeTransparentView() {
        let frames = selectedButton.frame
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1.0,initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {self.transparentView.alpha = 0
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        }, completion: nil)
    }
    
    @IBAction func selectCoin1(_ sender: Any) {
        dataSource = ["Dólar Americano","Dólar Canadense","Euro","Yen","Yuan"]
        selectedButton = coin1btn
        addTransparentView(frames: coin1btn.frame)
    }
    
 
    @IBAction func convert(_ sender:UIButton) {
        
        if coin1btn.currentTitle == "Selecione uma Moeda" {
            return
        }
        var coinDict:[String:String] = ["Dólar Americano":"USD_BRL","Dólar Canadense":"CAD_BRL","Euro":"EUR_BRL","Yen":"JPY_BRL","Yuan":"CNY_BRL"]

        let url = "https://free.currconv.com/api/v7/convert?q=" + coinDict[coin1btn.currentTitle!]! + "&compact=ultra&apiKey=065f86fd1c724eb23fc9"
        //URL
      //  let url = "https://free.currconv.com/api/v7/convert?q=CAD_BRL,BRL_USD&compact=ultra&apiKey=065f86fd1c724eb23fc9"
        //let url = "https://economia.awesomeapi.com.br/json/all/:USD"
        URLSession.shared.dataTask(with: URL(string:url)!, completionHandler: { data, response, error in
        
            guard let data = data, error == nil else {
          print("Algo deu errado")
            return
        }
            print(data)
        var result: Response?
        do {
            result = try JSONDecoder().decode(Response.self, from: data)
            
        }
        catch{
            print("Conversão falhou\(error.localizedDescription)")
        }
        guard let json = result else {
            return
        }
            
        DispatchQueue.main.async {
           var aux = (Int(self.selectedCoin.text!))
            if (aux == nil){
                return
            }
            if (coinDict[self.coin1btn.currentTitle!]! == "USD_BRL"){
                var qtd = json.USD_BRL!
                let double = (Double(self.selectedCoin.text!))
                qtd = qtd * double!
                let txt = String(qtd)
                self.BRL.text = txt
            }else if (coinDict[self.coin1btn.currentTitle!]! == "CAD_BRL"){
                var qtd = json.CAD_BRL!
                let double = (Double(self.selectedCoin.text!))
                qtd = qtd * double!
                let txt = String(qtd)
                self.BRL.text = txt
            }else if (coinDict[self.coin1btn.currentTitle!]! == "EUR_BRL"){
                var qtd = json.EUR_BRL!
                let double = (Double(self.selectedCoin.text!))
                qtd = qtd * double!
                let txt = String(qtd)
                self.BRL.text = txt
            }else if (coinDict[self.coin1btn.currentTitle!]! == "JPY_BRL"){
                var qtd = json.JPY_BRL!
                let double = (Double(self.selectedCoin.text!))
                qtd = qtd * double!
                let txt = String(qtd)
                self.BRL.text = txt
            }else if (coinDict[self.coin1btn.currentTitle!]! == "CNY_BRL"){
                var qtd = json.CNY_BRL!
                let double = (Double(self.selectedCoin.text!))
                qtd = qtd * double!
                let txt = String(qtd)
                self.BRL.text = txt
            }
            self.selectedCoins.insert(self.selectedCoin.text!,at: 0)
            self.brlCoins.insert(self.BRL.text!,at: 0)
            self.coinName.insert(self.coin1btn.currentTitle!, at: 0)
            }
        }).resume()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return dataSource.count
        
       }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        selectedButton.setTitle(dataSource[indexPath.row], for: .normal)
        removeTransparentView()
    }
}

