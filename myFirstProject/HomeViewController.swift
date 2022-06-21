//
//  HomeViewController.swift
//  myFirstProject
//
//  Created by Sarah S on 06/06/2022.
//

import UIKit
import Firebase


class HomeViewController: UIViewController{

    @IBOutlet weak var addRecoBtn: UIButton!
    @IBOutlet weak var recoCV: UICollectionView!
    public var recos: [Recommendation] = []

    let db = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()

//                if let layout = recoCV?.collectionViewLayout as? PinterestLayout {
//                  layout.delegate = self
//                }
                recoCV?.backgroundColor = .clear
                recoCV?.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)

        recoCV.register(
           UINib(nibName: "MyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "item1"
        )
        recoCV.delegate = self
        recoCV.dataSource = self
        
        
       // addRecoBtn.frame = CGRect(x: 160, y: 100, width: 50, height: 50)
        addRecoBtn.layer.cornerRadius = 0.5 * addRecoBtn.bounds.size.width
        addRecoBtn.clipsToBounds = true
        
        //addRecoBtn.layer.cornerRadius = 100
        //addRecoBtn.clipsToBounds = true
    
        
    }
 
    override func viewWillAppear(_ animated: Bool) {
        
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
                        
                        //for i in 1...4 {
                        self.recos.append(reco)
                        //}
                        DispatchQueue.main.async {
                            self.recoCV.reloadData()
                            print(self.recos[0])
                            
                        }
                        
                    }

                }
            } // quary
        }//dis
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDetails" {
        let destVC = segue.destination as! RecoDetaillViewController
        
        let selectedReco = recoCV.indexPathsForSelectedItems![0][1]
        
//print("🟡\(selectedRow)")
        
        destVC.reciveData = recos[selectedReco]
        }
    }
    
    
    
    @IBAction func goToAdd(_ sender: Any) {
        performSegue(withIdentifier: "goToAddReco", sender: self)
    }
    
    
    
}

extension HomeViewController: UICollectionViewDataSource {

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    recos.count
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
   
    
    let cell =  recoCV.dequeueReusableCell(withReuseIdentifier: "item1", for: indexPath) as! MyCollectionViewCell
     //cell.backgroundColor = colorData[indexPath.row]

//print(recos[indexPath.row].ItemName)
        cell.recoTxt.text = recos[indexPath.row].ItemName
    cell.configure(with: recos[indexPath.row])
    cell.recoImg.loadImageUsingCacheWithUrlString(recos[indexPath.row].img)

        //cell.recoImg.image = UIImage(named: "default")

    return cell
    
}
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//      let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
//      return CGSize(width: itemSize, height: itemSize)
//    }
    
    
 }

extension HomeViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print("item at \(indexPath.section)/\(indexPath.item) tapped")
      
      self.performSegue(withIdentifier: "showDetails", sender: self)
   
      
  }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let columns: CGFloat = 2
        let collectionViewWidth = collectionView.bounds.width
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let spaceBetweenCells = flowLayout.minimumInteritemSpacing * (columns - 1)
        let adjustedWidth = collectionViewWidth - spaceBetweenCells
        let width: CGFloat = floor(adjustedWidth / columns) - 20
        var height: CGFloat
        if (indexPath.row % 2 == 0){
             height = 250 }
        else {
             height = 250
        }
        return CGSize(width: width, height: height)
    }

}



//currently not used
extension HomeViewController: PinterestLayoutDelegate {
  func collectionView(
    _ collectionView: UICollectionView,
    heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
    return loadImageUsingCacheWithUrlString(recos[indexPath.row].img).size.height
  }
    
    func loadImageUsingCacheWithUrlString(_ urlString: String) -> UIImage {
        //check cache for image first
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
           // self.image = cachedImage
            return cachedImage
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
                    let v = imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                    
                    return v
                }
            })
            
        }).resume()
        return UIImage(named: "default")!
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

