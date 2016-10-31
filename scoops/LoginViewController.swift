//
//  LoginViewController.swift
//  scoops
//
//  Created by fran on 26/10/16.
//  Copyright © 2016 Francisco Navarro Aguilar. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBAction func readerLogin(_ sender: AnyObject) {
        
        let reader = UIStoryboard(name: "Readers", bundle: Bundle.main)
        let vc = reader.instantiateViewController(withIdentifier: "Readers")
        
        present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func writerLogin(_ sender: AnyObject) {
        
        let writer = UIStoryboard(name: "Writers", bundle: Bundle.main)
        let vc = writer.instantiateViewController(withIdentifier: "Writers")
    
        present(vc, animated: true, completion: nil)
        
    }

}
