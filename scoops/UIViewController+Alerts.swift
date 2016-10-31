//
//  UIViewController+Alerts.swift
//  scoops
//
//  Created by fran on 30/10/16.
//  Copyright © 2016 Francisco Navarro Aguilar. All rights reserved.
//

import Foundation

extension UIViewController {
    
    func presentInfoAlert(title t:String, message m: String,completion c:  ((UIAlertAction)->(Void))?){
        
        let alertVC = UIAlertController(title: t, message: m, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: c)
        alertVC.addAction(ok)
        self.present(alertVC, animated: true, completion: nil)
    }
}
