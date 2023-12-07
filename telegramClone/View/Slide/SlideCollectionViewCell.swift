//
//  SlideCollectionViewCell.swift
//  telegramClone
//
//  Created by Egor Rybin on 18.06.2023.
//

import UIKit

class SlideCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var authBtn: UIButton!
    @IBOutlet weak var regBtn: UIButton!
    @IBOutlet weak var slideImage: UIImageView!
    @IBOutlet weak var descriptionText: UILabel!
    static let reusedId = "SlideCollectionViewCell"
    @IBOutlet weak var pageControll: UIPageControl!
    var delegate: LoginViewControllerDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(slide: Slides) {
       slideImage.image = slide.image
       descriptionText.text = slide.text
        
        pageControll.currentPage = slide.id-1
        
        if slide.id == 3 {
            authBtn.isHidden = false
            regBtn.isHidden = false
        }
    }
    
    @IBAction func regBtnClick(_ sender: Any) {
        delegate.openRegVC()
    }
    
    @IBAction func authBtnClick(_ sender: Any) {
        delegate.openAuthVC()
    }
}
