//
//  SignInViewController.swift
//  S.G.Wickramaratne-COBSCCOMP18P-014
//
//  Created by Digital-03 on 11/19/19.
//  Copyright © 2019 Shaveen. All rights reserved.
//

import UIKit
import Firebase
class SignInViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInClick(_ sender: Any) {
        
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
                strongSelf.performSegue(withIdentifier: "homeNav", sender: self)
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
