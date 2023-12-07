//
//  UsersTableViewCell.swift
//  telegramClone
//
//  Created by Egor Rybin on 05.07.2023.
//

import UIKit

class UsersTableViewCell: UITableViewCell {

    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    static let reusedId = "UsersTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        settingCell()
    }
    
    func configCell(_ name: String){
        userName.text = name
    }
    
    func settingCell(){
        parentView.layer.cornerRadius = 10
        userImage.layer.cornerRadius = userImage.frame.width/5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
