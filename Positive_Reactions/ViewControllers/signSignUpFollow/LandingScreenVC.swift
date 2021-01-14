//
//  LandingScreenVC.swift
//  Positive_Reactions
//
//  Created by Ali Hassan on 24/12/2020.
//

import UIKit

class LandingScreenVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpBtn(_ sender: Any) {
        
        let first = storyboard!.instantiateViewController(withIdentifier: "HomeviewTabbarController")
        self.navigationController?.pushViewController(first, animated: true)
        
    }
    
    
    @IBAction func Loginbtn(_ sender: Any) {
        
        let first = storyboard!.instantiateViewController(withIdentifier: "HomeviewTabbarController")
        self.navigationController?.pushViewController(first, animated: true)
        
    }
    

}
