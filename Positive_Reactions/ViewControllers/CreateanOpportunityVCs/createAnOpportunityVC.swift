//
//  createAnOpportunityVC.swift
//  Positive_Reactions
//
//  Created by Ali Hassan on 04/01/2021.
//

import UIKit

class createAnOpportunityVC: UIViewController{
    
    
    
    @IBOutlet weak var countlbl: UILabel!
    
    @IBOutlet weak var Titletextfield: UITextField!
    
    @IBOutlet weak var collectionview: UICollectionView!
    
    @IBOutlet weak var collectionviewWidth: NSLayoutConstraint!
    
    @IBOutlet weak var DescriptionTextFeild: UITextField!
    
    @IBOutlet weak var AddHashTagsTextField: UITextField!
    
    var setdata = CreateOpportunitemodel()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        AddHashTagsTextField.delegate = self
        Titletextfield.delegate = self
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func ContinueBtn(_ sender: Any) {
        
        guard let title = Titletextfield.text , Titletextfield.text != "", Titletextfield.text != nil else {
            showAlert("Alert", "Please Enter Title first")
            return
        }
        guard let description = DescriptionTextFeild.text , DescriptionTextFeild.text != "", DescriptionTextFeild.text != nil else {
            
            showAlert("Alert", "Please Enter About Opportunite first")
            return
            
        }
        
        guard let HashTag = AddHashTagsTextField.text , AddHashTagsTextField.text != "", AddHashTagsTextField.text != nil else {
            showAlert("Alert", "Please Add HashTag first")
            return
        }
        
        Titletextfield.text = ""
        DescriptionTextFeild.text = ""
        AddHashTagsTextField.text = ""
        countlbl.text = "0/100"
        
        setdata.title = title
        setdata.description = description
        setdata.hashTags.append(HashTag)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "CreateanOpportunity_2_VC") as! CreateanOpportunity_2_VC
        vc.setdata = setdata
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func backbtn(_ sender: Any) {
        
        self.tabBarController?.selectedIndex = 0
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField.text?.last == " "{
            
        }
        return true
    }
    
    
}
extension createAnOpportunityVC : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "HashTagCVC", for: indexPath) as! HashTagCVC
        return cell
        
    }
    
}
extension createAnOpportunityVC : UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        if(textField == Titletextfield){
            
            let fundraisertitleTextfieldlength = textField.text!.count +  (string.count - range.length)
            
            if  fundraisertitleTextfieldlength <= 100 {
                countlbl.text = "\(fundraisertitleTextfieldlength )/100"
                return true
            }else{
                return false
            }
            
        }
        
        return true
        
    }
    
}
