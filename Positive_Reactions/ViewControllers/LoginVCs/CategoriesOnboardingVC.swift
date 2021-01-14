//
//  CategoriesOnboardingVC.swift
//  Positive_Reactions
//
//  Created by Ali Hassan on 30/12/2020.
//

import UIKit

import RappleProgressHUD
import Alamofire
import SwiftyJSON
import Kingfisher

class CategoriesOnboardingVC: UIViewController {
    
    @IBOutlet weak var categoriesCollectionView : UICollectionView!
    var getdate = signupinfo()
    
    var selectedcauses : [String] = []
    var setcasuse : [CausesModel] = []
    
    
    
    var arrayofselectedindex : [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getcauses { (scuess) in
            if scuess{
                
            }
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backbtn(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func nextBtn (_ sender: Any){
        
        getdate.causes = selectedcauses
        self.signup(info: getdate) { (succes) in
            if succes {
                let first = self.storyboard!.instantiateViewController(withIdentifier: "HomeviewTabbarController")
                self.navigationController?.pushViewController(first, animated: true)
            }
        }
        
        
        
    }
    
    @IBAction func SkipBtn(_ sender: Any){
        
        self.signup(info: getdate) { (succes) in
            if succes {
                let first = self.storyboard!.instantiateViewController(withIdentifier: "HomeviewTabbarController")
                self.navigationController?.pushViewController(first, animated: true)
            }
        }
        
    }
    
}
extension CategoriesOnboardingVC : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return setcasuse.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesOnboardCVC", for: indexPath) as! CategoriesOnboardCVC
        
        cell.categoriesName.text = setcasuse[indexPath.row].causename
        let url = URL(string: setcasuse[indexPath.row].causeimage)
        cell.CategoriesImage.kf.setImage(with: url)
        
        if arrayofselectedindex.contains(indexPath.row){
            cell.bgView.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        }else{
            cell.bgView.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9529411765, blue: 0.9647058824, alpha: 1)
        }
        
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
        if selectedcauses.count != 0 {
            
            for index in 0...selectedcauses.count - 1{
                
                if selectedcauses[index] == setcasuse[indexPath.row].causename{
                    
                    self.arrayofselectedindex.remove(at: index)
                    self.selectedcauses.remove(at: index)
                    self.categoriesCollectionView.reloadData()
                    
                    return
                }
                
            }
            
        }
        
        arrayofselectedindex.append(indexPath.row)
        
        self.categoriesCollectionView.reloadData()
        
        
        selectedcauses.append(setcasuse[indexPath.row].causename)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize.init(width : (view.frame.width - 72 ) / 3 , height: 134   )
        
    }
    
}
extension CategoriesOnboardingVC {
    
    func signup(info : signupinfo , completed: @escaping (_ finished: Bool)-> ()){
        
        RappleActivityIndicatorView.startAnimating()
        
        NetworkManager.sharedInstance.Signup(info: info) { (response) in
            
            RappleActivityIndicatorView.stopAnimation()
            switch response.result {
            case .success(_):
                
                if let value = response.result.value {
                    let json = JSON(value)
                    print(json)
                    if json["status"].intValue == 200 {
                        if json["message"].stringValue == "Registered User"{
                            
                            
                            UserDefaults.standard.setValue(json["data"]["_id"].stringValue, forKey: "userid")
                            completed(true)
                            
                        }else{
                            
                            let message =  json["message"].stringValue
                            self.showAlert("Alert",  message)
                            
                            
                        }
                        
                        
                    }else {
                        
                        print(json["message"].stringValue)
                        let message =  json["message"].stringValue
                        self.showAlert("Alert",  message)
                        
                    }
                }
            case .failure(let error):
                print("Error")
                
            }
            
            
        }
        
    }
    
}
extension CategoriesOnboardingVC {
    
    func getcauses( completed: @escaping (_ finished: Bool)-> ()){
        
        RappleActivityIndicatorView.startAnimating()
        
        NetworkManager.sharedInstance.getcauses() { (response) in
            
            RappleActivityIndicatorView.stopAnimation()
            switch response.result {
            case .success(_):
                
                if let value = response.result.value {
                    let json = JSON(value)
                    print(json)
                    if json["status"].intValue == 200 {
                        if json["message"].stringValue == "ALL Causes"{
                            
                            self.setcasuse.removeAll()
                            
                            self.setcasuse = json["data"].arrayValue.map({CausesModel(json: $0)})
                            self.categoriesCollectionView.reloadData()
                            
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
