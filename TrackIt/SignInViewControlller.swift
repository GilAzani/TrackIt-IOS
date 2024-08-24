import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!

    @IBOutlet weak var errorMessageLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func signInPressed(_ sender: Any) {
        guard let email = userEmailTextField.text, !email.isEmpty,
              let password = userPasswordTextField.text, !password.isEmpty else {
            errorMessageLabel.text = "Email or Password is empty."
            return
        }

        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.errorMessageLabel.text = "Error: Wrong Email or password"
                return
            }
            DataManager.instance.loadUserData()

            self.transitionToMainTabBarController()
        }
    }

    private func transitionToMainTabBarController() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let tabBarController = mainStoryboard.instantiateViewController(withIdentifier: "main_page") as? UITabBarController {
            // Set the tab bar controller as the root view controller
            if let window = UIApplication.shared.windows.first {
                window.rootViewController = tabBarController
                window.makeKeyAndVisible()
            }
        }
    }
}
