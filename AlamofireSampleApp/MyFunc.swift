//
//  MyFunc.swift
//  AlamofireSampleApp
//
//  Created by 橋本 智広 on 2018/03/11.
//  Copyright © 2018年 橋本 智広. All rights reserved.
//

import UIKit
import SwiftyJSON

extension Data {
    func toJsonArray() -> [JSON]? {
        
        if let json = try? JSON(data: self) {
            return json.array
        }
        return nil
    }
    var jsonArray: [JSON]? {
        if let json = try? JSON(data: self) {
            return json.array
        }
        return nil
    }
}

extension UIViewController {
    func alertWarning(str: String) {
        MyFunc.alertWarning(self, str: str)
    }
    func alertComfirm(str: String) {
        MyFunc.alertComfirm(self, str: str)
    }
    func alertWarning(str: String, completion: (() -> Void)? ) {
        MyFunc.alertWarning(self, str: str, completion: completion)
    }
    func alertComfirm(str: String, completion: (() -> Void)? ) {
        MyFunc.alertComfirm(self, str: str, completion: completion)
    }
}


class MyFunc {
    public static func alertComfirm(_ owner: UIViewController, str: String, completion: (() -> Void)?) {
        let alertCon = UIAlertController(title: "確認", message: str, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        }
        alertCon.addAction(okAction)
        owner.present(alertCon, animated: true, completion: nil)
    }
    
    public static func alertComfirm(_ owner: UIViewController, str: String) {
        alertComfirm(owner, str: str, completion: nil)
    }
    
    public static func alertWarning(_ owner: UIViewController, str: String, completion: (() -> Void)?) {
        let alertCon = UIAlertController(title: "注意！", message: str, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        }
        alertCon.addAction(okAction)
        owner.present(alertCon, animated: true, completion: nil)
    }
    
    public static func alertWarning(_ owner: UIViewController, str: String) {
        alertWarning(owner, str: str, completion: nil)
    }

}
