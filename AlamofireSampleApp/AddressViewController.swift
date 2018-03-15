//
//  AddressViewController.swift
//  AlamofireSampleApp
//
//  Created by 橋本 智広 on 2018/03/13.
//  Copyright © 2018年 橋本 智広. All rights reserved.
//

import UIKit

class AddressViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private var tv = UITableView()
    private let lblName = UILabel()
    private var itemPhoneNumber: [String] = []
    
    //プロパティ
    var name: String {
        get {
            if let value = lblName.text {
                return value
            }
            return ""
        }
        set(value) {
            lblName.text = value
        }
    }
    
    var phoneNumber: [String] {
        get {
//            if let value = itemPhoneNumber {
//                return value
//            }
//            return [""]
            return itemPhoneNumber
        }
        set(value) {
            itemPhoneNumber = value
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        //lblName.backgroundColor = UIColor.lightGray
        lblName.font = UIFont.systemFont(ofSize: 30)
        lblName.adjustsFontSizeToFitWidth = true
        lblName.textAlignment = .center
        lblName.textColor = UIColor.blue
        self.view.addSubview(lblName)
        lblName.translatesAutoresizingMaskIntoConstraints = false
        lblName.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150).isActive = true
        lblName.bottomAnchor.constraint(equalTo: self.view.topAnchor, constant: 200).isActive = true
        lblName.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 5).isActive = true
        lblName.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -5).isActive = true
        
        let lblAddress = UILabel()
        lblAddress.text = "電話番号"
        //lblAddress.backgroundColor = UIColor.blue
        self.view.addSubview(lblAddress)
        lblAddress.translatesAutoresizingMaskIntoConstraints = false
        lblAddress.topAnchor.constraint(equalTo: lblName.bottomAnchor, constant: 50).isActive = true
        lblAddress.bottomAnchor.constraint(equalTo: lblName.bottomAnchor, constant: 100).isActive = true
        lblAddress.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        lblAddress.rightAnchor.constraint(equalTo: self.view.leftAnchor, constant: 110).isActive = true
        
//        self.view.addSubview(lblPhoneNumber)
//        lblPhoneNumber.translatesAutoresizingMaskIntoConstraints = false
//        lblPhoneNumber.topAnchor.constraint(equalTo: lblAddress.topAnchor, constant: 10).isActive = true
//        lblPhoneNumber.bottomAnchor.constraint(equalTo: lblAddress.topAnchor, constant: 60).isActive = true
//        lblPhoneNumber.leftAnchor.constraint(equalTo: lblAddress.leftAnchor, constant: 0).isActive = true
//        lblPhoneNumber.rightAnchor.constraint(equalTo: lblAddress.leftAnchor, constant: 100).isActive = true
        
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        
        // DataSourceを自身に設定する.
        tv.dataSource = self
        
        // Delegateを自身に設定する.
        tv.delegate = self
        
        // Viewに追加する.
        self.view.addSubview(tv)
        tv.rowHeight = 50
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.topAnchor.constraint(equalTo: lblAddress.bottomAnchor, constant: 0).isActive = true
        tv.bottomAnchor.constraint(equalTo: lblAddress.bottomAnchor, constant: 50).isActive = true
        tv.leftAnchor.constraint(equalTo: lblAddress.leftAnchor, constant: 0).isActive = true
        tv.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        
        let btnDoCall = UIButton()
        btnDoCall.backgroundColor = UIColor.red
        btnDoCall.setTitle("発信", for: .normal)
        btnDoCall.setTitleColor(.white, for: .normal)
        btnDoCall.layer.cornerRadius = 10.0
        self.view.addSubview(btnDoCall)
        btnDoCall.addTarget(self, action: #selector(DoCall), for: .touchUpInside)
        btnDoCall.translatesAutoresizingMaskIntoConstraints = false
        btnDoCall.topAnchor.constraint(equalTo: tv.bottomAnchor, constant: 10).isActive = true
        btnDoCall.bottomAnchor.constraint(equalTo: tv.bottomAnchor, constant: 50).isActive = true
        btnDoCall.leftAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -30).isActive = true
        btnDoCall.rightAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 30).isActive = true

        if let name = lblName.text {
            self.navigationItem.title = "\(name)の連絡先"
        }
        let btnEdit = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(btnDoEdit(sender:)))
        self.navigationItem.rightBarButtonItem = btnEdit
        
       // self.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .automatic

    }
    
    @objc func DoCall() {
        let url = NSURL(string: "tel://\(itemPhoneNumber[itemPhoneNumber.count - 1])")!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url as URL)
        } else {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    @objc func btnDoEdit(sender: UIButton) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemPhoneNumber.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let lbl = UILabel()
        cell.addSubview(lbl)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.topAnchor.constraint(equalTo: cell.topAnchor, constant: 0).isActive = true
        lbl.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: 0).isActive = true
        lbl.leftAnchor.constraint(equalTo: cell.leftAnchor, constant: 10).isActive = true
        lbl.rightAnchor.constraint(equalTo: cell.rightAnchor, constant: 0).isActive = true
        let phoneNumber = itemPhoneNumber[indexPath.row]
        lbl.text = phoneNumber
        return cell
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("didReceiveMemoryWarning")
    }
}
