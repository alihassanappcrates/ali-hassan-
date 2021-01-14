//
//  HomescreenCVC.swift
//  Positive_Reactions
//
//  Created by Ali Hassan on 16/12/2020.
//

import UIKit
import AVFoundation
import AVKit

class HomescreenCVC: UICollectionViewCell, UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var Bgimage: UIImageView!
    
    @IBOutlet weak var bgvideoView: UIView!
    
    @IBOutlet weak var uperalpheview: UIView!
    @IBOutlet weak var uperalphadataview: UIView!
    
    @IBOutlet weak var TableView: UITableView!
    
    @IBOutlet weak var NameofUploadPersonlbl: UILabel!
    
    @IBOutlet weak var TitleofCause: UILabel!
    @IBOutlet weak var HashTagLbl: UILabel!
    @IBOutlet weak var detaildescriptionlbl: UILabel!
    @IBOutlet weak var PositiveRectionlbl: UILabel!
    
    @IBOutlet weak var Crossbtn: UIButton!
    
    @IBOutlet weak var Letterbtn: UIButton!
    @IBOutlet weak var allFeedBtn: UIButton!
    @IBOutlet weak var Coinsbtn: UIButton!
    @IBOutlet weak var DonateBtn: UIButton!
    @IBOutlet weak var signPetitionbtn: UIButton!
    @IBOutlet weak var ForwordBtn: UIButton!
    @IBOutlet weak var Viewbtn: UIButton!
    
    var avPlayer = AVPlayer()
    var avPlayerLayer = AVPlayerLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        TableView.dataSource = self
        TableView.delegate = self
            
        
        
    }
    
    func configure(setdata : Allopportunitiesmodel){
        
        let url = URL(string: setdata.opportunity)
        let item = AVPlayerItem(url: url!)
        avPlayer = AVPlayer(playerItem: item)
        avPlayer.replaceCurrentItem(with: item)
        avPlayer.actionAtItemEnd = .none
        
    }
    
    override func prepareForReuse() {
        avPlayerLayer.removeFromSuperlayer()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell") as! CommentTableViewCell
        
        return cell
        
    }
    
    
}
