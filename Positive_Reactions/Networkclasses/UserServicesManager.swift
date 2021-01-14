//
//  UserServicesManager.swift
//  DailyWayOfLife
//
//  Created by apple on 29/11/2019.
//

import Foundation
import Alamofire
import SwiftyJSON
import ObjectMapper

extension NetworkManager {
    
    
    
    func SignIn(Email:String, Password:String, completion: @escaping (DataResponse<Any> ) -> Void ) {
        let parameters: Parameters = [
            
            "email":Email,
            "password":Password,
            
            
        ]
        sendPostRequestLogin(url: "/users/login", parameters: parameters, completion: completion)
    }
    
    func Signup( info : signupinfo, completion: @escaping (DataResponse<Any> ) -> Void )  {
        var parameter: Parameters = [
            
            "fullName" : info.Name,
            "email": info.Email,
            "password": info.Password,
            "userName": info.userName,
            "dateOfBirth" : info.dateofbirth,
            "bio" : info.bio,
            
        ]
        let causes = info.causes
        
        if causes.count != 0 {
        
            for index  in 0...causes.count - 1 {
                parameter["causes[\(index)]"] = causes[index]
            }
            
        }
        
        let proimg = info.profilePhoto
        let covimg = info.coverPhoto
        
        var pro = false
        var cov = false
        
        if proimg != nil {
            pro = true
        }
        if covimg  != nil{
            cov = true
        }
        
        sendUploadRequest(isImage: true, pro : pro , cov : cov,url: "/users", parameters: parameter, profileimage: proimg, coverimage: covimg , completion: completion)
    }
    func Createopportunity( info : CreateOpportunitemodel, completion: @escaping (DataResponse<Any> ) -> Void ){
        
        let paramter : Parameters = [
            
            "userId": info.userid,
            "title": info.title,
            "description": info.description,
            "location": info.location,
            "isVideo" :"\( info.isvideo)",
            "hashTags[]":info.hashTags[0],
            "categories[]":info.category
            
        ]
        
        uploadopportunity(isImage: info.isimage, isvideo: info.isvideo, url: "/opportunities",thumbnail: info.thumbnail, opportunity: info.opportunity , parameters : paramter, completion: completion)

    }
    
    
    func getallOpportunities(completion : @escaping (DataResponse<Any>) -> Void){
        
        getOpportunities(url : "/opportunities", completion : completion)
        
    }
    func getcauses(completion : @escaping (DataResponse<Any>) -> Void){
        
        getOpportunities(url : "/causes", completion : completion)
        
    }
    func checkemail(Email:String,completion: @escaping (DataResponse<Any> ) -> Void ) {
        
        let parameters: Parameters = [
            
            "email":Email,
            
        ]
        getwithparamofemail(parameters: parameters, url: "/users/is_email_exists", completion: completion)
        
    }
    func checkusername(username:String,completion: @escaping (DataResponse<Any> ) -> Void ) {
        
        let parameters: Parameters = [
            
            "username":username,
            
        ]
        getwithparamofemail(parameters: parameters, url: "/users/is_username_exists", completion: completion)
        
    }
}
