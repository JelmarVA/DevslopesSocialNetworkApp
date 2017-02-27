//
//  ProfileVC.swift
//  SocialNetwork
//
//  Created by Jelmar Van Aert on 26/02/2017.
//  Copyright © 2017 Jelmar Van Aert. All rights reserved.
//

import UIKit
import Firebase

class ProfileVC: TableViewSetupVC, UITextFieldDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameField: EnabledDisabledField!
    @IBOutlet weak var profilePic: CircleView!
    
    override var imageSelected: Bool {
        didSet{
            if !imageSelected {
                profilePic.image = UIImage(named: "")
            }
        }
    }
    var realProfile: Profile!
    var profileUid: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        nameField.delegate = self
        
        realProfile = Profile(withUid: profileUid, completion: { (succes) in
            if succes {
                self.updateView()
            }
        })
    }
    
    func updateView() {
        nameField.text = realProfile.name
        
        //Update profile picture
        if let url = realProfile.imgUrl {
            if let cachedImg = FeedVC.imageCache.object(forKey:url as NSString){
                self.profilePic.image = cachedImg
            }else {
                let ref = FIRStorage.storage().reference(forURL: url)
                ref.data(withMaxSize: 2 * 1024 * 1024) { (data, error) in
                    if error != nil {
                        print("ERROR with downloading profilepic")
                    }else {
                        if let imgData = data {
                            if let img = UIImage(data: imgData){
                                self.profilePic.image = img
                                FeedVC.imageCache.setObject(img, forKey: self.realProfile.imgUrl! as NSString)
                            }
                            
                        }
                    }
                    
                }
            }
        }
        
        //TODO laad de posts
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            profilePic.image = image
            imageSelected = true
            postPictureToFirebase()
        }else {
            print("JELMAR: a valid image wasn't selected")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func postPictureToFirebase() {
        guard let img = profilePic.image else {
            print("There is no profile-pic")
            return
        }
        
        if let imageData = UIImageJPEGRepresentation(img, 0.2) {
            let imgUid = NSUUID().uuidString
            let metaData = FIRStorageMetadata()
            metaData.contentType = "image/jpeg"
            
            DataService.ds.REF_PROFILE_IMAGES.child(imgUid).put(imageData, metadata: metaData, completion: { (metadata, error) in
                
                if error != nil {
                    print("Unable to upload image")
                }else {
                    let downloadURL = metadata?.downloadURL()?.absoluteString
                    if let url = downloadURL {
                        self.realProfile.imgUrl = url
                    }
                }
            })
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let name = nameField.text, name != "" {
            realProfile.name = name
        }
        nameField.isEnabled = !nameField.isEnabled
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let name = nameField.text, name != "" {
            realProfile.name = name
        }
        nameField.isEnabled = !nameField.isEnabled
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func touchedEditProfilePic(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func touchedEditName(_ sender: UIButton) {
        nameField.isEnabled = !nameField.isEnabled
    }
    
}
