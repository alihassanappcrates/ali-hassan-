//
//  createAnAccountVC.swift
//  Positive_Reactions
//
//  Created by Ali Hassan on 30/12/2020.
//

import UIKit

import RappleProgressHUD
import Alamofire
import SwiftyJSON
import D2PDatePicker

class createAnAccountVC: UIViewController {
    
    
    @IBOutlet weak var calenderview: UIView!
    
    @IBOutlet weak var datelbl: UILabel!
    @IBOutlet weak var datePickerView: D2PDatePicker!
    
    var getdate = signupinfo()
    
    @IBOutlet weak var FullnameTextfield: UITextField!
    
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var emailtextfield: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    let datePicker = UIDatePicker()
    var issetdate = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calenderview.isHidden = true
        datePickerView.delegate = self
        let date18back = Calendar.current.date(byAdding: .year, value: -18, to: Date())
        datePickerView.set(toDate: date18back!)
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        
        datelbl.text = formatter.string(from: date18back!)
        //        dateTextField.isEnabled = true
        //        showstartDatePicker()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func setdate(_ sender: Any) {
        
        dateTextField.text =  datelbl.text
        calenderview.isHidden = true
        
    }
    
    
    @IBAction func selectdatebtn(_ sender: Any) {
        
        calenderview.isHidden = false
        
    }
    
    
    @IBAction func backbtn(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func ishiddenPasswordbtn(_ sender: Any) {
        
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
        
    }
    
    @IBAction func nextBtn (_ sender: Any){
        
        guard let Username = FullnameTextfield.text, FullnameTextfield.text != nil, FullnameTextfield.text != "" else {
            
            self.showAlert("Alert","Please Enter Full Name")
            
            return
            
        }
        guard  let email = emailtextfield.text , emailtextfield.text != nil, emailtextfield.text != "", isValidEmail(email: emailtextfield.text ?? "") else {
            self.showAlert("Alert", "Please Enter Email Address")
            return
        }
        guard  let date = dateTextField.text , dateTextField.text != nil, dateTextField.text != "" else {
            self.showAlert("Alert", "Please Enter date Of Birth")
            return
        }
        guard  let password = passwordTextField.text, passwordTextField.text != nil, passwordTextField.text != "" , passwordTextField.text?.count ?? 0 >= 6 else {
            
            self.showAlert("Alert", "Please Enter Minimum 6 Characher Password")
            return
            
        }
        getdate.Name = Username
        getdate.dateofbirth = date
        getdate.Email = email
        getdate.Password = password
        
        let first = storyboard!.instantiateViewController(withIdentifier: "ChooseUserNameVc") as! ChooseUserNameVc
        first.getdate = self.getdate
        
        self.navigationController?.pushViewController(first, animated: true)
        
    }
}
extension createAnAccountVC: D2PDatePickerDelegate {
    
    
    func didChange(toDate date: Date) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        
        if issetdate {
            dateTextField.text = formatter.string(from: date)
        }
        datelbl.text = formatter.string(from: date)
        
    }
    
}
extension createAnAccountVC{
    
    func checkemail(email : String, completed: @escaping (_ finished: Bool) -> ()){
        
        RappleActivityIndicatorView.startAnimating()
        NetworkManager.sharedInstance.checkemail(Email: email) { (response) in
            
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
