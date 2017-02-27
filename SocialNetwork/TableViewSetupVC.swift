//
//  TableViewSetupVC.swift
//  SocialNetwork
//
//  Created by Jelmar Van Aert on 26/02/2017.
//  Copyright © 2017 Jelmar Van Aert. All rights reserved.
//

import UIKit

class TableViewSetupVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private var _data = [Post]()
    
    var data: [Post] {get { return _data } set { _data = newValue }}
    var imagePicker: UIImagePickerController!
    var imageSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2//data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if data.count > 0 {
            let post = data[indexPath.row]
            if let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath) as? PostCell {
                
                if let img = FeedVC.imageCache.object(forKey: post.imgUrl as NSString) {
                    cell.configureCell(post: post, img: img)
                    return cell
                }else {
                    cell.configureCell(post: post)
                    return cell
                }
            }else {
                return PostCell()
            }
            
        }else {
            return tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath)
        }
    }
    
}
