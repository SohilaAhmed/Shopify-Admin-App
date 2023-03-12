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
    
    var flagEditAdd: Int? // 0 if add, 1 if edit
    
    var customCollectionId: Int?
    var customCollectionTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customCollectionViewModel = CustomCollectionViewModel()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(flagEditAdd == 1){ //edit
           // print(customCollectionId ?? 0)

            customCollectionNameTF.text = customCollectionTitle
        }
 
        
    }
 
    
    @IBAction func doneCustomCollection(_ sender: Any) {
        let title = customCollectionNameTF.text ?? ""
       
        if(flagEditAdd == 1){ //edit
            editCustomCollection(customCollectionId: customCollectionId ?? 0, title: title)
        }else{ //add
            if(title.isEmpty ){
                self.showAlert(title: "⚠️", message: "Fields can't be empty!!")
            }else{
                createCustomCollection(title: title)
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    

    func createCustomCollection(title: String){
        let params = [
            "custom_collection":[
                "title": title
            ]
        ]
        
        customCollectionViewModel.bindCreateCustomCollection = {[weak self] in
        //    print((self?.customCollectionViewModel.customCollectionNew.custom_collection.title) ?? "")
        }
        
        customCollectionViewModel.createNewCustomCollection(params: params)
    }
    
    func editCustomCollection(customCollectionId: Int, title: String){
        let params = [
            "custom_collection":[
                "id": customCollectionId,
                "title": title 
            ]
        ]
        
        customCollectionViewModel.bindEditCustomCollection = { [weak self] in
    //        print(self?.customCollectionViewModel.editCustomCollection.custom_collection.title ?? "")
        }
        
        customCollectionViewModel.editCustomCollection(params: params, customCollectionId: customCollectionId)
        
        
    }
    func showAlert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
        
    }
    
}
