//
//  HomeViewController.swift
//  myFirstProject
//
//  Created by Sarah S on 06/06/2022.
//

import UIKit
import Firebase


class HomeViewController: UIViewController{

    @IBOutlet weak var recoCV: UICollectionView!
    public var recos: [Recommendation] = []

    let db = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.async {
            
        
            self.db.collection("Recomendations")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {

                    for document in querySnapshot!.documents {
                        let data = document.data()
                      
                        var reco: Recommendation = Recommendation(
                            img: data["RecoImage"] as! String,
                            Place: data["RecoPlace"] as! String,
                            ItemName: data["RecoName"] as! String,
                            RecoText: data["RecoText"] as! String,
                            URL: data["RecoURL"] as! String,
                            Author: data["AuthorUid"] as! String,
                            postDate: "20:32 Wed, 30 Oct 2019" ) //data["postDate"] as! String )
                        
                        self.recos.append(reco)
                        self.recoCV.reloadData()
                        
                    }

                }
            } // quary
        }//dis
        
        recoCV.register(
            UINib(nibName: "MyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "item1"
                               )
        
        recoCV.delegate = self
        recoCV.dataSource = self
        
    }
 

}

extension HomeViewController: UICollectionViewDataSource {

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    recos.count
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
   
    
    let cell =  recoCV.dequeueReusableCell(withReuseIdentifier: "item1", for: indexPath) as! MyCollectionViewCell
     //cell.backgroundColor = colorData[indexPath.row]

print(recos[indexPath.row].ItemName)
        cell.recoTxt.text = recos[indexPath.row].ItemName
    cell.configure(with: recos[indexPath.row])
    cell.recoImg.loadImageUsingCacheWithUrlString(recos[indexPath.row].img)

        //cell.recoImg.image = UIImage(named: "default")

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


let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
    
    func loadImageUsingCacheWithUrlString(_ urlString: String) {
        
        self.image = nil
        
        //check cache for image first
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = cachedImage
            return
        }
        
        //otherwise fire off a new download
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            //download hit an error so lets return out
            if let error = error {
                print(error)
                return
            }
            
            DispatchQueue.main.async(execute: {
                
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                    
                    self.image = downloadedImage
                }
            })
            
        }).resume()
    }
    
}
