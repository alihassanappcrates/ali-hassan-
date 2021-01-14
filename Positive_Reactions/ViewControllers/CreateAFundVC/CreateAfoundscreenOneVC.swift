//
//  CreateAfoundscreenOneVC.swift
//  Positive_Reactions
//
//  Created by Ali Hassan on 18/12/2020.
//

import UIKit

class CreateAfoundscreenOneVC: UIViewController {
   
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func ContinueBtn(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "CreateAFoundScreentwoVC") as! CreateAFoundScreentwoVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func Backbtn(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    

}
