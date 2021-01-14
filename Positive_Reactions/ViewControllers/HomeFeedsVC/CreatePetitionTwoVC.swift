//
//  CreatePetitionTwoVC.swift
//  Positive_Reactions
//
//  Created by Ali Hassan on 16/12/2020.
//

import UIKit

class CreatePetitionTwoVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backbtn(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func SubmitPetitionbtn(_ sender: Any) {
        
        let first = storyboard!.instantiateViewController(withIdentifier: "HomeviewTabbarController")
        first.modalPresentationStyle = .fullScreen
        self.present(first , animated: false, completion: nil)
        //        self.navigationController?.pushViewController(first, animated: true)
    }
    
    
}
