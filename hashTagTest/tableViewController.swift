//
//  tableViewController.swift
//  hashTagTest
//
//  Created by 笹倉一也 on 2021/12/19.
//

import UIKit
import Firebase
import ActiveLabel

class tableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var tableview: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        textArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //storyBoard上のセルと、紐付けを行なっています。
             let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
             let textLabel = cell.contentView.viewWithTag(1) as! ActiveLabel   // ActiveLabelに変更する

             //取得してきた文字列をセルに反映しています。
             textLabel.text = textArray[indexPath.row]

             //ハッシュタグをタップしたらどうなるかの処理を追加記述 ==============================

             textLabel.handleHashtagTap() { hashTag in

                 //storyBoard上のhashTagViewControllerをインスタンス化
                 let hashVC = self.storyboard?.instantiateViewController(identifier: "hashVC") as! hashTagViewController

                 //hashVCへ、タップしたハッシュタグの情報を渡す
                 hashVC.hashTag = hashTag

                 //画面遷移
                 self.navigationController?.pushViewController(hashVC, animated: true)
             }

             //ハッシュタグをタップしたらどうなるかの処理を追加記述 ==============================

             return cell

    }
    

    
    var textArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.delegate = self
        tableview.dataSource = self
        
        
//        let nib = UINib(nibName: "acTableViewCell", bundle: nil)
        
//        tableview.register(nib, forCellReuseIdentifier: "Cell")
        
        loadData()
        
        // Do any additional setup after loading the view.
    }
    
    func loadData(){

          Firestore.firestore().collection("collection").addSnapshotListener { snapShot, error in

              if let snapShotDoc = snapShot?.documents{

                  for doc in snapShotDoc {

                      let data = doc.data()

                      if let text = data["text"] as? String {
                          print(text)
                          //取得してきたデータを、配列に入れていく。
                          self.textArray.append(text)
                      }
                  }
                  //データを取得し終わったら、tableViewを更新する。
                  self.tableview.reloadData()
              }
          }
      }
  

}
