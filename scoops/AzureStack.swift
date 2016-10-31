//
//  AzureStack.swift
//  scoops
//
//  Created by fran on 30/10/16.
//  Copyright © 2016 Francisco Navarro Aguilar. All rights reserved.
//

import Foundation

public struct AzureStack{
    
    let client : MSClient = MSClient(applicationURLString: "https://kc-mbaas.azurewebsites.net")
    let sas = "sv=2015-04-05&ss=bfqt&srt=sco&sp=rwdlacup&se=2020-10-31T04:40:31Z&st=2016-10-30T20:40:31Z&spr=https&sig=TG32pFHwFGngz0FzdUHYRpQTYqr3UqjcJsFRQr5Q5D8%3D"
    
    let accountName = "labboot3storages"
    let blobContainer = "boot3"
    
    let account : AZSCloudStorageAccount

    init() {
        let credentials = AZSStorageCredentials(sasToken: sas, accountName: accountName)
        account = try! AZSCloudStorageAccount(credentials: credentials, useHttps: true)
    }
    
    func download(blob b:String, _ completion:  @escaping (Any)->()) {
        let container = account.getBlobClient().containerReference(fromName: blobContainer)
        
        let blob = container.blockBlobReference(fromName: b)
        
        blob.downloadToData { (error, data) in
            if let _ = error{
                print(error)
                return
            }
            completion(data)
        }
    }
    
    func readAllItemsInTable(_ completion:@escaping (_ result:Any)->()) {
        
        let tableMS = client.table(withName: "News")
        var data: [Dictionary<String, AnyObject>]? = []
        
        tableMS.read { (results, error) in
            if let _ = error {
                print(error)
                return
            }
            if let items = results {
                
                for item in items.items! {
                    data?.append(item as! [String:AnyObject])
                }
                
                completion(data)
            }
        }
    }
    
    func insertInto(table t: String, theObject o: [AnyHashable : Any], completion c :MSItemBlock?){
        
        let imageData = UIImageJPEGRepresentation(o["image"] as! UIImage, 0.85)
        
        let urlBlob = UUID().uuidString
        self.uploadBlob(data: imageData!, nameFile: urlBlob)
        
        
        client.table(withName: t).insert([
            "title":o["title"] as! String,
            "author": o["author"]as! String,
            "image": urlBlob,
            "text": o["text"] as! String,
            "visible": o["visible"] as! Bool], completion: c)
        
    }
    
    func uploadBlob(data:Data, nameFile: String){
        let client = account.getBlobClient()
        
        let container = client?.containerReference(fromName: blobContainer)
        
        container?.createContainerIfNotExists(with: .container, requestOptions: nil, operationContext: nil, completionHandler: { (error, status) in
            
            if let _ = error{
                print(error)
                return
            }
            let blob = container?.blockBlobReference(fromName: nameFile )
            blob?.upload(from: data) { (e) in
                if e != nil{
                    print(error)
                    return
                }
            }
        })
    }
}
