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
        configTableView()
    }
    
    func configTableView() {
        CreditTableView.dataSource = self
        CreditTableView.delegate = self
        
        CreditTableView.refreshControl = nil
        CreditTableView.isUserInteractionEnabled = true
        CreditTableView.isScrollEnabled = true
        CreditTableView.allowsSelection = false
    }
    
    func initArray() {
        StandfordRejects.append(Genius(name: "Shengyuan Lu", pic: "ShengyuanLu", bio: "I am a Stanford reject. So I am here to prove that they missed a genius. Yeah, I make apps too."))
        StandfordRejects.append(Genius(name: "Yinghao(Max) Liu", pic: "YinghaoLiu", bio: "UCI class of 2024. Computer science and engineering major. Former founder and co-captain of FIRST robotics team 7760. Web development enthusiast. Photographer."))
        StandfordRejects.append(Genius(name: "Jingqi Yao", pic: "JingqiYao", bio: "UCI class of 2023, CS major. iOS, web dev, machine learning, Kpop dance, coffee… interested in everything except C"))
        roles = ["Developers"]
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StandfordRejects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CreditCell") as! CreditCell
        cell.nameLabel.text = StandfordRejects[indexPath.row].name
        cell.bioTextView.text = StandfordRejects[indexPath.row].bio
        cell.profileImageView.image = UIImage(named: StandfordRejects[indexPath.row].pic)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return roles[section]
    }
}
