//
//  CreatePetitionOneVC.swift
//  Positive_Reactions
//
//  Created by Ali Hassan on 16/12/2020.
//

import UIKit

class CreatePetitionOneVC: UIViewController {
    
    
    @IBOutlet weak var petitionTitleTextField: UITextField!
    @IBOutlet weak var makeChangingTextField: UITextField!
    @IBOutlet weak var ExplainProblemTextField: UITextField!
    
    
    @IBOutlet weak var characterCountwolbl: UILabel!
    
    @IBOutlet weak var characterCountOneLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        
    }
    
    @IBAction func backbtn(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func continuebtn(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "CreatePetitionTwoVC") as! CreatePetitionTwoVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
extension CreatePetitionOneVC : UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        if(textField == petitionTitleTextField){
            
            let fundraisertitleTextfieldlength = textField.text!.count +  (string.count - range.length)
            
            if  fundraisertitleTextfieldlength <= 100 {
                characterCountOneLbl.text = "\(fundraisertitleTextfieldlength )/100"
                return true
            }else{
                return false
            }
            
            
        }
        if(textField == ExplainProblemTextField){
            
            let fundraisertitleTextfieldlength = textField.text!.count +  (string.count - range.length)
            
            if  fundraisertitleTextfieldlength <= 250 {
                characterCountwolbl.text = "\(fundraisertitleTextfieldlength )/250"
                return true
            }else{
                return false
            }
            
            
        }
        
        
        return true
        
    }
    
}
