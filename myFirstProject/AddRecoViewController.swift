//
//  AddRecoViewController.swift
//  myFirstProject
//
//  Created by Sarah S on 06/06/2022.
//

import UIKit
import FirebaseStorage
import Firebase
import MobileCoreServices


class AddRecoViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
 
    let db = Firestore.firestore()
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var recoTextView: UITextView!
    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var urlField: UITextField!
    let cloudDocID = UUID().uuidString
    
    @IBOutlet weak var publishRecoBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recoTextView.delegate = self
                placeholderLabel.text = "ما هي توصيتك ؟"
//                placeholderLabel.font = .italicSystemFont(ofSize: (recoTextView.font?.pointSize)!)
//                placeholderLabel.sizeToFit()
//                recoTextView.addSubview(placeholderLabel)
//                placeholderLabel.frame.origin = CGPoint(x: 5, y: (recoTextView.font?.pointSize)! / 2)
                placeholderLabel.textColor = .tertiaryLabel
                placeholderLabel.isHidden = !recoTextView.text.isEmpty

        publishRecoBtn.layer.cornerRadius = 15
        publishRecoBtn.clipsToBounds = true
        
        
    }
 
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      // Check for the media type
      let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! CFString
      if mediaType == kUTTypeImage {
     if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                                  self.imageView.image = image
            }
        let imageURL = info[UIImagePickerController.InfoKey.imageURL] as! URL
      uploadFile(fileUrl: imageURL)

      }

      picker.dismiss(animated: true, completion: nil)
    }
        
    

    @IBAction func selectMediaAction(_ sender: Any) {
        // Must import `MobileCoreServices`
            let imageMediaType = kUTTypeImage as String

            // Define and present the `UIImagePickerController`
            let pickerController = UIImagePickerController()
            pickerController.sourceType = .photoLibrary
            pickerController.mediaTypes = [imageMediaType]
            pickerController.delegate = self
            present(pickerController, animated: true, completion: nil)
    }

    
    
    @IBAction func publishReco(_ sender: Any) {
        uploadToCloud()
    }
    
    
    func uploadFile(fileUrl: URL) {
      do {
        // Create file name
        let fileExtension = fileUrl.pathExtension
        let fileName = "\((UUID().uuidString))\(fileExtension)"
        let metaData = StorageMetadata()
        let storageReference = Storage.storage().reference().child(fileName)
        let currentUploadTask = storageReference.putFile(from: fileUrl, metadata: metaData) { (storageMetaData, error) in
          if let error = error {
            print("Upload error: \(error.localizedDescription)")
            return
          }
                                                                                    
          // Show UIAlertController here
          print("Image file: \(fileName) is uploaded! View it at Firebase console!")
                                                                                    
          storageReference.downloadURL { (url, error) in
            if let error = error  {
              print("Error on getting download url: \(error.localizedDescription)")
              return
            }
            print("Download url of \(fileName) is \(url!.absoluteString)")
              
              self.db.collection("Recomendations").document(self.cloudDocID).setData( ["RecoImage": url!.absoluteString,
                  ])         { error in
                    
                    if error == nil {
                       // self.simpleAlert(title: "", messageTxt: "تم نشر التوصية بنجاح", btnText: "حسنًا")
                        print("🟩 Done in cloud")
                    }
                    else {
                        print("🔺 error in cloud")
                    }
                }
              
              
              
          }
        }
      } catch {
        print("Error on extracting data from url: \(error.localizedDescription)")
      }
    }
    
    
   
    func uploadToCloud(){
        guard let uid = Auth.auth().currentUser?.uid else {
            return }
        
        db.collection("Recomendations").document(self.cloudDocID).setData( ["AuthorUid":uid,
                      "RecoName":self.nameField.text,
                      "RecoPlace": self.locationField.text,
                     // "RecoImage": self.downloadURL,
                      "RecoText": self.recoTextView.text,
                      "RecoURL": self.urlField.text,
                      "postDate": "12/06/2022"
            ], merge: true) { error in
              
              if error == nil {
                  self.simpleAlert(title: "", messageTxt: "تم نشر التوصية بنجاح", btnText: "حسنًا")
              }
              else {
                  print("🔺 error in cloud")
              }
          }
    }
    
    
    
    func simpleAlert(title: String, messageTxt: String, btnText: String){

        let myAlert = UIAlertController(title: title, message: messageTxt, preferredStyle: .alert)
        let done = UIAlertAction(title: "Ok", style: .default) { (action) in
            print("ALERT DONE")
            self.dismiss(animated: true , completion: nil)
        }
        myAlert.addAction(done)
        present(myAlert, animated: true)
    }

}


extension AddRecoViewController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !recoTextView.text.isEmpty
    }
}

