//
//  ViewController.swift
//  StretchyHeaderSample
//
//  Created by Alchemist on 10/8/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import UIKit

class StretchyHeaderVC: UICollectionViewController {
    @IBOutlet weak var stretchyCollectionView: UICollectionView!
    let nibID = "NormalCell"
    let headerID = "HeaderView"
    let spaces :CGFloat =  16
    var headerView:HeaderView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupStretchyCollection()
        self.setupLayOutForHeader()
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }


}


extension StretchyHeaderVC : UICollectionViewDelegateFlowLayout{
    func setupStretchyCollection(){

        self.collectionView.register(UINib(nibName: self.nibID, bundle: nil), forCellWithReuseIdentifier: self.nibID)
        self.collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.headerID)
        self.collectionView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.collectionView.contentInsetAdjustmentBehavior = .never
    }
    func setupLayOutForHeader(){
        if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = .init(top: self.spaces, left: self.spaces, bottom: self.spaces, right: self.spaces)
        }
        
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.nibID, for: indexPath) as? NormalCell else {
            return UICollectionViewCell()
        }
        cell.containerView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 2 * self.spaces, height: 50)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.spaces
    }
    
    
    //Header Implementation
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
         headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: self.headerID, for: indexPath) as? HeaderView
        return headerView!
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 250)
    }
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contenctOffsety = scrollView.contentOffset.y
        if contenctOffsety > 0 {
            headerView?.animator.fractionComplete = 0.0
            return
        }
        self.headerView?.animator.fractionComplete = abs(contenctOffsety) / 100
    }
}

