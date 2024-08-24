//
//  SignInViewController.swift
//  TrackIt
//
//  Created by Student11 on 22/08/2024.
//

import Foundation

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {
    @IBOutlet weak var userEmailTextField: UITextField!
    
    @IBOutlet weak var userPasswordTextField: UITextField!
    let signInId = "sign_in"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func signInPressed(_ sender: Any) {
        guard let email = userEmailTextField.text, !email.isEmpty,
              let password = userPasswordTextField.text, !password.isEmpty else {
            // Handle empty fields (e.g., show an alert)
            print("Email or Password is empty.")
            return
        }

        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                // Handle sign-in error (e.g., show an alert)
                print("Error signing in: \(error.localizedDescription)")
                return
            }
            self.dismiss(animated: true){
                self.performSegue(withIdentifier: self.signInId, sender: self)
            }
        }
    }
    

    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == self.signInId {
//            self.dismiss(animated: false)
//        }
//    }

}
