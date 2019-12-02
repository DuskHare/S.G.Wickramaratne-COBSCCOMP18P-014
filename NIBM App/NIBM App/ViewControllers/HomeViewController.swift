//
//  HomeViewController.swift
//  NIBM App
//
//  Created by Shaveen Wickramaratne on 12/1/19.
//  Copyright © 2019 Shaveen Wickramaratne. All rights reserved.
//

import UIKit
import Firebase
import LocalAuthentication
class HomeViewController: UIViewController {var postsList : [AddPostModel] = []
    var ref: DatabaseReference!
    var window: UIWindow?

    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        tableview.dataSource = self as! UITableViewDataSource
        tableview.delegate = self as! UITableViewDelegate
        
        getStudentData()
        
        // Do any additional setup after loading the view.
    }
    func getStudentData(){
        
        let friendsRef = ref.child("article")
        
        
        friendsRef.observe(.value){ snapshot in
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                
                let studentDic = child.value as! NSDictionary
                
                let title = studentDic["topic"] as! String
                let description = studentDic["description"] as! String
                let user = studentDic["username"] as! String
                let image_url = studentDic["img_url"] as! String
                let post = AddPostModel(
                    title: title,
                    description: description,
                    user: user ,
                    
                    image_url: image_url
                )
                
                self.postsList.append(post)
                
                print(child)
            }
            
            self.tableview.reloadData()
            
            
        }
    }

    @IBAction func signout(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}
    extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
            return postsList.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! PostCell
            
            cell.selectionStyle = .none
            
            cell.populateData(post: postsList[indexPath.row])
            
            return cell
        }
}
        
     /*   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
            performSegue(withIdentifier: "friendDetail", sender: postsList[indexPath.row])
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "friendDetail" {
                if let viewController = segue.destination as? postsViewController{
                    
                    viewController.posts = sender as? AddPostModel
                }
            }
        } */
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


