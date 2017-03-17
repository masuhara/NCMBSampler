//
//  TimelineViewController.swift
//  Sample
//
//  Created by Masuhara on 2017/03/17.
//  Copyright © 2017年 net.masuhara. All rights reserved.
//

import UIKit

// NCMBフレームワークの読み込み
import NCMB

// TableViewのDataSourceプロトコルとDelegateプロトコルを追加
class TimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // NCMBから読み込んだつぶやきを入れるための配列
    var posts = [NCMBObject]()
    
    // テーブルビュー
    @IBOutlet weak var timelineTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TableViewにカスタムセルを登録
        let nib = UINib(nibName: "TimelineTableViewCell", bundle: Bundle.main)
        timelineTableView.register(nib, forCellReuseIdentifier: "TimelineCell")
        
        // TableViewの基本設定
        timelineTableView.dataSource = self
        timelineTableView.delegate = self
        
        // 画面起動と同時にタイムラインの読み込み
        loadTimeline()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // テーブルのセル数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    // テーブルのセルの内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルの生成
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimelineCell") as! TimelineTableViewCell
        
        // セルにデータを入れる
        cell.messageLabel.text = posts[indexPath.row].object(forKey: "message") as? String
        cell.timeLabel.text = posts[indexPath.row].object(forKey: "createDate") as? String
        cell.userNameLabel.text = posts[indexPath.row].object(forKey: "userName") as? String
        
        // セルをTableViewに返す
        return cell
    }
    
    // タイムライン読み込み
    func loadTimeline() {
        // CRUDの「R」 = Read
        // Postクラス(データベース)から、全オブジェクトを取得している
        let query = NCMBQuery(className: "Post")
        query?.findObjectsInBackground({ (object, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                // データベースから読み込んだデータをNCMBのObject配列に変換
                // 読み込んだデータはAny?オブジェクトなので、ダウンキャストで変換
                let posts = object as! [NCMBObject]
                
                // 配列の中身を新しい順に並び替え(反転)
                self.posts = posts.reversed()
                
                // テーブルをリロード
                self.timelineTableView.reloadData()
            }
        })
    }
    
    // リロードボタン
    @IBAction func reloadTimeline() {
        loadTimeline()
    }
}
