//
//  WritersTableViewController.swift
//  scoops
//
//  Created by fran on 26/10/16.
//  Copyright © 2016 Francisco Navarro Aguilar. All rights reserved.
//

import UIKit

class WritersTableViewController: UITableViewController {

    
    var model : [NewEntry] = []
    var azureStack = AzureStack()
    
    
    @IBAction internal func logout(_ sender: AnyObject) {
        
        let main = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = main.instantiateViewController(withIdentifier: "Main")
            
        present(vc, animated: true, completion: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadNews()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadNews()
      
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return model.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "cellnews", for: indexPath) as! NewsTableViewCell
        
        var new = model[indexPath.row]

        cell.textNew.text = new.title
        
        azureStack.download(blob: new.imageURL) { (data) in
            new.blob = data as? Data
            cell.ImageNew.image = UIImage(data: data as! Data)
        }
        
        cell.changeSituacionValue.tag = indexPath.row
        //cell.changeSituacionValue.addTarget(self, action: #selector(self.buttonClicked(sender:)), for: UIControlEvents.touchUpInside)
        
        
        if new.visible {
            cell.situacionNew.text = "Publicada"
        }else{
            cell.situacionNew.text = "No publicada"
        }
        
        
        return cell
       
    }
 
    func loadNews(){
        
        azureStack.readAllItemsInTable{ (data: Any) in
 
            for new in data as! [Dictionary<String, AnyObject>] {

                let newItem = NewEntry(title: new["title"] as! String, text: new["text"] as! String, author: new["author"] as! String, imageURL: new["image"] as! String, visible: new["visible"] as! Bool)
                self.model.append(newItem)
                
            }
            
            self.tableView.reloadData()
            
        }

        
    }
    
}
