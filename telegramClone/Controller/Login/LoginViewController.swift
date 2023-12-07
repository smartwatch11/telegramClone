//
//  LoginViewController.swift
//  telegramClone
//
//  Created by Egor Rybin on 14.06.2023.
//

import UIKit

protocol LoginViewControllerDelegate {
    func openRegVC()
    func openAuthVC()
    func closeVC()
    func startApp()
}

class LoginViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var slides: [Slides] = []
    let slidesSlider = SliderSlides()
    var authVC: AuthViewController!
    var regVC: RegViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        slides = slidesSlider.getSlides()
    }
    
    func configCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .gray
        collectionView.isPagingEnabled = true
        
        self.view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: SlideCollectionViewCell.reusedId, bundle: nil), forCellWithReuseIdentifier: SlideCollectionViewCell.reusedId)
        
    }
    
}
    
extension LoginViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SlideCollectionViewCell.reusedId, for: indexPath) as! SlideCollectionViewCell
        cell.delegate = self
        let slide = slides[indexPath.row]
        cell.configure(slide: slide)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.view.frame.size
    }
}
    
extension LoginViewController: LoginViewControllerDelegate{

    func openRegVC() {
        if regVC == nil {
            regVC = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "RegViewController") as! RegViewController?
        }
        regVC.delegate = self
        self.view.insertSubview(regVC.view, at: 1)
    }
    
    func openAuthVC() {
        if authVC == nil {
            authVC = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "AuthViewController") as! AuthViewController?
        }
        authVC.delegate = self
        self.view.insertSubview(authVC.view, at: 1)
    }
    
    func closeVC() {
        if authVC != nil {
            authVC.view.removeFromSuperview()
            authVC = nil
        }
        
        if regVC != nil {
            regVC.view.removeFromSuperview()
            regVC = nil
        }
    }
    
    func startApp() {
        let startVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "AppViewController")
        self.view.insertSubview(startVC.view, at: 2)
    }
    
}
