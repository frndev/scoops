//
//  NewEntry.swift
//  scoops
//
//  Created by fran on 30/10/16.
//  Copyright © 2016 Francisco Navarro Aguilar. All rights reserved.
//

import Foundation

public struct NewEntry {
    
    var title:String
    var text:String
    var blob:Data?
    var author:String
    var imageURL:String
    var visible:Bool
 
    
    init(title:String, text:String, author:String, imageURL:String, visible:Bool) {
        
        self.title = title
        self.text = text
        self.author = author
        self.imageURL = imageURL
        self.visible = visible
    
    }
    
}
