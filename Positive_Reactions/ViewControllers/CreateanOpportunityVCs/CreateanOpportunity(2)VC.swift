//
//  CreateanOpportunity(2)VC.swift
//  Positive_Reactions
//
//  Created by Ali Hassan on 04/01/2021.
//

import UIKit
import DKImagePickerController
import AVFoundation
import AVKit
import Photos
import RappleProgressHUD
import Alamofire
import SwiftyJSON
import CoreLocation

class CreateanOpportunity_2_VC: UIViewController,CLLocationManagerDelegate {
    
    
    @IBOutlet weak var searchtableHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var locationtableview: UITableView!
    
    @IBOutlet weak var searchtableview: UITableView!
    
    
    @IBOutlet weak var AddressTextField: UITextField!
    @IBOutlet weak var categoryTextFeild: UITextField!
    @IBOutlet weak var imgview: UIImageView!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var crossbtn: UIButton!
    @IBOutlet weak var searchbar: UISearchBar!
    
    
    var player: AVPlayer!
    var avpController = AVPlayerViewController()
    var setdata = CreateOpportunitemodel()
    var locationManager:CLLocationManager!
    var address = ""
    var setcasuse : [CausesModel] = []
    var searched : [CausesModel] = []
    
    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchbar.delegate = self
        
        
        getcauses { (succes) in
            if succes{
                
            }
        }
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).leftView = nil
        
        // Give some left padding between the edge of the search bar and the text the user enters
        UISearchBar.appearance().searchTextPositionAdjustment = UIOffset(horizontal: 10, vertical: 0)
        
        imgview.isHidden = true
        videoView.isHidden = true
        crossbtn.isHidden = true
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.distanceFilter = 1000.0
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            
            locationManager.startUpdatingLocation()
            
        }
        
    }
    
    @IBAction func Backbtn(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func crossbtn(_ sender: Any) {
        
        self.imgview.clear()
        self.setdata.thumbnail = nil
        self.setdata.opportunity = nil
        self.imgview.isHidden = true
        self.videoView.isHidden = true
        self.crossbtn.isHidden = true
        
    }
    
    @IBAction func addimgbtn(_ sender: Any) {
        
        self.openGallery()
        
    }
    
    @IBAction func submitbtn(_ sender: Any) {
        
        if crossbtn.isHidden{
            showAlert("Alert", "Please select Any photo or Video")
            return
        }
        
        guard let address = AddressTextField.text, AddressTextField.text != "", AddressTextField.text != nil  else {
            showAlert("Alert", "Please Enter Address")
            return
        }
        guard  let category = searchbar.text , searchbar.text != "", searchbar.text != nil else {
            
            showAlert("Alert", "Please Select Any cause ")
            return
            
        }
        
        setdata.location = address
        setdata.category = category
        
        
        Createopportunity(info: setdata) { (success) in
            if success {
                
                self.navigationController?.popViewController(animated: true)
                
                self.tabBarController?.selectedIndex = 0
                
                
            }
        }
        
        
    }
    
}
extension CreateanOpportunity_2_VC {
    
    func openGallery() {
        let pickerController = DKImagePickerController()
        
        pickerController.maxSelectableCount = 1
        pickerController.assetType = .allAssets
        pickerController.allowMultipleTypes = false
        pickerController.didSelectAssets = { (assets: [DKAsset]) in
            if assets.count == 0 {
                self.navigationController?.popViewController(animated: true)
            } else {
                
                for (_, asset) in assets.enumerated() {
                    let oAsset = asset.originalAsset
                    oAsset?.getURL(completionHandler: { [self] assetURL in
                        if let assetURL = assetURL {
                            
                            print(assetURL)
                            
                            if asset.type == .photo {
                                
                                DispatchQueue.main.async {
                                    
                                    if let data = NSData(contentsOf: assetURL as URL),
                                       let img = UIImage(data: data as Data){
                                        
                                        
                                        self.crossbtn.isHidden = false
                                        
                                        imgview.isHidden = false
                                        imgview.image = img
                                        self.setdata.opportunity = assetURL
                                        self.setdata.isimage = true
                                        self.setdata.isvideo = false
                                        
                                    }else{
                                        showAlert("Alert","You're Selected Photo is not located in your phone")
                                    }
                                }
                                
                            }else{
                                
                                DispatchQueue.main.async {
                                    
                                    self.crossbtn.isHidden = false
                                    
                                    videoView.isHidden = false
                                    
                                    player = AVPlayer(url: assetURL)
                                    
                                    avpController.player = player
                                    
                                    avpController.view.frame.size.height = videoView.frame.size.height
                                    
                                    avpController.view.frame.size.width = videoView.frame.size.width
                                    
                                    self.videoView.addSubview(avpController.view)
                                    
                                    print("videourl \(assetURL)")
                                    
                                    self.setdata.opportunity = assetURL
                                    
                                    self.setdata.thumbnail = generateThumbnail(path: assetURL)
                                    self.setdata.isimage = false
                                    self.setdata.isvideo = true
                                    
                                }
                            }
                        }
                        
                        if assetURL == nil {
                            self.showAlert("Alert","You're Selected Photo or video is not located in your phone")
                        }
                        
                    })
                    
                }
            }
        }
        
        present(pickerController, animated: true) {}
        
    }
    func generateThumbnail(path: URL) -> UIImage? {
        do {
            let asset = AVURLAsset(url: path, options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
            let thumbnail = UIImage(cgImage: cgImage)
            return thumbnail
        } catch let error {
            print("*** Error generating thumbnail: \(error.localizedDescription)")
            return nil
        }
    }
}
extension PHAsset {
    
    func getURL(completionHandler : @escaping ((_ responseURL : URL?) -> Void)){
        
        if self.mediaType == .image {
            RappleActivityIndicatorView.startAnimating()
            let options: PHContentEditingInputRequestOptions = PHContentEditingInputRequestOptions()
            options.isNetworkAccessAllowed = true
            options.canHandleAdjustmentData = {(adjustmeta: PHAdjustmentData) -> Bool in
                return true
            }
            self.requestContentEditingInput(with: options, completionHandler: {(contentEditingInput: PHContentEditingInput?, info: [AnyHashable : Any]) -> Void in
                RappleActivityIndicatorView.stopAnimation()
                if let urlAsset = contentEditingInput?.fullSizeImageURL as URL?{
                    completionHandler(urlAsset)
                }else{
                    completionHandler(nil)
                }
                
            })
            
        } else if self.mediaType == .video {
            RappleActivityIndicatorView.startAnimating()
            let options: PHVideoRequestOptions = PHVideoRequestOptions()
            options.version = .original
            options.isNetworkAccessAllowed = true
            PHImageManager.default().requestAVAsset(forVideo: self, options: options, resultHandler: {(asset: AVAsset?, audioMix: AVAudioMix?, info: [AnyHashable : Any]?) -> Void in
                RappleActivityIndicatorView.stopAnimation()
                if let urlAsset = asset as? AVURLAsset {
                    
                    let localVideoUrl: URL = urlAsset.url as URL
                    completionHandler(localVideoUrl)
                } else {
                    DispatchQueue.main.async {
                        completionHandler(nil)
                    }
                }
            })
            
        }
        
    }
    
}
extension CreateanOpportunity_2_VC{
    
    func Createopportunity(info : CreateOpportunitemodel , completed: @escaping (_ finished: Bool)-> ()){
        
        RappleActivityIndicatorView.startAnimating()
        
        NetworkManager.sharedInstance.Createopportunity(info: info) { (response) in
            
            RappleActivityIndicatorView.stopAnimation()
            switch response.result {
            case .success(_):
                
                if let value = response.result.value {
                    let json = JSON(value)
                    print(json)
                    if json["status"].intValue == 200 {
                        if json["message"].stringValue == "Opportunity Posted"{
                            
                            
                            
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
extension CreateanOpportunity_2_VC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == searchtableview{
            
            searchtableHeight.constant = CGFloat(( 66 * searched.count))
            return searched.count
            
        }
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == searchtableview{
            let cell = tableView.dequeueReusableCell(withIdentifier: "searchresultTVC") as! searchresultTVC
            
            cell.lbl.text  = searched[indexPath.row].causename
            cell.uperviewbtn.tag = indexPath.row
            cell.uperviewbtn.addTarget(self, action: #selector(upersearchbtn), for: .touchUpInside)
            
            return cell
        }else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "locationTVC") as! locationTVC
            
            cell.currentlocation.text  = "Use Current Location"
            cell.addresslbl.text = address
            cell.uperbtn.tag = indexPath.row
            cell.uperbtn.addTarget(self, action: #selector(uperbtn), for: .touchUpInside)
            
            return cell
        }
    }
    
    @objc func upersearchbtn(_ sender : UIButton ){
        self.searchbar.text = searched[sender.tag].causename
    }
    
    @objc func uperbtn(_ sender : UIButton ){
        
        self.AddressTextField.text = address
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 66
        
    }
    
}

extension CreateanOpportunity_2_VC{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation :CLLocation = locations[0] as CLLocation
        
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
        
        getAddressFromLatLon(pdblLatitude: "\(userLocation.coordinate.latitude)", withLongitude: "\(userLocation.coordinate.longitude)")
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print("Error \(error)")
        
        
    }
    
    // This function is used to get address from latitude or longitude
    
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        //21.228124
        let lon: Double = Double("\(pdblLongitude)")!
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
                                    {(placemarks, error) in
                                        if (error != nil)
                                        {
                                            print("reverse geodcode fail: \(error!.localizedDescription)")
                                        }
                                        let pm = placemarks! as [CLPlacemark]
                                        
                                        if pm.count > 0 {
                                            let pm = placemarks![0]
                                            print(pm.country)
                                            print(pm.locality)
                                            print(pm.subLocality)
                                            print(pm.thoroughfare)
                                            print(pm.postalCode)
                                            print(pm.subThoroughfare)
                                            var addressString : String = ""
                                            
                                            if pm.subLocality != nil {
                                                addressString = addressString + pm.subLocality! + ", "
                                            }
                                            if pm.thoroughfare != nil {
                                                addressString = addressString + pm.thoroughfare! + ", "
                                            }
                                            if pm.locality != nil {
                                                addressString = addressString + pm.locality! + ", "
                                            }
                                            if pm.country != nil {
                                                addressString = addressString + pm.country! + ", "
                                            }
                                            if pm.postalCode != nil {
                                                addressString = addressString + pm.postalCode! + " "
                                            }
                                            
                                            print(addressString)
                                            self.address = addressString
                                            self.locationtableview.reloadData()
                                            
                                        }
                                    })
        
    }
}
extension CreateanOpportunity_2_VC{
    
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
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        
        searched = setcasuse.filter { res in
            
            if !(res.causename == scope ) && scope != "All"  {
                return false
            }
            if searchText == ""{
                return false
            }
            
            return res.causename.lowercased().contains(searchText.lowercased()) || searchText == ""
            
        }
        
        searchtableview.reloadData()
        
        
        
    }
    
}
extension CreateanOpportunity_2_VC : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let searchBar = searchText.lowercased()
        
        searching = true
        filterContentForSearchText(searchBar)
        
        
    }
    
    
    
    
}
