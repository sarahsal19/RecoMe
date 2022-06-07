//
//  RecoDetaillViewController.swift
//  myFirstProject
//
//  Created by Sarah S on 06/06/2022.
//

import UIKit

class RecoDetaillViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}




//class DemoViewController: UIViewController {
//  @IBAction func selectMediaAction(_ sender: Any) {
//    // Must import `MobileCoreServices`
//    let imageMediaType = kUTTypeImage as String
//
//    // Define and present the `UIImagePickerController`
//    let pickerController = UIImagePickerController()
//    pickerController.sourceType = .photoLibrary
//    pickerController.mediaTypes = [imageMediaType]
//    pickerController.delegate = self
//    present(pickerController, animated: true, completion: nil)
//  }
//}
//
//extension DemoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//    // Check for the media type
//    let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! CFString
//    if mediaType == kUTTypeImage {
//      let imageURL = info[UIImagePickerController.InfoKey.imageURL] as! URL
//      // Handle your logic here, e.g. uploading file to Cloud Storage for Firebase
//    }
//
//    picker.dismiss(animated: true, completion: nil)
//  }
//}
