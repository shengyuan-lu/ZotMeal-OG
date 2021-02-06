import UIKit
import AlamofireImage
import Lottie
import SkeletonView

class BrandyVC: UIViewController, JSONProtocol {
    
    // IBOutlet
    @IBOutlet weak var foodTableView: UITableView!
    
    // Data Structure
    var categoryArray = [Category]()
    var hiddenSections = Set<Int>()
    let model = JsonModel()
    let myRefreshControl = UIRefreshControl()
    
    // Create an animation view
    var animationView: AnimationView?
    
    // This will be used to determine when the tableview is being refreshed
    var refresh = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load JSON from file
        model.delegate = self
        model.loadRemoteJSON(fromURL: Constants.brandyURL)
        
        if self.categoryArray.count == 0 {
            categoryArray = self.model.loadLocalJSON(filename: "Brandy") ?? []
            print("Display Local JSON")
        }
        
        // StartAnimation
        startAnimation()
        
        // TableView
        foodTableView.dataSource = self
        foodTableView.delegate = self
        
        myRefreshControl.addTarget(self, action: #selector(getAPIData), for: .valueChanged)
        foodTableView.refreshControl = myRefreshControl
        
        // Debug Print
        // print(categoryArray)
        
        // stop animations
        _ = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { timer in
            self.stopAnimation()
            self.refresh = false
            
            self.foodTableView.reloadData()
        }
        
    }
    
    @objc func getAPIData() {
        
        // Load remote JSON Again
        model.loadRemoteJSON(fromURL: Constants.brandyURL)
        
        // Refresh Table View
        self.foodTableView.reloadData()
        
        // Stop table view refresh control
        self.myRefreshControl.endRefreshing()
        
    }
    
    func categoryRetrieved(_ category: [Category]) {
        self.categoryArray = category
        
        // collapse all categories
        for row in 0..<self.categoryArray.count {
            self.hiddenSections.insert(row)
        }
    }
    
    func error() {
        errorPopUP()
        self.myRefreshControl.endRefreshing()
    }
    
    
}

// Table View Methods
extension BrandyVC: UITableViewDelegate, UITableViewDataSource {
    
    // How many sections do we have
    func numberOfSections(in tableView: UITableView) -> Int {
        return categoryArray.count
    }
    
    // How many rows do we have for each section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.hiddenSections.contains(section) {
            return 0
        } else {
            return categoryArray[section].menu.count
        }
    }
    
    
    // What will each cell look like?
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCell") as! FoodCell
        
        // Pass in the food property to be a food object
        cell.food = categoryArray[indexPath.section].menu[indexPath.row]
        
        // Do we need to show skeleton?
        if self.refresh {
            cell.showAnimatedSkeleton()
        } else {
            cell.hideSkeleton()
        }
        
        return cell
    }
    
    // What's the distance between each section?
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
    
    // What's the header's height?
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    // What will the header look like?
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // 1
        let sectionButton = UIButton()
        
        
        if self.refresh {
            sectionButton.showAnimatedSkeleton()
        } else {
            sectionButton.hideSkeleton()
        }
        
        // 2
        sectionButton.setTitle(categoryArray[section].categoryName, for: .normal)
        
        sectionButton.frame = CGRect(x: 100, y: 100, width: 100, height: 80)
        
        // 3
        sectionButton.backgroundColor = .gray
        sectionButton.layer.cornerRadius = 10
        sectionButton.layer.borderWidth = 1
        sectionButton.layer.borderColor = UIColor.gray.cgColor
        
        //button text
        sectionButton.contentHorizontalAlignment = .left
        
        // 4
        sectionButton.tag = section
        
        // 5
        sectionButton.addTarget(self, action: #selector(self.hideSection(sender:)), for: .touchUpInside)
        
        return sectionButton
    }
    
    
    @objc private func hideSection(sender: UIButton) {
        let section = sender.tag
        func indexPathsForSection() -> [IndexPath] {
            var indexPaths = [IndexPath]()
            
            for row in 0..<self.categoryArray[section].menu.count {
                indexPaths.append(IndexPath(row: row, section: section))
            }
            
            return indexPaths
        }
        
        if self.hiddenSections.contains(section) {
            self.hiddenSections.remove(section)
            self.foodTableView.insertRows(at: indexPathsForSection(), with: .fade)
        } else {
            self.hiddenSections.insert(section)
            self.foodTableView.deleteRows(at: indexPathsForSection(), with: .fade)
        }
    }
    
    // What if I select a cell -> perform segue
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "segueToWeb", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
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

// Skeleton view
extension BrandyVC: SkeletonTableViewDataSource {
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "FoodCell"
    }
    
}


// Lottie Animation
extension BrandyVC {
    // Call animation functions to start
    func startAnimation() {
        
        self.foodTableView.isScrollEnabled = false
        self.foodTableView.isUserInteractionEnabled = false
        
        animationView = .init(name: "17100-food")
        
        // 1. Set the size to the frame
        
        // animationView!.frame = view.bounds
        animationView?.frame = CGRect(x: view.frame.width/2 - 125, y: view.frame.height/2 - 125, width: 250, height: 250)
        
        // fit the animation
        animationView!.contentMode = .scaleAspectFit
        view.addSubview(animationView!)
        
        // 2. Set animation loop mode
        animationView!.loopMode = .loop
        
        // 3. Animation speed - Larger number = false
        animationView!.animationSpeed = 1
        
        // 4. Play animation
        animationView!.play()
        
        view.showGradientSkeleton()
        
    }
    
    // Call animation functions to stop
    @objc func stopAnimation() {
        self.foodTableView.isScrollEnabled = true
        self.foodTableView.isUserInteractionEnabled = true
        
        // 1. Stop Animation
        animationView?.stop()
        
        // 2. Change the subview to last and remove the current subview
        view.subviews.last?.removeFromSuperview()
        
        // 3. Set skeleton refresh to false
        refresh = false
        
        // 4. Refresh Table View
        self.foodTableView.reloadData()
        
        view.hideSkeleton()
    }
}

extension BrandyVC {
    func errorPopUP() {
        // Create new Alert
        let dialogMessage = UIAlertController(title: "Error", message: "Can not fetch the current menu from server. A sample menu is displayed.", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
        })
        
        //Add OK button to a dialog message
        dialogMessage.addAction(ok)
        // Present Alert to
        self.present(dialogMessage, animated: true, completion: nil)
    }
}

