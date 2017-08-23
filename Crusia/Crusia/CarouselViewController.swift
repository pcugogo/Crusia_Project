//
//  CarouselViewController.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 22..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit

class CarouselViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!

    var total = 0
    var indexPath: IndexPath?
    var house: House!
    var centerPoint : CGPoint {
        get {
            return CGPoint(x: collectionView.center.x + collectionView.contentOffset.x, y: collectionView.center.y + collectionView.contentOffset.y);
        }
    }
    
    var number: Int = 0
    
    // 스테이더스 바 숨기기
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    var centerCellIndexPath: IndexPath? {
        
        if let centerIndexPath = collectionView.indexPathForItem(at: self.centerPoint) {
            return centerIndexPath
        }
        return nil
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Carousel view did load")
        
        // 블러 이펙트
        backgroundImageView.image = UIImage(named: "cloud")
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        // 콜렉션뷰 투명하게 만들기
        collectionView.backgroundColor = UIColor.clear
        
        self.totalLabel.text = String(total)
        print("음 인덱스")

        self.countLabel.text = String(1)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func configureInitialInfo(house: House, indexPath: IndexPath) {
        self.house = house
        print("캐로셀...")
        print(indexPath)
        
        self.total = house.houseImages.arrayValue.count
        self.indexPath = indexPath
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return house.houseImages.array?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let reuseIdentifier = "Cell"
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CarouselViewCell
        
        if let url = house.houseImages[indexPath.row]["image"].url {
            cell.configure(imageURL:  url)
        }
        
        return cell
    }
    
    // image size를 collectionview size에 맞춘다.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height:(collectionView.frame.height))
    }
    

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        targetContentOffset.pointee = scrollView.contentOffset
        var cellToSwipe: Int = Int(scrollView.contentOffset.x/375 + 0.5)
        
        if cellToSwipe < 0 {
            cellToSwipe = 0
        } else if cellToSwipe >= (house.houseImages.array?.count)! {
            cellToSwipe = (house.houseImages.array?.count)! - 1
        }
        
        let indexPath = IndexPath(row: cellToSwipe, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        countLabel.text = String(indexPath.row + 1)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAccessary"{
            
            let destinationController = segue.destination as! AccessaryViewController
            
            
            //            destinationController.house = self.house
            
            let indexPath = collectionView.indexPathsForVisibleItems[0]
            print("인덱스 페스")
            print(indexPath)
            
            destinationController.configureAccessaryView(house: house, indexPath: indexPath)
        }
    }
    

    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let indexPath = collectionView.indexPathsForVisibleItems[0]
//
//        self.countLabel.text = String(describing: indexPath.row + 1)
//    }
    
    @IBAction func dismissButtonTouched(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
