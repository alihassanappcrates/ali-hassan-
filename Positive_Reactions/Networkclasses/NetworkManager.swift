//
//  NetworkManager.swift
//  Positive_Reactions
//
//  Created by Ali Hassan on 31/12/2020.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

public enum HTTPMethod: String {
    
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

var BASE_URL = "https://staging.positive-reactions.com/api"
var token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZmY1NWY4OTRkZWIxMjFiNDFkMTAxMTgiLCJpYXQiOjE2MDk5MTYyOTd9.KCudOHBRksh6jNAR68Iy8ffqZAmtOKYnkEG589DCwPs"
class NetworkManager: NSObject {
    static let sharedInstance = NetworkManager()
    
    func sendPostRequestLogin(url: String, parameters: Parameters, completion: @escaping (DataResponse<Any>) -> Void) -> Void {
        
        let api = "\(BASE_URL)\(url)"
        Alamofire.request(api, method: .post ,parameters: parameters, encoding: URLEncoding.default).responseJSON
            {
                response in
                print(response)
                completion(response)
        }
        
    }
    func sendUploadRequest(isImage : Bool,  pro : Bool , cov : Bool,url: String, parameters: Parameters, profileimage: UIImage?, coverimage : UIImage?, completion: @escaping (DataResponse<Any>) -> Void) -> Void {
        
        if isImage  {
            
            var coverImgData: Data! = nil
            var profileImgData: Data! = nil
            if cov{
                coverImgData = coverimage!.jpegData(compressionQuality: 0.5)!
            }
            if pro{
                profileImgData = profileimage!.jpegData(compressionQuality: 0.5)!
            }
            
            Alamofire.upload(multipartFormData: { multipartFormData in
                
                if pro {
                multipartFormData.append(profileImgData, withName: "profilePhoto",fileName: "image.jpg", mimeType: "image/jpg")
                }
                if cov{
                multipartFormData.append(coverImgData, withName: "coverPhoto",fileName: "image.jpg", mimeType: "image/jpg")
                }
                
                for (key, value) in parameters {
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
            }, to: "\(BASE_URL)" + url)
            { (result) in
                switch result {
                case .success(let upload, _, _):
                    
                    upload.uploadProgress(closure: { (progress) in
                        print("Upload Progress: \(progress.fractionCompleted)")
                    })
                    
                    upload.responseJSON { response in
                        completion(response)
                    }
                    
                case .failure(let encodingError):
                    print(encodingError)
                }
            }
        }
        else {
            Alamofire.request("\(BASE_URL)" + url, method: .post, parameters: parameters).responseJSON { response in
                completion(response)
            }
        }
    }
    
    func uploadopportunity(isImage : Bool,  isvideo : Bool,url: String,thumbnail : UIImage?, opportunity : URL? , parameters: Parameters, completion: @escaping (DataResponse<Any>) -> Void) -> Void {
       
        let header = ["Authorization":"\(token)"]
        
        if isImage{
            
            let data = NSData(contentsOf: opportunity! as URL)
            
            let img = UIImage(data: data! as Data)!
            let opportunityimg = img.jpegData(compressionQuality: 0.5)!
            Alamofire.upload(multipartFormData: { multipartFormData in
                
                
                multipartFormData.append(opportunityimg, withName: "opportunity",fileName: "image.jpg", mimeType: "image/jpg")
                
                
                
                for (key, value) in parameters {
                    
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                    
                }
                
//                for value in hashtag {
//
//                }
            }, to: "\(BASE_URL)" + url,method: .post,headers: header)
            { (result) in
                switch result {
                case .success(let upload, _, _):
                    
                    upload.uploadProgress(closure: { (progress) in
                        print("Upload Progress: \(progress.fractionCompleted)")
                    })
                    
                    upload.responseJSON { response in
                        completion(response)
                    }
                    
                case .failure(let encodingError):
                    print(encodingError)
                }
            }
        }else if isvideo{
            
            do{
            
            let videoData = try Data(contentsOf: opportunity!)
                    
            let thumbnail = thumbnail!.jpegData(compressionQuality: 0.5)!
            
            
            Alamofire.upload(multipartFormData: { multipartFormData in
                
                
                multipartFormData.append(thumbnail, withName: "thumbnail",fileName: "image.jpg", mimeType: "image/jpg")
                
                multipartFormData.append(videoData, withName: "opportunity", fileName: "opportunity_video.mp4", mimeType: "video/mp4")
                
                for (key, value) in parameters {
                    
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                    
                }
                
            }, to: "\(BASE_URL)" + url,method: .post, headers: header)
            { (result) in
                switch result {
                case .success(let upload, _, _):
                    
                    upload.uploadProgress(closure: { (progress) in
                        print("Upload Progress: \(progress.fractionCompleted)")
                    })
                    
                    upload.responseJSON { response in
                        completion(response)
                    }
                    
                case .failure(let encodingError):
                    print(encodingError)
                }
            }
        } catch {
            return
        }
            
        }
        else {
            Alamofire.request("\(BASE_URL)" + url, method: .post, parameters: parameters,headers: header).responseJSON { response in
                completion(response)
            }
        }
       
    }
    
    func getOpportunities(url : String ,completion: @escaping (DataResponse<Any>) -> Void){
       
        let header = ["Authorization":"\(token)"]
        let api = "\(BASE_URL)\(url)"
        Alamofire.request(api, method: .get , headers: header).responseJSON { response in
            
            completion(response)
            
        }
        
    }
    func getwithparamofemail(parameters: Parameters,url : String ,completion: @escaping (DataResponse<Any>) -> Void){
       
       
        let api = "\(BASE_URL)\(url)"
        Alamofire.request(api, method: .get,parameters: parameters).responseJSON { response in
            
            completion(response)
            
        }
        
    }
    
}
