//
//  ViewController.swift
//  AlamofireSampleApp
//
//  Created by 橋本 智広 on 2018/03/06.
//  Copyright © 2018年 橋本 智広. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON





class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    public var data: [(Int, String, String)] = []
    private var myTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //self.navigationItem.title = "myPhoneBook"
        
        //self.view.backgroundColor = UIColor.white
        
        var isWait = true
        
        MyHttp.requestList { (isSuccess, resultsData) in
            if isSuccess == false {
                print("Error")
                return
            }

            guard let resData = resultsData else { return }

            guard let jsonArray = resData.jsonArray else { return }

            
            for jsn in jsonArray {
                let seq = jsn["SEQ"].intValue
                let name = jsn["Name"].stringValue
                let phoneNumber = jsn["PhoneNumber"].stringValue
                self.data.append((seq, name, phoneNumber))
            }
            //print("data: \(self.data)")
            isWait = false
        }
 
        while isWait && RunLoop.current.run(mode: .defaultRunLoopMode, before: Date(timeIntervalSinceNow: 0.1)){}
        
        // Cell名の登録をおこなう.
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")

        // DataSourceを自身に設定する.
        myTableView.dataSource = self

        // Delegateを自身に設定する.
        myTableView.delegate = self

        // Viewに追加する.
        self.view.addSubview(myTableView)
        myTableView.rowHeight = 50
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        myTableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        myTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        myTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        myTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        
        //ナビゲーションバー
        self.title = "myAddressBook"
        let btnAdd = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(btnTouchUpInside(sender:)))
        self.navigationItem.rightBarButtonItem = btnAdd
    }
    
    //セルが押された時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("Num: \(indexPath.row)")
        //print("Value: \(data[indexPath.row])")
        
        let (seq, name, phoneNumber) = data[indexPath.row]
        let addressView = AddressViewController()
        let editView = EditViewController()
        
        editView.seq = seq
        addressView.seq = seq
        addressView.name = name
        addressView.phoneNumber.append(phoneNumber)
        self.navigationController?.pushViewController(addressView, animated: true)
    }
    
    //セルの総数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    //Cellの値を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        //let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        //cell.frame.size = CGSize(width: 500, height: 50)
        //cell.backgroundColor = UIColor.brown
        let lbl = UILabel()
        //lbl.backgroundColor = UIColor.blue
        cell.addSubview(lbl)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.topAnchor.constraint(equalTo: cell.topAnchor, constant: 0).isActive = true
        lbl.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: 0).isActive = true
        lbl.leftAnchor.constraint(equalTo: cell.leftAnchor, constant: 15).isActive = true
        lbl.rightAnchor.constraint(equalTo: cell.rightAnchor, constant: 0).isActive = true
        let (_, name, _) = data[indexPath.row]
        lbl.text = name
        //lbl.text = "\(data[indexPath.row])"
        //cell.textLabel!.text = "\(data[indexPath.row])"
        return cell
    }
    
    //連絡先追加
    @objc internal func btnTouchUpInside(sender: UIButton) {
        let insView = InsertViewController()
        insView.closureReload = {
            
            MyHttp.requestList { (isSuccess, resultsData) in
                if isSuccess == false {
                    print("Error")
                    return
                }
                
                guard let resData = resultsData else { return }
                
                guard let jsonArray = resData.jsonArray else { return }
                //print(self.data.count)
                for jsn in jsonArray {
                    let seq = jsn["SEQ"].intValue
                    let name = jsn["Name"].stringValue
                    let phoneNumber = jsn["PhoneNumber"].stringValue
                    self.data.append((seq, name, phoneNumber))
                }
                print(self.data)
                self.myTableView.reloadData()
            }
        }
        //insViewにナビゲーションバーを表示させておく
        let naviCtr = UINavigationController(rootViewController: insView)
        insView.modalTransitionStyle = .coverVertical
        self.present(naviCtr, animated: true, completion: nil)
        //self.navigationController?.pushViewController(insView, animated: true)
    }
    
    //遷移から戻ってきた時にセルの選択を解除
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        if let indexPathForSelectedRow = myTableView.indexPathForSelectedRow {
            myTableView.deselectRow(at: indexPathForSelectedRow, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("didReceiveMemoryWarning")
    }


}

