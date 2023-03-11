//
//  SmartCollectionViewModel.swift
//  Shopify Admin App
//
//  Created by Sohila on 11/03/2023.
//

import Foundation

class SmartCollectionViewModel{
    
    var bindCreateSmartCollection: (() -> ()) = {}
    
    var newSmartCollection: SmartCollectionModel!{
        didSet{
            bindCreateSmartCollection()
        }
    }
    
    func createNewSmartCollection(params: [String: Any]){
        NetworkService.postApi(endPoint: EndPoints.createSmartCollection, params: params) { [weak self] (data: SmartCollectionModel?, error) in
            guard let responsData = data else{ return}
            self?.newSmartCollection = responsData
            print(self?.newSmartCollection.smart_collection.title)
        }
    }
    
    
}
