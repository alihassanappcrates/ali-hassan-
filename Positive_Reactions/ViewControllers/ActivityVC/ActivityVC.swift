//
//  ActivityVC.swift
//  Positive_Reactions
//
//  Created by Ali Hassan on 21/12/2020.
//

import UIKit

class ActivityVC: UIViewController {
    
    @IBOutlet weak var activitynameTV : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func Backbtn(_ sender: Any) {
        
        self.tabBarController?.selectedIndex = 0
        
    }
    
    
}
extension ActivityVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 || indexPath.row == 4{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityNameTVC") as! ActivityNameTVC
            return cell
            
        }
        else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "activityTVC") as! activityTVC
            if indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3{
                
                //                cell.backgroundColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1)
                cell.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 0.5)
                
            }
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 || indexPath.row == 4{
            
            return 30.0
            
        }else{
            
            return 130.0
            
        }
    }
    
    
}
