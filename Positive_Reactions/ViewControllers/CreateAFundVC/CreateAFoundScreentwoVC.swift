//
//  CreateAFoundScreentwoVC.swift
//  Positive_Reactions
//
//  Created by Ali Hassan on 18/12/2020.
//

import UIKit

class CreateAFoundScreentwoVC: UIViewController {

    
    @IBOutlet weak var fundraisertitleTextfield: UITextField!
    
    @IBOutlet weak var objectiveOfFundTextfield: UITextField!
    
    
    
    @IBOutlet weak var fundRaisercountlbl: UILabel!
    
    @IBOutlet weak var objectiveOfFundlbl: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fundraisertitleTextfield.delegate = self
        objectiveOfFundTextfield.delegate = self
        // Do any additional setup after loading the view.
    }
    

    @IBAction func Continuebtn(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "CreateAFoundscreenthreeVC") as! CreateAFoundscreenthreeVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func backBtn(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
}
extension CreateAFoundScreentwoVC : UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        if(textField == fundraisertitleTextfield){
            
            let fundraisertitleTextfieldlength = textField.text!.count +  (string.count - range.length)
            
            if  fundraisertitleTextfieldlength <= 30 {
                fundRaisercountlbl.text = "\(fundraisertitleTextfieldlength )/30"
                return true
            }else{
                return false
            }
            
            
        }
        if(textField == objectiveOfFundTextfield){
            
            let fundraisertitleTextfieldlength = textField.text!.count +  (string.count - range.length)
            
            if  fundraisertitleTextfieldlength <= 30 {
                objectiveOfFundlbl.text = "\(fundraisertitleTextfieldlength )/30"
                return true
            }else{
                return false
            }
            
            
        }
        
        
        
        
        
        
        
        return true
        
    }
    
    
    
    
}
