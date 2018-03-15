//
//  InsertViewController.swift
//  AlamofireSampleApp
//
//  Created by 橋本 智広 on 2018/03/08.
//  Copyright © 2018年 橋本 智広. All rights reserved.
//

import UIKit

class InsertViewController: UIViewController {
    private let txtName = UITextField()
    private let txtPhoneNumber = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ナビゲーションバーの高さ
        var naviVarHeight: CGFloat = 0
        if let naviCtr = self.navigationController {
            naviVarHeight = naviCtr.navigationBar.frame.size.height
        }
        //ステータスバーの高さ
        let stateVarHeight = UIApplication.shared.statusBarFrame.size.height
        
        self.view.backgroundColor = UIColor.white
        let lblName = UILabel()
        lblName.text = "名前"
        lblName.textColor = UIColor.black
        lblName.backgroundColor = UIColor.red
        lblName.textAlignment = .center
        self.view.addSubview(lblName)
        lblName.translatesAutoresizingMaskIntoConstraints = false
        lblName.topAnchor.constraint(equalTo: self.view.topAnchor, constant: naviVarHeight + stateVarHeight + 30).isActive = true
        lblName.bottomAnchor.constraint(equalTo: self.view.topAnchor, constant: naviVarHeight + stateVarHeight + 80).isActive = true
        lblName.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        lblName.rightAnchor.constraint(equalTo: self.view.leftAnchor, constant: 80).isActive = true

        txtName.borderStyle = .bezel
        txtName.placeholder = "名前を入力してください"
        txtName.clearButtonMode = .whileEditing
        self.view.addSubview(txtName)
        txtName.translatesAutoresizingMaskIntoConstraints = false
        txtName.topAnchor.constraint(equalTo: lblName.topAnchor, constant: 0).isActive = true
        txtName.bottomAnchor.constraint(equalTo: lblName.bottomAnchor, constant: 0).isActive = true
        txtName.leftAnchor.constraint(equalTo: lblName.rightAnchor, constant: 30).isActive = true
        txtName.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true

        
        let lblPhoneNumber = UILabel()
        lblPhoneNumber.text = "電話"
        lblPhoneNumber.textColor = UIColor.black
        lblPhoneNumber.backgroundColor = UIColor.red
        lblPhoneNumber.textAlignment = .center
        self.view.addSubview(lblPhoneNumber)
        lblPhoneNumber.translatesAutoresizingMaskIntoConstraints = false
        lblPhoneNumber.topAnchor.constraint(equalTo: lblName.bottomAnchor, constant: 20).isActive = true
        lblPhoneNumber.bottomAnchor.constraint(equalTo: lblName.bottomAnchor, constant: 70).isActive = true
        lblPhoneNumber.leftAnchor.constraint(equalTo: lblName.leftAnchor, constant: 0).isActive = true
        lblPhoneNumber.rightAnchor.constraint(equalTo: lblName.rightAnchor, constant: 0).isActive = true

        
        txtPhoneNumber.borderStyle = .bezel
        txtPhoneNumber.placeholder = "電話番号を入力してください"
        txtPhoneNumber.clearButtonMode = .whileEditing
        self.view.addSubview(txtPhoneNumber)
        txtPhoneNumber.translatesAutoresizingMaskIntoConstraints = false
        txtPhoneNumber.topAnchor.constraint(equalTo: lblPhoneNumber.topAnchor, constant: 0).isActive = true
        txtPhoneNumber.bottomAnchor.constraint(equalTo: lblPhoneNumber.bottomAnchor, constant: 0).isActive = true
        txtPhoneNumber.leftAnchor.constraint(equalTo: lblPhoneNumber.rightAnchor, constant: 30).isActive = true
        txtPhoneNumber.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        
        
        let btn = UIButton()
        btn.layer.borderColor = UIColor.blue.cgColor
        btn.backgroundColor = UIColor.blue
        btn.setTitle("登録", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        self.view.addSubview(btn)
        btn.addTarget(self, action: #selector(btnTouchUpInside(sender:)), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.topAnchor.constraint(equalTo: lblPhoneNumber.bottomAnchor, constant: 30).isActive = true
        btn.bottomAnchor.constraint(equalTo: lblPhoneNumber.bottomAnchor, constant: 90).isActive = true
        btn.leftAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -125).isActive = true
        btn.rightAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 125).isActive = true

        //ナビゲーションバー
        self.title = "新規連絡先"
        let btnCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(btnDoCancel(sender:)))
        self.navigationItem.leftBarButtonItem = btnCancel
        
        
    }

    
    @objc func btnTouchUpInside(sender: UIButton) {
        guard let strName = txtName.text else {
            self.alertWarning(str: "名前を入力してください")
            return
            
        }
        if strName == "" {
            self.alertWarning(str: "名前を入力してください")
            return
        }
        
        guard let strPhoneNumber = txtPhoneNumber.text else {
            self.alertWarning(str: "電話番号を入力してください")
            return
            
        }
        if strPhoneNumber == "" {
            self.alertWarning(str: "電話番号を入力してください")
            return
        }
        
        MyHttp.requestInsert(name: strName, phoneNumber: strPhoneNumber) { (isSuccess) in
            if isSuccess == false  {
                self.alertWarning(str: "登録に失敗しました")
                return
            }
            self.alertComfirm(str: "登録しました") {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @objc func btnDoCancel(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //TextField以外をタッチしたら
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //非表示にする。
        self.view.endEditing(true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("didReceiveMemoryWarning")
    }
}
