//
//  MessageListViewController.swift
//  telegramClone
//
//  Created by Egor Rybin on 17.07.2023.
//

import UIKit
import MessageKit

class MessageListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }

}


extension MessageListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Jony"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(indexPath.row)
        let vc = ChatViewController()
        vc.chatID = "firstChatId"
        vc.otherId = "uhzLE6DZppZIlKb8UBpqZvzHPbj2"
        navigationController?.pushViewController(vc, animated: true)
    }
}
