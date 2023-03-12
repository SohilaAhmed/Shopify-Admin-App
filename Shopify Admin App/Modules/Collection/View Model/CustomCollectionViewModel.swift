//
//  CustomCollectionViewModel.swift
//  Shopify Admin App
//
//  Created by Sohila on 11/03/2023.
//

import Foundation

class CustomCollectionViewModel{
    
    var bindCreateCustomCollection: (() -> ()) = {}
    
    var bindEditCustomCollection: (() -> ()) = {}
    
    var customCollectionNew: CustomCollectionModel!{
        didSet{
            bindCreateCustomCollection()
        }
    }
    
    var editCustomCollection: CustomCollectionModel!{
        didSet{
            bindEditCustomCollection()
        }
    }
    
    func createNewCustomCollection(params: [String: Any]){
        NetworkService.postApi(endPoint: EndPoints.createCustomCollection, params: params) { [weak self] (data: CustomCollectionModel?, error) in
            guard let responsData = data else{ return}
            self?.customCollectionNew = responsData
           // print(self?.customCollectionNew.custom_collection.title ?? "")
        }
    }
    
    func editCustomCollection(params: [String: Any], customCollectionId: Int){
        NetworkService.updateApi(endPoint: EndPoints.editCustomCollection(id: customCollectionId), params: params) { [weak self] (data: CustomCollectionModel?, error) in
            guard let responsData = data else{ return }
            self?.editCustomCollection = responsData
          //  print(self?.editCustomCollection.custom_collection.title ?? "")
        }
    }
    
    
}
