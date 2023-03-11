//
//  CustomCollectionVC.swift
//  Shopify Admin App
//
//  Created by Sohila on 11/03/2023.
//

import UIKit

class CustomCollectionVC: UIViewController {

    @IBOutlet weak var customCollectionNameTF: UITextField!
    
    var customCollectionViewModel: CustomCollectionViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customCollectionViewModel = CustomCollectionViewModel()

    }
 
    
    @IBAction func doneCustomCollection(_ sender: Any) {
        let title = customCollectionNameTF.text ?? ""
        
        createSmartCollection(title: title)
        
    }
    

    func createSmartCollection(title: String){
        let params = [
            "custom_collection":[
                "title": title
            ]
        ]
        
        customCollectionViewModel.bindCreateCustomCollection = {[weak self] in
            print((self?.customCollectionViewModel.newCustomCollection.custom_collection.title) ?? "")
        }
        
        customCollectionViewModel.createNewCustomCollection(params: params)
    }
    
}
