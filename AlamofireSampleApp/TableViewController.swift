//
//  TableViewController.swift
//  AlamofireSampleApp
//
//  Created by 橋本 智広 on 2018/03/11.
//  Copyright © 2018年 橋本 智広. All rights reserved.
//

//import UIKit
//
//class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//
//    public var data: [(String, String)] = []
//
//    private var tv = UITableView()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        //self.title = "連絡先"
//
//        //self.view.backgroundColor = UIColor.cyan
//
//        // Cell名の登録をおこなう.
//        tv.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
//
//        // DataSourceを自身に設定する.
//        tv.dataSource = self
//
//        // Delegateを自身に設定する.
//        tv.delegate = self
//
//        // Viewに追加する.
//        self.view.addSubview(tv)
//        tv.rowHeight = 50
//        tv.translatesAutoresizingMaskIntoConstraints = false
//        tv.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
//        tv.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
//        tv.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
//        tv.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
//
//
//    }
//
//    //Cellが選択された際に呼び出される
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("Num: \(indexPath.row)")
//        print("Value: \(data[indexPath.row])")
//    }
//
//    //セルの総数を返す
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return data.count
//    }
//
//    //Cellの値を設定する
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell()
//        //cell.frame.size = CGSize(width: 500, height: 50)
//        //cell.backgroundColor = UIColor.brown
//        let lbl = UILabel()
//        //lbl.backgroundColor = UIColor.blue
//        cell.addSubview(lbl)
//        lbl.translatesAutoresizingMaskIntoConstraints = false
//        lbl.topAnchor.constraint(equalTo: cell.topAnchor, constant: 0).isActive = true
//        lbl.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: 0).isActive = true
//        lbl.leftAnchor.constraint(equalTo: cell.leftAnchor, constant: 0).isActive = true
//        lbl.rightAnchor.constraint(equalTo: cell.rightAnchor, constant: 0).isActive = true
//        let (name, _) = data[indexPath.row]
//
//        lbl.text = name
//        return cell
//
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        print("didReceiveMemoryWarning")
//    }
//}


