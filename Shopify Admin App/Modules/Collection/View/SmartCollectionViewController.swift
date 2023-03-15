//
//  SmartCollectionViewController.swift
//  Shopify Admin App
//
//  Created by Sohila on 11/03/2023.
//

import UIKit

class SmartCollectionViewController: UIViewController {

//    @IBOutlet weak var smartCollectionNameTF: UITextField!
//    @IBOutlet weak var smartCollectionImgTF: UITextField!
    @IBOutlet weak var smartCollectionNameTF: UITextField!
    @IBOutlet weak var smartCollectionImgTF: UITextField!
    
    var smartCollectionViewModel: SmartCollectionViewModel!
    
    var flagEditAdd: Int? // 0 if add, 1 if edit
    var smartCollectionId: Int?
    var smartCollectionTitle: String?
    var smartCollectionImg: BrandImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        smartCollectionViewModel = SmartCollectionViewModel()
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if flagEditAdd == 1{
            print("__________________")
            print(smartCollectionId ?? 0)
            smartCollectionNameTF.text = smartCollectionTitle
            smartCollectionImgTF.text = smartCollectionImg?.src
        }
    }
  
    @IBAction func doneSmartCollectionEdit(_ sender: Any) {
        let title = smartCollectionNameTF.text ?? ""
        let imgLink = smartCollectionImgTF.text ?? "https://www.pexels.com/photo/a-smartwatch-and-a-laptop-6192117/"
        if flagEditAdd == 1{
            smartCollectionImg?.src = smartCollectionImgTF.text ?? "https://www.pexels.com/photo/a-smartwatch-and-a-laptop-6192117/"
            editSmartCollection(smartCollectionId: smartCollectionId ?? 0, title: title, imgLink: smartCollectionImg!)
        }else{ //add
            if(title.isEmpty || imgLink.isEmpty ){
                self.showAlert(title: "⚠️", message: "Fields can't be empty!!")
            }else{
                createSmartCollection(title: title, src: imgLink)
            }
        }
        self.navigationController?.popViewController(animated: true)
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
    
    func editSmartCollection(smartCollectionId: Int, title: String, imgLink: BrandImage){
        let params = [
            "smart_collection":[
                "id": smartCollectionId,
                "title": title,
//                "rules": [
//                    [
//                        "column": "title",
//                        "relation": "contains",
//                        "condition": title
//                    ]
//                ],
                "image": [
                    "src": imgLink.src
                ]
            ]
        ]
        
        smartCollectionViewModel.bindEditSmartCollection = { [weak self] in
            print(self?.smartCollectionViewModel.editSmartCollection.smart_collection.title ?? "")
        }
        
        smartCollectionViewModel.editSmartCollection(params: params, smartCollectionId: smartCollectionId)
        
        
    }
    func showAlert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
        
    }

}
