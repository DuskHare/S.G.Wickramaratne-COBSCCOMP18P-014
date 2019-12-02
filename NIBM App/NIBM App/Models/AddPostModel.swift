//
//  AddPostModel.swift
//  NIBM App
//
//  Created by Shaveen Wickramaratne on 12/1/19.
//  Copyright © 2019 Shaveen Wickramaratne. All rights reserved.
//

import Foundation

struct AddPostModel: Codable {
    
    var title : String!
    var description : String!
    var user: String!
    var image_url: String!
    var userImage: String!
    
    init(title: String, description: String,user: String,image_url:String) {
        self.title = title
        self.description = description
        self.user=user
        self.image_url=image_url
    }
    
    
    
    
}
