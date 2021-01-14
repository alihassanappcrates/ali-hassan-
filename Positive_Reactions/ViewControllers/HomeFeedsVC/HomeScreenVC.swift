//
//  HomeScreenVC.swift
//  Positive_Reactions
//
//  Created by Ali Hassan on 16/12/2020.
//

import UIKit
import RappleProgressHUD
import Alamofire
import SwiftyJSON
import Kingfisher
import AVFoundation
import AVKit




class HomeScreenVC: UIViewController {
    
    var AVdisplayplayer : AVPlayer!
    var avvideoPlayerLayer: AVPlayerLayer!
    @IBOutlet weak var CollectionView: UICollectionView!
    
    var showindex = -1
    
    var refreshControl = UIRefreshControl()
    
    var setdata : [Allopportunitiesmodel] = []
    
    var currentindex : IndexPath = IndexPath(row: 0, section: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getOpportunity { (success) in
            if success{
                
            }
        }
        
        CollectionView.isPagingEnabled = true
        refreshControl.addTarget(self, action: #selector(refreshToLoad), for: UIControl.Event.valueChanged)
        CollectionView.addSubview(refreshControl)
        
        let swipedown = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        swipedown.direction = UISwipeGestureRecognizer.Direction.down
        self.CollectionView.addGestureRecognizer(swipedown)
        
    }
    @objc func swiped(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .down{
            
            getOpportunity { (success) in
                if success{
                    
                }
            }
            
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        if AVdisplayplayer != nil {
            AVdisplayplayer.pause()
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        getOpportunity { (success) in
            if success{
                
            }
        }
        
    }
    @objc func refreshToLoad(_ sender: Any) {
        
        getOpportunity { (success) in
            if success{
                
            }
        }
        
    }
    
    
    @objc func signPetitionBtn(_ sender: UIButton) {
        
        let index = sender.tag
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "CreatePetitionOneVC") as! CreatePetitionOneVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @objc  func DonateBtn(_ sender: UIButton) {
        
        let index = sender.tag
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "CreateAfoundscreenOneVC") as! CreateAfoundscreenOneVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc  func Coinsbtn(_ sender: UIButton){
        
        let index = sender.tag
        
    }
    @objc  func ForwordBtn(_ sender: UIButton) {
        
        let index = sender.tag
        
    }
    
    @objc  func letterbtn(_ sender: UIButton){
        
        let index = sender.tag
        
    }
    @objc  func Viewbtn(_ sender: UIButton) {
        
        let index = sender.tag
        showindex = index
        CollectionView.reloadData()
        
    }
    @objc  func Crossbtn(_ sender: UIButton){
        
        showindex = -1
        CollectionView.reloadData()
        
    }
    
}
extension HomeScreenVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return setdata.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let index = indexPath.row
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomescreenCVC", for: indexPath) as! HomescreenCVC
        
        cell.NameofUploadPersonlbl.text = setdata[index].title
        cell.HashTagLbl.text = setdata[index].hashTags
        cell.detaildescriptionlbl.text = setdata[index].description
        cell.TitleofCause.text = setdata[index].categorie
        
        let url = URL(string: setdata[index].opportunity)
        currentindex = indexPath
        if setdata[index].isVideo{
            
            cell.Bgimage.isHidden = true
            cell.bgvideoView.isHidden = false
            cell.configure(setdata: self.setdata[index])
            cell.avPlayerLayer = AVPlayerLayer(player: cell.avPlayer)
            cell.avPlayerLayer.videoGravity = .resizeAspectFill
            cell.avPlayerLayer.frame = CGRect(x: 0, y: 0, width: cell.bgvideoView.frame.size.width, height: cell.bgvideoView.frame.size.height )
            
            
            NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying),
                                                   name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: cell.avPlayer.currentItem)
            
            
            
            cell.bgvideoView.layer.addSublayer(cell.avPlayerLayer)
            
            
        }else{
            cell.Bgimage.isHidden = false
            cell.bgvideoView.isHidden = true
            cell.Bgimage.kf.setImage(with: url)
        }
        
        if indexPath.row == showindex {
            
            cell.uperalpheview.isHidden = false
            cell.uperalphadataview.isHidden = false
            
        }else{
            
            cell.uperalpheview.isHidden = true
            cell.uperalphadataview.isHidden = true
            
        }
        
        cell.Crossbtn.tag = indexPath.row
        cell.DonateBtn.tag = indexPath.row
        cell.Letterbtn.tag = indexPath.row
        cell.Coinsbtn.tag = indexPath.row
        cell.signPetitionbtn.tag = indexPath.row
        cell.ForwordBtn.tag = indexPath.row
        cell.Viewbtn.tag = indexPath.row
        
        cell.Crossbtn.addTarget(self, action: #selector(Crossbtn), for: .touchUpInside)
        cell.DonateBtn.addTarget(self, action: #selector(DonateBtn), for: .touchUpInside)
        cell.Letterbtn.addTarget(self, action: #selector(letterbtn), for: .touchUpInside)
        cell.Coinsbtn.addTarget(self, action: #selector(Coinsbtn), for: .touchUpInside)
        cell.signPetitionbtn.addTarget(self, action: #selector(signPetitionBtn), for: .touchUpInside)
        cell.ForwordBtn.addTarget(self, action: #selector(ForwordBtn), for: .touchUpInside)
        cell.Viewbtn.addTarget(self, action: #selector(Viewbtn), for: .touchUpInside)
        
        return cell 
        
    }
    @objc func playerDidFinishPlaying(note: NSNotification) {
        print("Video Finished")
        
        if currentindex.row <  setdata.count{
            self.CollectionView.scrollToItem(at: IndexPath(row:  currentindex.row + 1 , section: 0), at: .centeredHorizontally, animated: true)
        }
        
    }
    
    //    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    //
    ////       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomescreenCVC", for: indexPath) as! HomescreenCVC
    ////        cell.avPlayer.pause()
    //
    //          if let comedyCell = cell as? HomescreenCVC {
    //            if currentindex != indexPath{
    //                comedyCell.avPlayer.pause()
    //            }
    //          }
    //
    //    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if setdata[indexPath.row].isVideo{
            
            if AVdisplayplayer != nil{
                
                AVdisplayplayer.pause()
                
            }
            
            
            AVdisplayplayer = (cell as? HomescreenCVC)!.avPlayer
            //            AVdisplayplayer.replaceCurrentItem(with: (cell as? HomescreenCVC)!.avPlayerLayer)
            
            //        (cell as? HomescreenCVC)!.avPlayer.play()
            
            
            AVdisplayplayer.play()
            
        }else{
            if AVdisplayplayer != nil{
                
                AVdisplayplayer.pause()
                
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        (cell as? HomescreenCVC)!.avPlayer.pause()
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize.init(width : self.CollectionView.frame.width , height: CollectionView!.frame.height - 10   )
        
    }
    
    
}
extension HomeScreenVC{
    
    func getOpportunity( completed: @escaping (_ finished: Bool)-> ()){
        
        RappleActivityIndicatorView.startAnimating()
        
        NetworkManager.sharedInstance.getallOpportunities() { (response) in
            
            RappleActivityIndicatorView.stopAnimation()
            switch response.result {
            case .success(_):
                
                if let value = response.result.value {
                    let json = JSON(value)
                    print(json)
                    if json["status"].intValue == 200 {
                        if json["message"].stringValue == "ALL Opportunities"{
                            
                            self.setdata.removeAll()
                            
                            self.setdata = json["data"].arrayValue.map({Allopportunitiesmodel(json: $0)})
                            self.CollectionView.reloadData()
                            
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

