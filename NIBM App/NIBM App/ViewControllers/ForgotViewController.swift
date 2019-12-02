//
//  ForgotViewController.swift
//  NIBM App
//
//  Created by Shaveen Wickramaratne on 12/1/19.
//  Copyright © 2019 Shaveen Wickramaratne. All rights reserved.
//

import UIKit
import Firebase

class ForgotViewController: UIViewController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var reset: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func emailreset(_ sender: Any) {
   
        if email.text == "" {
            self.alert(message: "Enter your email")
            return
        }
        
        if !isValidEmail(testStr: email.text!) {
            self.alert(message: "Not a valid email")
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: email.text!) { error in
            if (error != nil){
                self.alert(message: error?.localizedDescription ?? "Error")
                return
            }
            
            self.alert(message: "A password reset email has been sent to your account")
            
            
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
