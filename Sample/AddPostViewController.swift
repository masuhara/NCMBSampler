//
//  AddPostViewController.swift
//  Sample
//
//  Created by Masuhara on 2017/03/17.
//  Copyright © 2017年 net.masuhara. All rights reserved.
//

import UIKit

// NCMBフレームワークの読み込み
import NCMB

class AddPostViewController: UIViewController {
    
    // ツイートを書き込むためのTextView
    @IBOutlet weak var messageTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 画面が表示されたら、TextViewが編集できるようにフォーカス
    override func viewDidAppear(_ animated: Bool) {
        messageTextView.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addPost() {
        
        // ステータスバーにインジケータ(ぐるぐる回るやつ)を表示
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        // NCMBのPostクラスに、書き込み内容と書き込んだユーザー情報を保存
        // CRUDの「C」(Create)
        let post = NCMBObject(className: "Post")
        post?.setObject(messageTextView.text, forKey: "message")
        post?.setObject(NCMBUser.current().objectId, forKey: "userId")
        post?.setObject(NCMBUser.current().userName, forKey: "userName")
        post?.saveInBackground({ (error) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if error != nil {
                // エラーが起きた場合アラートを出す
                let alertController = UIAlertController(title: "エラー", message: "投稿出来ませんでした。", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    alertController.dismiss(animated: true, completion: nil)
                })
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            } else {
                // 投稿が完了したら、アラートを出し、OKを押したらタイムラインに戻る
                let alertController = UIAlertController(title: "投稿完了", message: "投稿が完了しました。タイムラインに戻ってリロードして下さい。", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    _ = self.navigationController?.popViewController(animated: true)
                })
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        })
    }
}
