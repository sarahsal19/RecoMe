//
//  SignUpViewController.swift
//  myFirstProject
//
//  Created by Sarah S on 06/06/2022.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var signUpBtn: UIButton!
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpBtn.layer.cornerRadius = 15
        signUpBtn.clipsToBounds = true
    }
    
    @IBAction func signUp(_ sender: Any) {
        Auth.auth().createUser(withEmail: emailField.text!, password: passField.text!) { authResult, error in
            if error == nil {
                simpleAlert()
                
                guard let uid = Auth.auth().currentUser?.uid else {
                    print ("Get FAILED!!!!!!!!!!!!!!!!!!!!!!")
                    return }
                print(uid)
                self.db.collection("users").document(uid).setData(["uid":uid,
                                                              "name":self.nameTextField.text, "email": self.emailField.text,
                    ])         { error in
                      
                      // Check for errors
                      if error == nil {
                          // No errors
                      }
                      else {
                          // Handle the error
                      }
                  }
                
            }
            else {
                self.errorLabel.text = "الرجاء التحقق من تعبئة جميع الحقول"
            }
            
            
            
            
            
            
        }
        
        func simpleAlert(){
            // (1) create new alert
            let myAlert = UIAlertController(title: "", message: "تم إنشاء حسابك بنجاح", preferredStyle: .alert)
            
            // (2) create done button with handler
            let done = UIAlertAction(title: "حسنًا", style: .default) { (action) in // or _ instaed of the paramter action
                self.dismiss(animated: true, completion: nil)
            }
            
            // (3) add done button to myAlert
            myAlert.addAction(done)
            
            // (4) present the alert
            present(myAlert, animated: true)
        }
        
    }
    
}
