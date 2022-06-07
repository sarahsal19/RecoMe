//
//  HomeViewController.swift
//  myFirstProject
//
//  Created by Sarah S on 06/06/2022.
//

import UIKit

class HomeViewController: UIViewController{

    @IBOutlet weak var recoCV: UICollectionView!
   public var recos: [Recommendation] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        recoCV.dataSource = self
        recoCV.delegate = self
        
    }
 

}

extension HomeViewController: UICollectionViewDataSource {

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    recos.count
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
   let cell =  recoCV.dequeueReusableCell(withReuseIdentifier: "item1", for: indexPath)
    return cell
}

}


extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let columns: CGFloat = 2
        let collectionViewWidth = collectionView.bounds.width
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let spaceBetweenCells = flowLayout.minimumInteritemSpacing * (columns - 1)
        let adjustedWidth = collectionViewWidth - spaceBetweenCells
        let width: CGFloat = floor(adjustedWidth / columns)
        let height: CGFloat = 100 //اقدر اخليها تجيني من فنكشن تطلع لي كم طول البيانات اللي عندي ، عشان تصير زي بينترست لها احجام مختلفة
        return CGSize(width: width, height: height)
    }

}
