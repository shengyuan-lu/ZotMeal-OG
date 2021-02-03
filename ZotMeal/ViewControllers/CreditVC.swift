//
//  CreditVC.swift
//  ZotMeal
//
//  Created by Jingqi Yao on 2021/1/31.
//

import UIKit

class CreditVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    struct Genius {
        var name: String
        var pic: String
        var bio: String
    }
    
    var standfordRejects: Array<Genius> = []
    var roles: Array<String> = []

    @IBOutlet weak var creditTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initArray()
        configTableView()
    }
    
    func configTableView() {
        creditTableView.dataSource = self
        creditTableView.delegate = self

        creditTableView.refreshControl = nil
        creditTableView.isUserInteractionEnabled = true
        creditTableView.isScrollEnabled = true
        creditTableView.allowsSelection = false
    }
    
    func initArray() {
        standfordRejects.append(Genius(name: "Shengyuan Lu", pic: "ShengyuanLu", bio: "I am a Stanford reject. So I am here to prove that they missed a genius. Yeah, I make apps too."))
        standfordRejects.append(Genius(name: "Yinghao(Max) Liu", pic: "YinghaoLiu", bio: "UCI class of 2024. Computer science and engineering major. Former founder and co-captain of FIRST robotics team 7760. Web development enthusiast. Photographer."))
        standfordRejects.append(Genius(name: "Jingqi Yao", pic: "JingqiYao", bio: "UCI class of 2023, CS major. iOS, web dev, machine learning, Kpop dance, coffee… interested in everything except C"))
        roles = ["Developers"]
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return standfordRejects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CreditCell") as! CreditCell
        cell.nameLabel.text = standfordRejects[indexPath.row].name
        cell.bioTextView.text = standfordRejects[indexPath.row].bio
        cell.profileImageView.image = UIImage(named: standfordRejects[indexPath.row].pic)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return roles[section]
    }
}
