//
//  CausesModel.swift
//  Positive_Reactions
//
//  Created by Ali Hassan on 08/01/2021.
//

import Foundation
import SwiftyJSON
class CausesModel {
    
    let causename : String
    let causeimage : String
    let causeid : String
    
    init(json: JSON) {
        
        causename = json["name"].stringValue
        causeid = json["_id"].stringValue
        causeimage = json["causePhoto"].stringValue
        
        
    }
    
    
}
