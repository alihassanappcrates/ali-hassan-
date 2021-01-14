//
//  DiscoverViewController.swift
//  Positive_Reactions
//
//  Created by Ali Hassan on 21/12/2020.
//

import UIKit

class DiscoverViewController: UIViewController{
    
    @IBOutlet weak var collectionview : UICollectionView!
    
    
    var arrayofitemname : [String] = ["All","Environment","Poverty","Environment","ok"]
    
    var viewindex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        
    }
    
    
    @IBAction func backbtn(_ sender: Any) {
        
        self.tabBarController?.selectedIndex = 0
        
    }
    
    
}
extension DiscoverViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemsTVC") as! itemsTVC
        return  cell
        
    }
    
}
extension DiscoverViewController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrayofitemname.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryitemCVC", for: indexPath) as! categoryitemCVC
        cell.itemnamelbl.text = arrayofitemname[indexPath.row]
        
        if viewindex == indexPath.row{
            
            cell.underLineView.isHidden = false
            
        }else{
            
            cell.underLineView.isHidden = true
            
        }
        
        cell.itembtn.tag = indexPath.row
        cell.itembtn.addTarget(self, action: #selector(itembuttonclick), for: .touchUpInside)
        
        return cell
        
    }
    @objc func itembuttonclick(_ sender : UIButton ) {
        
        self.viewindex = sender.tag
        self.collectionview.reloadData()
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
           return CGSize(width: 90.0, height: 30.0)
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 20
//    }
    
}
