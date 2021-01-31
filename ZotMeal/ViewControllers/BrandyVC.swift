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
    var categoryArray:[Category] = []
    let model = JsonModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load JSON from file
        categoryArray = model.loadLocalJSON(filename: "Brandy") ?? []
        
        // Debug Print
        // print(categoryArray)
        
        foodTableView.dataSource = self
        foodTableView.delegate = self
        
        view.addSubview(foodTableView)
    }

    
}

// Table View Methods
extension BrandyVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray[section].menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCell") as! FoodCell
        print("sadfasf", categoryArray[indexPath.section].menu[indexPath.row])
        cell.food = categoryArray[indexPath.section].menu[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "segueToWeb", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categoryArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categoryArray[section].categoryName
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "HelveticaNeue", size: 25)
        header.textLabel?.textAlignment = .center
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    
}

// Segue
extension BrandyVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueToWeb" {
            // Confirm that a video was selected
            guard foodTableView.indexPathForSelectedRow != nil else {
                return
            }
            
            // Get a reference to the video that was tapped on
            let selectedCategory = categoryArray[foodTableView.indexPathForSelectedRow!.section]
            let selectedFood = selectedCategory.menu[foodTableView.indexPathForSelectedRow!.row]
            
            // Get a reference to the detail view controller
            let webVC = segue.destination as! WebVC
            
            // Set the video property of the detail view controller
            webVC.name = selectedFood.name
            
            print(selectedFood.name)
        }
    }
}

