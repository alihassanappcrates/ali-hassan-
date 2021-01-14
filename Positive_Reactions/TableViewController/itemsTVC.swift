//
//  itemsTVC.swift
//  Positive_Reactions
//
//  Created by Ali Hassan on 21/12/2020.
//

import UIKit

class itemsTVC: UITableViewCell , UICollectionViewDataSource , UICollectionViewDelegate{
    
    @IBOutlet weak var collectionview : UICollectionView!
    
    @IBOutlet weak var itemTitleLbl: UILabel!
    
    @IBOutlet weak var ShowAllbtn: UIButton!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
        collectionview.delegate = self
        collectionview.dataSource = self
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 3
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryviewCVC", for: indexPath) as! categoryviewCVC
        cell.imageview.image = UIImage(named: "img1")
        
        return cell
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 178 , height:213)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
}
