//
//  ViewController.swift
//  ZotMeal
//
//  Created by Shengyuan Lu on 1/29/21.
//

import UIKit
import AlamofireImage
import Lottie
import SkeletonView

class BrandyVC: UIViewController {
    
    // IBOutlet
    @IBOutlet weak var foodTableView: UITableView!
    
    // DataStructure
    var categoryArray:[Category] = []
    let model = JsonModel()
    let myRefreshControl = UIRefreshControl()
    
    // Create an animation view
    var animationView: AnimationView?
    
    // This will be used to determine when the tableview is being refreshed
    var refresh = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // StartAnimation
        startAnimation()
        
        // Load JSON from file
        categoryArray = model.loadLocalJSON(filename: "Brandy") ?? []
        
        // Debug Print
        print(categoryArray)
        
        // TableView
        foodTableView.dataSource = self
        foodTableView.delegate = self
        myRefreshControl.addTarget(self, action: #selector(getAPIData), for: .valueChanged)
        foodTableView.refreshControl = myRefreshControl
        
        view.addSubview(foodTableView)
        
        // stop animations
        _ = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { timer in
            self.stopAnimation()
        }
    }
    
    @objc func getAPIData() {
        categoryArray = model.loadLocalJSON(filename: "Brandy") ?? []
        self.foodTableView.reloadData()
        self.myRefreshControl.endRefreshing()
    }

    
}

// Table View Methods
extension BrandyVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray[section].menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCell") as! FoodCell
  
        cell.food = categoryArray[indexPath.section].menu[indexPath.row]
        
        if self.refresh {
            cell.showAnimatedSkeleton()
        } else {
            cell.hideSkeleton()
        }
        
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

// Skeleton
extension BrandyVC: SkeletonTableViewDataSource {
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "FoodCell"
    }
    
    // Call animation functions to start
    func startAnimation() {
        
        animationView = .init(name: "4762-food-carousel")
        
        // 1. Set the size to the frame
        
        // animationView!.frame = view.bounds
        animationView?.frame = CGRect(x: view.frame.width/2 - 75, y: view.frame.height/2 - 75, width: 150, height: 150)
        
        // fit the animation
        animationView!.contentMode = .scaleAspectFit
        view.addSubview(animationView!)
        
        // 2. Set animation loop mode
        animationView!.loopMode = .loop
        
        // 3. Animation speed - Larger number = false
        animationView!.animationSpeed = 5
        
        // 4. Play animation
        animationView!.play()
        
    }
    
    // Call animation functions to stop
    @objc func stopAnimation() {
        // 1. Stop Animation
        animationView?.stop()
        
        // 2. Change the subview to last and remove the current subview
        view.subviews.last?.removeFromSuperview()
        
        // 3. Set skeleton refresh to false
        refresh = false
        
        // 4. Refresh Table View
        self.foodTableView.reloadData()
    }
    
}

