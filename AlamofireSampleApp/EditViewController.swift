//
//  EditViewController.swift
//  AlamofireSampleApp
//
//  Created by 橋本 智広 on 2018/03/14.
//  Copyright © 2018年 橋本 智広. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    
    //プロパティ
    var seq: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        let btnDoRemove = UIButton()
        btnDoRemove.backgroundColor = UIColor.red
        btnDoRemove.setTitle("連絡先を削除する", for: .normal)
        btnDoRemove.setTitleColor(.white, for: .normal)
        btnDoRemove.layer.cornerRadius = 10.0
        self.view.addSubview(btnDoRemove)
        btnDoRemove.addTarget(self, action: #selector(doRemove), for: .touchUpInside)
        btnDoRemove.translatesAutoresizingMaskIntoConstraints = false
        btnDoRemove.topAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -20).isActive = true
        btnDoRemove.bottomAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 20).isActive = true
        btnDoRemove.leftAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -100).isActive = true
        btnDoRemove.rightAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 100).isActive = true

    }
    
    @objc func doRemove() {
        MyHttp.requestDelete(seq: seq) { (isSuccess) in
            if isSuccess == false  {
                self.alertWarning(str: "削除に失敗しました")
                return
            }
            self.alertComfirm(str: "削除しました") {                
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("didReceiveMemoryWarning")
    }
}
