//
//  AddPostViewController.swift
//  NIBM App
//
//  Created by Shaveen Wickramaratne on 12/1/19.
//  Copyright © 2019 Shaveen Wickramaratne. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON
class AddPostViewController: UIViewController {

    @IBOutlet weak var postTitle: UITextField!
    @IBOutlet weak var postDesc: UITextField!

    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var user: UITextField!
    
    var imagePicker:UIImagePickerController!
    var ref = DatabaseReference.init()
    var avatarImageUrl: String!
    var firstname: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
        self.ref = Database.database().reference()
        postImage.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
    }
    

    @IBAction func clickPick(_ sender: Any) {
   
        self.present(imagePicker, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func save(_ sender: Any) {
        if (postTitle.text == "") {
            alert(message: "title is required")
            return
        }
        
        if (postDesc.text == ""){
            alert(message: "Description Is Required")
            return
        }
        if (postImage.image == nil){
            alert(message: "Image Is Required")
            return
        }
        self.saveFIRData()
        navigationController?.popViewController(animated: true)
    }
    
    
    func saveFIRData(){
        self.uploadMedia(image: postImage.image!){ url in
            self.saveImage(profileImageURL: url!){ success in
                if (success != nil){
                    self.dismiss(animated: true, completion: nil)
                }
                
            }
        }
    }
    
    
    func uploadMedia(image :UIImage, completion: @escaping ((_ url: URL?) -> ())) {
        let imageName = UUID().uuidString
        let storageRef = Storage.storage().reference().child("article").child(imageName)
        let imgData = self.postImage.image?.pngData()
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        storageRef.putData(imgData!, metadata: metaData) { (metadata, error) in
            if error == nil{
                storageRef.downloadURL(completion: { (url, error) in
                    completion(url)
                })
            }else{
                print("error in save image")
                completion(nil)
            }
        }
    }
    
    func saveImage(profileImageURL: URL , completion: @escaping ((_ url: URL?) -> ())){
        let dict = ["description": postDesc.text!, "img_url": profileImageURL.absoluteString,"topic": postTitle.text!,"username": user.text!] as [String : Any]
        self.ref.child("article").childByAutoId().setValue(dict)
        self.alert(message: "Post Added Successfully")
    }
    
}



extension AddPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.postImage.image = pickedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
}
