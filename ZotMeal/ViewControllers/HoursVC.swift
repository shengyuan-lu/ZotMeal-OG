//
//  HoursVC.swift
//  ZotMeal
//
//  Created by Jingqi Yao on 2021/1/31.
//

import UIKit

class HoursVC: UIViewController {
    
    struct Meal {
        var name, time: String
    }
    
    var weekdays: Array<Meal> = []
    var weekends: Array<Meal> = []
    
    
    @IBOutlet weak var hoursTableView: UITableView!
    let model = JsonModel()
    let myRefreshControl = UIRefreshControl()
    var refresh = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initHourArrays()
        
        hoursTableView.dataSource = self
        hoursTableView.delegate = self
        
        myRefreshControl.addTarget(self, action: #selector(getAPIData), for: .valueChanged)
        hoursTableView.refreshControl = myRefreshControl
    }
    
    @objc func getAPIData() {
        self.hoursTableView.reloadData()
        self.myRefreshControl.endRefreshing()
    }
    
    func initHourArrays() {
        weekdays.append(Meal(name: "Breakfast", time: "7:15AM - 11:00AM"))
        weekdays.append(Meal(name: "Lunch", time: "11:00AM - 4:00PM"))
        weekdays.append(Meal(name: "Dinner", time: "4:00PM - 8:00PM"))
        weekends.append(Meal(name: "Continental Breakfast", time: "9:00AM - 11:00AM"))
        weekends.append(Meal(name: "Brunch", time: "11:00AM - 4:00PM"))
        weekends.append(Meal(name: "Dinner", time: "4:00PM - 8:00PM"))
    }

}

extension HoursVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isWeekday() {
            return weekdays.count
        }
        return weekends.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HoursCell") as! HoursCell
        if isWeekday() {
            cell.nameLabel.text = weekdays[indexPath.row].name
            cell.timeLabel.text = weekdays[indexPath.row].time
        } else {
            cell.nameLabel.text = weekends[indexPath.row].name
            cell.timeLabel.text = weekends[indexPath.row].time
        }
        return cell
    }
    
    func isWeekday() -> Bool {
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.weekday, from: date)
        return (day >= 2 && day <= 6)
    }

}
