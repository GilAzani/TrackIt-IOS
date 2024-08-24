//
//  SignUpViewController.swift
//  TrackIt
//
//  Created by Student11 on 23/08/2024.
//

import Foundation

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignUpViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    let signUpId = "sign_up"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    @IBAction func signUpPressed(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let username = usernameTextField.text, !username.isEmpty else {
            // Handle empty fields
            errorMessageLabel.text = "Email, Password, or Username is empty."
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                // Handle sign-up error
                self.errorMessageLabel.text = "Error: \(error.localizedDescription)"
                return
            }
            
            // Sign-up successful, save the user data to Firebase Realtime Database
            guard let user = authResult?.user else { return }
            
            // Create a User object with the necessary data
            let movieList: [MovieListItem] = [] // Initialize with default or empty movie list
            let userData = User(username: username, movieList: movieList)
            
            // Save user data to Realtime Database
            self.saveUserDataToDatabase(userID: user.uid, userData: userData)
        }
    }
        
        func saveUserDataToDatabase(userID: String, userData: User) {
            let ref = Database.database().reference()
            
            do {
                let userDictionary = try JSONEncoder().encode(userData)
                let json = try JSONSerialization.jsonObject(with: userDictionary, options: [])
                let userDict = json as? [String: Any]
                
                ref.child("users").child(userID).setValue(userDict) { error, _ in
                    if let error = error {
                        print("Error saving user data: \(error.localizedDescription)")
                    } else {
                        // Data saved successfully, navigate to the next screen
                        self.presentMainAppViewController()
                    }
                }
            } catch {
                print("Error encoding user data: \(error.localizedDescription)")
            }
        }
    
    private func presentMainAppViewController() {
        let mainAppStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let mainAppViewController = mainAppStoryboard.instantiateViewController(withIdentifier: "search") as? SearchViewController {
            mainAppViewController.modalPresentationStyle = .fullScreen
            
            self.present(mainAppViewController, animated: true)
        }
    }

    }
    

