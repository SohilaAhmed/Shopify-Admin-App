//
//  CustomCollectionViewModel.swift
//  Shopify Admin App
//
//  Created by Sohila on 11/03/2023.
//

import Foundation

class CustomCollectionViewModel{
    
    var bindCreateCustomCollection: (() -> ()) = {}
    
    var customCollectionNew: CustomCollectionModel!{
        didSet{
            bindCreateCustomCollection()
        }
    }
    
    func createNewCustomCollection(params: [String: Any]){
        NetworkService.postApi(endPoint: EndPoints.createCustomCollection, params: params) { [weak self] (data: CustomCollectionModel?, error) in
            guard let responsData = data else{ return}
            self?.customCollectionNew = responsData
            print(self?.customCollectionNew.custom_collection.title)
        }
    }
    
    
}
