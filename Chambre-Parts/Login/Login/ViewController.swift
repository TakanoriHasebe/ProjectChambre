//
//  ViewController.swift
//  Login
//
//  Created by Takanori.H on 2017/04/01.
//  Copyright © 2017年 Takanori.H. All rights reserved.
//

import UIKit
import Firebase // コピペ
import GoogleSignIn // コピペ

class ViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // コピペ
        let googleButton = GIDSignInButton()
        googleButton.frame = CGRect(x: 20, y: 250, width: self.view.frame.size.width-40, height: 60)
        view.addSubview(googleButton)
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
    }
    
    // コピペ
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let err = error{
            
            print("エラーです。", err)
            return
        }
        
        print("成功しました")
        
        guard  let idToken = user.authentication.idToken else {
            return
        }
        
        guard let accessToken = user.authentication.accessToken else{
            return
        }
        
        let credential = FIRGoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        
        FIRAuth.auth()?.signIn(with: credential, completion: { (user,error) in
            
            if let err = error{
                
                print("エラーです。")
                return
            }
            
            print("成功")
            
            // 画面移動の際に必要になる。
            self.performSegue(withIdentifier: "next", sender: nil)
            
        })
        
    }
    
    // ユーザーの情報を渡す
    // コピペ
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "next"){
            
            
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        
    }


}

