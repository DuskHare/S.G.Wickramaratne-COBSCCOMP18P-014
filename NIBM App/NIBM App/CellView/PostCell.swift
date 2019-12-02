//
//  PostCell.swift
//  NIBM App
//
//  Created by Shaveen Wickramaratne on 12/1/19.
//  Copyright © 2019 Shaveen Wickramaratne. All rights reserved.
//


import UIKit
import Nuke

class PostCell: UITableViewCell {
    
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var postDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    
    func populateData(post: AddPostModel)  {
        
        postTitle.text = post.title
        postDescription.text = post.description
        userName.text = post.user
        
        let imgUrl = URL(string: post.image_url)
        
        Nuke.loadImage(with: imgUrl!, into: postImage)
        
    }
    
}
