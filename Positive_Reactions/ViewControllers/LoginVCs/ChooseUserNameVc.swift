//
//  ChooseUserNameVc.swift
//  Positive_Reactions
//
//  Created by Ali Hassan on 30/12/2020.
//

import UIKit
import AVFoundation
import SwiftyJSON
import RappleProgressHUD

class ChooseUserNameVc: UIViewController {
    
    var getdate = signupinfo()
    @IBOutlet weak var Username : UITextField!
    
    
    var isprofile = true
    
    @IBOutlet weak var Profileimg: UIImageView!
    
    @IBOutlet weak var coverImg: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backbtn(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func nextBtn (_ sender: Any){
        
        guard let username = Username.text, Username.text != "", Username.text != nil  else {
            self.showAlert("Alert", "Please Enter User Name")
            return
        }
        getdate.userName = username
        let first = storyboard!.instantiateViewController(withIdentifier: "BioVc") as! BioVc
        first.getdate = self.getdate
        self.navigationController?.pushViewController(first, animated: true)
        
    }
    
    
    @IBAction func addProfileBtn(_ sender: Any) {
        
        isprofile = true
        showActions()
        
    }
    
    @IBAction func addCoverBtn(_ sender: Any) {
        
        isprofile = false
        showActions()
        
    }
    
    
    
}
extension ChooseUserNameVc : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    
    func showActions() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let camera = UIAlertAction(title: "Take Photo", style: .default) { (action:UIAlertAction) in
            self.getImage(type: .camera)
        }
        
        let gallery = UIAlertAction(title: "Choose Photo", style: .default) { (action:UIAlertAction) in
            self.getImage(type: .photoLibrary)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        //cancel.setValue(UIColor.red, forKey: "titleTextColor")
        
        alertController.addAction(camera)
        alertController.addAction(gallery)
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func getImage(type: UIImagePickerController.SourceType) {
        
        let picker = UIImagePickerController()
        picker.sourceType = type
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let eimage = info[.editedImage] as? UIImage else { return }
        
        
        if isprofile{
            getdate.profilePhoto = eimage
            Profileimg.image = eimage
        }else{
            getdate.coverPhoto = eimage
            coverImg.image = eimage
        }
        
        dismiss(animated: true) {
            // Some action here
        }
    }
    private func cameraPermissions(callback: @escaping (Bool) -> Void) {
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        
        case .authorized:
            callback(true)
        case .denied, .restricted:
            callback(false)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { success in
                callback(success)
                
            }
        @unknown default:
            fatalError()
        }
    }
}
extension ChooseUserNameVc{
    
    func checkusername(username : String, completed: @escaping (_ finished: Bool) -> ()){
        
        RappleActivityIndicatorView.startAnimating()
        NetworkManager.sharedInstance.checkusername(username: username) { (response) in
            
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
