//
//  hashTagViewController.swift
//  hashTagTest
//
//  Created by 笹倉一也 on 2021/12/19.
//

import UIKit
import Firebase
import ActiveLabel

class hashTagViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
  
    var hashTag = String()
    var hashArray = [String]()
    var post = [String]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return post.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //storyBoard上のセルと、紐付けを行なっています。
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
             let textLabel = cell.contentView.viewWithTag(1) as! ActiveLabel   // ActiveLabelに変更する

             //取得してきた文字列をセルに反映しています。
             textLabel.text = post[indexPath.row]
        
        return cell
        
    }
    

    
    
    @IBOutlet weak var hashTableview: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hashTableview.delegate = self
        hashTableview.dataSource = self
        
        print(hashTag)
        
        let db = Firestore.firestore()
        
        db.collection("#\(hashTag)").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    
//                    print("\(document.documentID) => \(document.data())")
                    
                    self.post = querySnapshot!.documents.compactMap { $0.data()["text"] as? String }
                    print(self.post)
                    
                }
                self.hashTableview.reloadData()
                
            }
        }
        
        
        

        // Do any additional setup after loading the view.
    }
    

  

}
