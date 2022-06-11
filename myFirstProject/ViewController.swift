//
//  ViewController.swift
//  myFirstProject
//
//  Created by Sarah S on 06/06/2022.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var logInBtn: UIButton!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        logInBtn.layer.cornerRadius = 15
        logInBtn.clipsToBounds = true

    }

        @IBAction func logIn(_ sender: Any) {
            
            if let email = emailField.text
                ,let password = passField.text {
            
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                guard self != nil else { return }
              // ...

                
                if error == nil {
                    self!.emailField.text = ""
                    self!.passField.text = ""
                    self?.performSegue(withIdentifier: "goToHome", sender: nil)
//                    present((HomeViewController as UIViewController), animated: true, completion: nil)
                }
                else{
                    self!.errorLabel.text = "الرجاء التحقق من صحة البيانات"
                }
            }
                
            }
        }

}

