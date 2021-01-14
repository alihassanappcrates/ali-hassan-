//
//  SignUPVC.swift
//  Positive_Reactions
//
//  Created by Ali Hassan on 30/12/2020.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn

class SignUPVC: UIViewController {
    
    let User = UserDefaults.standard.string(forKey: "userid")
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if User != "" && User != nil{
            
            let initialVC = self.storyboard?.instantiateViewController(identifier:  "HomeviewTabbarController") as! HomeviewTabbarController
            self.navigationController?.pushViewController(initialVC, animated: true)
            
        }
        // Do any additional setup after loading the view.
    }
    
    // for facebook login
    
    @IBAction func SignupWithFaceBookBtn(_ sender : Any){
        
        
        let manger = LoginManager()
        manger.logOut()
        manger.logIn(permissions: [.publicProfile, .email], viewController: self) { (Result) in
            switch Result{
            case .cancelled :
                print("user cancel login ")
                break
            case .failed(let error):
                print("login failed with error = \(error.localizedDescription)")
                break
            case .success(granted: let grantedpermission, declined: let declinedpermission, token: let accesstoken):
                print("access token = \(accesstoken)")
                print("Result is = \(Result)")
                print(grantedpermission)
                print(declinedpermission)
                print("grantedpermission is = \(Permission.email)")
                GraphRequest(graphPath: "me", parameters: ["fields": "id, name, email, gender"]).start(completionHandler: { (connection, result, error) -> Void in
                    if (error == nil){
                        
                        //                        self.userData = result as! [String : String]
                        print(result as! [String : String])
                        if let res = result as? [String : String] {
                            
                            let name  = res["name"]
                            let email = res["email"]
                            let id = res["id"]
                            let token = accesstoken.tokenString
                            print(token)
                            
                            
                            
                        }
                    }
                })
                
                
                break
            }
        }
        
    }
    @IBAction func SignupWithGoogleBtn(_ sender : Any){
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        // Automatically sign in the user.
        GIDSignIn.sharedInstance()?.signIn()
        
    }
    // for Google login
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        
        if let error = error {
            
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                
                print("The user has not signed in before or they have since signed out.")
                
            } else {
                
                print("\(error.localizedDescription)")
                
            }
            return
            
        }
        
        // Perform any operations on signed in user here.
        let userId = user.userID                  // For client-side use only!
        let idToken = user.authentication.idToken // Safe to send to the server
        let fullName = user.profile.name
        let givenName = user.profile.givenName
        let familyName = user.profile.familyName
        let email = user.profile.email
        
        
        print("\(userId!) ,,,, \(idToken!) ,,,,\(fullName!),,,,\(givenName!),,,,\(familyName!),,,,\(email!)")
        
    }
    
    @IBAction func SignupWithEmailbtn (_ sender: Any){
        
        let first = storyboard!.instantiateViewController(withIdentifier: "createAnAccountVC")
        self.navigationController?.pushViewController(first, animated: true)
        
    }
    
    @IBAction func LoginBtn(_ sender : Any){
        
        let first = storyboard!.instantiateViewController(withIdentifier: "LoginVC") 
        self.navigationController?.pushViewController(first, animated: true)
        
    }
    
    
}
