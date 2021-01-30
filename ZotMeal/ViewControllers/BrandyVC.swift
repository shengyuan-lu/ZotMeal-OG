//
//  ViewController.swift
//  ZotMeal
//
//  Created by Shengyuan Lu on 1/29/21.
//

import UIKit

class BrandyVC: UIViewController {
    
    // IBOutlet
    @IBOutlet weak var foodTableView: UITableView!
    
    // DataStructure
    var foodArray:[Food] = []
    let model = JsonModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model.parseLocalJSON(fileName: "Brandy")
    }

}

extension BrandyVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCell") as! FoodCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
}

