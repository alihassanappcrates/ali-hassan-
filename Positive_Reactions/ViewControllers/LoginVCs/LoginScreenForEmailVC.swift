//
//  LoginScreenForEmailVC.swift
//  Positive_Reactions
//
//  Created by Ali Hassan on 30/12/2020.
//

import UIKit

import RappleProgressHUD
import Alamofire
import SwiftyJSON

class LoginScreenForEmailVC: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTextField.isSecureTextEntry = true
    }
    
    
    @IBAction func isHidePasswordBtn(_ sender: Any) {
        
        passwordTextField.isSecureTextEntry =  !passwordTextField.isSecureTextEntry
        
    }
    
    
    @IBAction func nextBtn (_ sender: Any){
        
        if isValidEmail(email: emailTextField.text ?? ""){
            
            if passwordTextField.text!.count >= 6 {
                self.loginapi(email: emailTextField.text ?? "", password: passwordTextField.text ?? "") { (test) in
                    if test {
                        let first = self.storyboard!.instantiateViewController(withIdentifier: "HomeviewTabbarController")
                        self.navigationController?.pushViewController(first, animated: true)
                    }
                }
                
                
            }else{
                
                self.showAlert("","Please enter 6 characher password")
                
            }
            
        }else{
            
            self.showAlert("Alert","Please enter corrent email")
            
        }
    }
    
    @IBAction func signUpBtn(_ sender : Any){
        
        let first = storyboard!.instantiateViewController(withIdentifier: "SignUPVC")
        self.navigationController?.pushViewController(first, animated: true)
        
    }
    
    
    @IBAction func bckbtn(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
}
extension LoginScreenForEmailVC{
    
    func loginapi(email : String, password : String , completed: @escaping (_ finished: Bool) -> ()){
        
        RappleActivityIndicatorView.startAnimating()
        NetworkManager.sharedInstance.SignIn(Email: email, Password: password) { (response) in
            
            RappleActivityIndicatorView.stopAnimation()
            switch response.result {
            case .success(_):
                
                if let value = response.result.value {
                    let json = JSON(value)
                    print(json)
                    if json["status"].intValue == 200 {
                        if json["message"].stringValue == "User"{
                            
                            UserDefaults.standard.setValue(json["data"]["_id"].stringValue, forKey: "userid")
                            completed(true)
                            
                        }else{
                            
                            let message =  json["message"].stringValue
                            self.showAlert("Alert",  message)
                            
                            
                            
                        }
                        
                        
                        //completion(response)
                    }else {
                        
                        
                        print(json["message"].stringValue)
                        let message =  json["message"].stringValue
                        self.showAlert("Alert",  message)
                        //                        completed(json["message"].stringValue)
                    }
                }
            case .failure(let error):
                print("Error")
                
            }
            
            
        }
    }
    
}

