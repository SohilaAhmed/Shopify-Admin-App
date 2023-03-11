//
//  SmartCollectionViewController.swift
//  Shopify Admin App
//
//  Created by Sohila on 11/03/2023.
//

import UIKit

class SmartCollectionViewController: UIViewController {

    @IBOutlet weak var smartCollectionNameTF: UITextField!
    @IBOutlet weak var smartCollectionImgTF: UITextField!
    
    var smartCollectionViewModel: SmartCollectionViewModel!
    
    var flagEditAdd: Int? // 0 if add, 1 if edit
    
    override func viewDidLoad() {
        super.viewDidLoad()

        smartCollectionViewModel = SmartCollectionViewModel()
 
    }
  
    
    @IBAction func doneSmartCollection(_ sender: Any) {
        let title = smartCollectionNameTF.text ?? ""
        let imgLink = smartCollectionImgTF.text ?? ""
        createSmartCollection(title: title, src: imgLink)
    }
    
    
    func createSmartCollection(title: String, src: String){
        let params = [
            "smart_collection":[
                "title": title,
                "rules": [
                    [
                        "column": "title",
                        "relation": "contains",
                        "condition": title
                    ]
                ],
                "image": [
                    "src": src
                ]
            ]
        ]
        
        smartCollectionViewModel.bindCreateSmartCollection = {[weak self] in
            print((self?.smartCollectionViewModel.newSmartCollection.smart_collection.title) ?? "")
        }
        
        smartCollectionViewModel.createNewSmartCollection(params: params)
    }

}
