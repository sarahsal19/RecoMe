//
//  RecoDetaillViewController.swift
//  myFirstProject
//
//  Created by Sarah S on 06/06/2022.
//

import UIKit

class RecoDetaillViewController: UIViewController {

    @IBOutlet weak var itemName: UILabel!
    var reciveData: Recommendation = Recommendation(img: "String", Place: "String", ItemName: "String", RecoText: "String", URL: "String", Author: "String", postDate: "String")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemName.text = reciveData.ItemName
    }
    
}
