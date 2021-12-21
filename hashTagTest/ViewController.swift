//
//  ViewController.swift
//  hashTagTest
//
//  Created by 笹倉一也 on 2021/12/19.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    
    @IBOutlet weak var textfiedl: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
    }

    @IBAction func send(_ sender: Any) {
    
        let db = Firestore.firestore()
        
        //入力された文字列をfireStoreのデータベースに保存します。
           db.collection("collection").document().setData(["text" : textfiedl.text!])
        
        
        let hashTagText = textfiedl.text as NSString?

            do{
                let regex = try NSRegularExpression(pattern: "#\\S+", options: [])
                //見つけたハッシュタグを、for文で回す。
                for match in regex.matches(in: hashTagText! as String, options: [], range: NSRange(location: 0, length: hashTagText!.length)) {

                    //見つかったハッシュタグを引数に入れデータベースに保存
                    Firestore.firestore().collection(hashTagText!.substring(with: match.range)).document().setData(["text" : self.textfiedl.text!])
                }
            }catch{
            }

           //データを保存したら、画面遷移を行います。
        let tableVC = (storyboard?.instantiateViewController(identifier: "tableVC"))! as tableViewController
        
        navigationController?.pushViewController(tableVC, animated: true)

    
    }
    
}

