//
//  signupinfo.swift
//  Positive_Reactions
//
//  Created by Ali Hassan on 31/12/2020.
//

import Foundation
import UIKit

struct signupinfo {
    
    var  Name = ""
    var  Email = ""
    var dateofbirth = ""
    var Password = ""
    var userName = ""
    var profilePhoto : UIImage? = nil
    var coverPhoto : UIImage? = nil
    var  bio = ""
    var causes : [String ] = []
    
}
struct CreateOpportunitemodel{
    
    var userid = UserDefaults.standard.string(forKey: "userid")
    var title = ""
    var description = ""
    var opportunity : URL? = nil
    var thumbnail : UIImage? = nil
    var location  = ""
    var hashTags : [String] = []
    var about = ""
    var isvideo = false
    var isimage = false
    var category = ""
    
}

