//
//  SignUpViewController.swift
//  Sample
//
//  Created by Masuhara on 2017/03/17.
//  Copyright © 2017年 net.masuhara. All rights reserved.
//

import UIKit

// NCMBフレームワークの読み込み
import NCMB

// TextFieldプロトコルを追加
class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var mailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // キーボードを閉じる(完了ボタンの検知の)ためにDelegateを設定
        usernameTextField.delegate = self
        mailAddressTextField.delegate = self
        passwordTextField.delegate = self
        confirmTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // キーボードのReturnキーが押されたときを検知し、キーボードを閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func registerUser() {
        
        // ちゃんと書き込まれているかチェックし、文字数が0なら反応しないようにする
        if usernameTextField.text?.characters.count == 0 {
            return
        }
        
        if mailAddressTextField.text?.characters.count == 0 {
            return
        }
        
        if passwordTextField.text?.characters.count == 0 {
            return
        }
        
        if passwordTextField.text != confirmTextField.text {
            return
        }
        
        // ユーザー情報をNCMBのユーザー情報を保存するクラスに保存
        // CRUDの「C」(Create)
        let user = NCMBUser()
        user.userName = usernameTextField.text
        user.mailAddress = mailAddressTextField.text
        user.password = passwordTextField.text
        
        NCMBUser.requestAuthenticationMail(mailAddressTextField.text, error: nil)
        user.signUpInBackground { (error) in
            if error != nil {
                // エラーが起きた場合
                print(error!.localizedDescription)
            } else {
                // 新規登録が完了した場合、Main.storyboardを起動
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let viewController = storyboard.instantiateInitialViewController()
                let appDelegate = UIApplication.shared.delegate
                appDelegate?.window!?.rootViewController = viewController
                appDelegate?.window!?.makeKeyAndVisible()
                
                // UserDefaultsにログイン済みと記録
                let ud = UserDefaults.standard
                ud.set(true, forKey: "isSignIn")
                ud.synchronize()
            }
        }
    }

}
