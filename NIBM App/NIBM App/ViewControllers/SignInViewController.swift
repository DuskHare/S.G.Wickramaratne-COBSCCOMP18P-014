//
//  SignInViewController.swift
//  NIBM App
//
//  Created by Shaveen Wickramaratne on 12/1/19.
//  Copyright © 2019 Shaveen Wickramaratne. All rights reserved.
//

import UIKit
import Firebase
class SignInViewController: UIViewController {


    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signin.layer.cornerRadius = 8
        
        navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signin_btn(_ sender: Any) {
        
        
        if username.text?.isEmpty ?? true {
            self.alert(message: "Enter Email")
            return
        }
        
        if password.text?.isEmpty ?? true {
            self.alert(message: "Enter Password")
        }
        
        Auth.auth().signIn(withEmail: username.text!, password: password.text!) { [weak self] user, error in
            guard let strongSelf = self else { return }
            
            if (error != nil){
                strongSelf.alert(message: error?.localizedDescription ?? "Error")
                return
            }else{
                var user_email:String?
                var UID: String?
                if let user = user {
                    _ = user.user.displayName
                    user_email = user.user.email
                    UID = user.user.uid
                    print("eeeeeeeeeee\(user_email!)")
                }
                
                //self.showAlert(message: "SignIn Successfully! Email: \(user_email!)")
                UserDefaults.standard.set(user_email, forKey: "LoggedUser")
                UserDefaults.standard.set(UID, forKey: "UserUID")
                UserDefaults.standard.set(true, forKey: "LoggedIn")
                UserDefaults.standard.synchronize()
                
                let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "homeNavVC")
                self?.present(vc, animated: true, completion: nil)
                
            }
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
