//
//  SignInViewController.swift
//  Sample
//
//  Created by Masuhara on 2017/03/17.
//  Copyright © 2017年 net.masuhara. All rights reserved.
//

import UIKit

// NCMBフレームワークの読み込み
import NCMB

class SignInViewController: UIViewController {
    
    @IBOutlet weak var mailAddressTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signIn() {
        
        // メールアドレス、パスワードに何も入力されていなかったら反応しないようにする
        guard let address = mailAddressTextField.text else {
            return
        }
        
        guard let password = passwordTextField.text else {
            return
        }
        
        // ログイン
        NCMBUser.logInWithMailAddress(inBackground: address, password: password) { (user, error) in
            if error != nil {
                // エラーが起きた場合は出力
                print(error!.localizedDescription)
            } else {
                // ログインが成功した場合はMain.storyboardを起動
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let viewController = storyboard.instantiateInitialViewController()
                let appDelegate = UIApplication.shared.delegate
                appDelegate?.window!?.rootViewController = viewController
                appDelegate?.window!?.makeKeyAndVisible()
                
                // UserDefaultsのログイン情報をログイン済に変更
                let ud = UserDefaults.standard
                ud.set(true, forKey: "isSignIn")
                ud.synchronize()
            }
        }
    }

}
