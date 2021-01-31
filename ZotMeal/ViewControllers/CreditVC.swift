//
//  CreditVC.swift
//  ZotMeal
//
//  Created by Jingqi Yao on 2021/1/31.
//

import UIKit

class CreditVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    struct Genius {
        var name, pic, bio: String
    }
    
    var StandfordRejects: Array<Genius> = []
    var roles: Array<String> = []

    @IBOutlet weak var CreditTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initArray()
        
        CreditTableView.dataSource = self
        CreditTableView.delegate = self
        
        CreditTableView.refreshControl = nil
        
        CreditTableView.rowHeight = UITableView.automaticDimension
        CreditTableView.estimatedRowHeight = 225
    }
    
    func initArray() {
        StandfordRejects.append(Genius(name: "Shengyuan Lu", pic: "ShengyuanLu", bio: "I am a Stanford Reject. So I am here to prove that they missed a genius, basically. Yeah I make apps too."))
        StandfordRejects.append(Genius(name: "Yinghao(Max) Liu", pic: "YinghaoLiu", bio: "UCI class of 2024. Computer science and engineering major. Former founder and co-captain of FIRST robotics team 7760. Web development enthusiast. Photographer. Loves cycling and hiking."))
        StandfordRejects.append(Genius(name: "Jingqi Yao", pic: "JingqiYao", bio: "UCI class of 2023, CS major. iOS, web dev, machine learning, Kpop dance, coffee… interested in everything except C"))
        roles = ["Developers"]
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return StandfordRejects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CreditCell") as! CreditCell
        cell.nameLabel.text = StandfordRejects[indexPath.row].name
        cell.bioLabel.text = StandfordRejects[indexPath.row].bio
        cell.pictureVIew.image = UIImage(named: StandfordRejects[indexPath.row].pic)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return roles[section]
    }
}
