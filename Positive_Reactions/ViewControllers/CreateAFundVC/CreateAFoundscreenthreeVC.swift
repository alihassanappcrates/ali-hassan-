//
//  CreateAFoundscreenthreeVC.swift
//  Positive_Reactions
//
//  Created by Ali Hassan on 18/12/2020.
//

import UIKit

class CreateAFoundscreenthreeVC: UIViewController {
    
    
    @IBOutlet weak var Crossbtn: UIButton!
    @IBOutlet weak var Addbtn: UIButton!
    @IBOutlet weak var imageview: UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Crossbtn.isHidden = true
        
    }
    
    @IBAction func Backbtn(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func Crossbtn(_ sender: Any) {
        
    }
    @IBAction func Addbtn(_ sender: Any) {
        
    }
    @IBAction func UploadPhotobtn(_ sender: Any) {
        
    }
    @IBAction func UseImageFromMainCasuseBtn(_ sender: Any) {
        
    }
    @IBAction func PreviewMyFundraiserbtn(_ sender: Any) {
        
    }
    @IBAction func CompleteFundraiserBtn(_ sender: Any) {
        
        let first = storyboard!.instantiateViewController(withIdentifier: "HomeviewTabbarController")
        
        first.modalPresentationStyle = .fullScreen
        self.present(first , animated: false, completion: nil)
//        self.navigationController?.pushViewController(first, animated: true)
        
    }

}
