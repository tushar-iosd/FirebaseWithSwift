//
//  ViewController.swift
//  FirebaseWithSwift
//
//  Created by chetumacmini on 07/08/18.
//  Copyright © 2018 StrataGLyricalConcepts. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = Auth.auth().currentUser {
           // self.signIn()
        }
    }
    
    @IBAction func didTapSignIn(_ sender: UIButton) {
        let email = emailTF.text
        let password = passTF.text
        Auth.auth().signIn(withEmail: email!, password: password!, completion: { (user, error) in
            guard let _ = user else {
                if let error = error {
                    if let errCode = AuthErrorCode(rawValue: error._code) {
                        switch errCode {
                        case .userNotFound:
                            self.showAlert("User account not found. Try registering")
                        case .wrongPassword:
                            self.showAlert("Incorrect username/password combination")
                        default:
                            self.showAlert("Error: \(error.localizedDescription)")
                        }
                    }
                    return
                }
                
                assertionFailure("user and error are nil")
                
         fatalError("Unexpected element kind")
                
            }
           
            self.signIn()
        }
            
        )
        
    }
   
    func showAlert(_ message: String) {
        let alertController = UIAlertController(title: "Firebase With Swift", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    @IBAction func didRequestPasswordReset(_ sender: UIButton) {
        
        let prompt = UIAlertController(title: "Firebase With Swift", message: "Email:", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            let userInput = prompt.textFields![0].text
            if (userInput!.isEmpty) {
                return
            }
            Auth.auth().sendPasswordReset(withEmail: userInput!, completion: { (error) in
                if let error = error {
                    if let errCode = AuthErrorCode(rawValue: error._code) {
                        switch errCode {
                        case .userNotFound:
                            DispatchQueue.main.async {
                                self.showAlert("User account not found. Try registering")
                            }
                        default:
                            DispatchQueue.main.async {
                                self.showAlert("Error: \(error.localizedDescription)")
                            }
                        }
                    }
                    return
                } else {
                    DispatchQueue.main.async {
                        self.showAlert("You'll receive an email shortly to reset your password.")
                    }
                }
            })
        }
        prompt.addTextField(configurationHandler: nil)
        prompt.addAction(okAction)
        present(prompt, animated: true, completion: nil)
    }

        
   
    
    func signIn() {
        performSegue(withIdentifier: "SignInFromLogin", sender: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

