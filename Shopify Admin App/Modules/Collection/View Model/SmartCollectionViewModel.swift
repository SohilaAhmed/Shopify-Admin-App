//
//  SmartCollectionViewModel.swift
//  Shopify Admin App
//
//  Created by Sohila on 11/03/2023.
//

import Foundation

class SmartCollectionViewModel{
    
    var bindCreateSmartCollection: (() -> ()) = {}
    
    var bindEditSmartCollection: (() -> ()) = {}
    
    var newSmartCollection: SmartCollectionModel!{
        didSet{
            bindCreateSmartCollection()
        }
    }
    
    var editSmartCollection: SmartCollectionModel!{
        didSet{
            bindEditSmartCollection()
        }
    }
    
    func createNewSmartCollection(params: [String: Any]){
        NetworkService.postApi(endPoint: EndPoints.createSmartCollection, params: params) { [weak self] (data: SmartCollectionModel?, error) in
            guard let responsData = data else{ return}
            self?.newSmartCollection = responsData
            print(self?.newSmartCollection.smart_collection.title ?? "")
        }
    }
    
    func editSmartCollection(params: [String: Any], smartCollectionId: Int){
        NetworkService.updateApi(endPoint: EndPoints.editSmartCollection(id: smartCollectionId), params: params) { [weak self] (data: SmartCollectionModel?, error) in
            guard let responsData = data else{ return }
            self?.editSmartCollection = responsData
            print(self?.editSmartCollection.smart_collection.title ?? "")
        }
    }
    
    
}
