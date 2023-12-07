//
//  UsersViewController.swift
//  telegramClone
//
//  Created by Egor Rybin on 05.07.2023.
//

import UIKit

class UsersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let service = Service.shared
    var users = [CurrentUser]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "UsersTableViewCell", bundle: nil), forCellReuseIdentifier: UsersTableViewCell.reusedId)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        getUsers()
    }
    
    func getUsers(){
        service.getAllUsers {users in
            self.users = users
            self.tableView.reloadData()
        }
    }

}


extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsersTableViewCell", for: indexPath) as! UsersTableViewCell
        cell.selectionStyle = .none
        let name = users[indexPath.row]
        cell.configCell(name.email)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userId = users[indexPath.row].id
        let vc = ChatViewController()
        vc.otherId = userId
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
