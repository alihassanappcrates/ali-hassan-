//
//  Allopportunitiesmodel.swift
//  Positive_Reactions
//
//  Created by Ali Hassan on 06/01/2021.
//

import Foundation
import SwiftyJSON

class Allopportunitiesmodel{
    
    let hashTags : String
    let fullName : String
    //    let profilePhoto : String
    let description : String
    let title : String
    let opportunity : String
    let thumbnail : String
    let isVideo : Bool
    let categorie : String
    
    
    init(json : JSON) {
        
        
        let arrayofhash = json["hashTags"].arrayValue
        let categories = json["categories"].arrayValue
        fullName = json["user"]["userName"].stringValue
        
        if categories.count != 0 {
            
            self.categorie = categories[0].stringValue
            
        }else{
            self.categorie = ""
        }
        
        hashTags = arrayofhash[0].stringValue
        description = json["description"].stringValue
        title = json["title"].stringValue
        opportunity = json["opportunity"].stringValue
        thumbnail = json["thumbnail"].stringValue
        isVideo = json["isVideo"].boolValue
        
        
    }
    
}
