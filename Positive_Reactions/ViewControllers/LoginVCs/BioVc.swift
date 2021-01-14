//
//  BioVc.swift
//  Positive_Reactions
//
//  Created by Ali Hassan on 30/12/2020.
//

import UIKit

class BioVc: UIViewController {
    
    @IBOutlet weak var bioText : UITextField!
    var getdate = signupinfo()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        
    }
    
    @IBAction func backbtn(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func nextBtn (_ sender: Any){
        
        guard let bioinfo = bioText.text , bioText.text != nil , bioText.text != "" else {
            self.showAlert("Alert", "Please Enter Bio Infomation first")
            return
        }
        
        getdate.bio = bioinfo
        let first = storyboard!.instantiateViewController(withIdentifier: "CategoriesOnboardingVC") as! CategoriesOnboardingVC
        
        first.getdate = self.getdate
        self.navigationController?.pushViewController(first, animated: true)
        
    }
    
    @IBAction func SkipBtn(_ sender: Any){
        
        let first = storyboard!.instantiateViewController(withIdentifier: "CategoriesOnboardingVC") as! CategoriesOnboardingVC
        first.getdate = self.getdate
        self.navigationController?.pushViewController(first, animated: true)
        
    }
    
    
}
