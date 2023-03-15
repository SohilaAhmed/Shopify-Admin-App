//
//  DisplayCollectionsViewModel.swift
//  Product
//
//  Created by Zienab on 10/03/2023.
//

import Foundation
class DisplayCollectionsViewModel {
    
    var bindResultToDisplayBrands: (( ) -> Void)?
    
    var bindCustomCollection: (() -> ()) = {}
    
    var allBrands : AllSmartCollectionModel!{
        didSet{
            bindResultToDisplayBrands?()
            
        }
    }
    
    var allCustomCollection : AllCustomCollectionModel!{
        didSet{
            bindCustomCollection()
        }
    }
    
    func getAllBrands(){
        NetworkService.getApi(endPoint: EndPoints.createSmartCollection) { [weak self] (data : AllSmartCollectionModel? , error ) in
            guard let data = data else{ return}
            self?.allBrands = data
            //print(data)
        }
    }
    
    func getAllCustomCollection(){
        NetworkService.getApi(endPoint: EndPoints.createCustomCollection) { [weak self] (data : AllCustomCollectionModel? , error ) in
            guard let data = data else{ return}
            self?.allCustomCollection = data
//            print(data)
        }
    }
    
    func deleteFromSmartCollection(smartCollectionId: Int){
        NetworkService.deleteFromApi(endPoint: EndPoints.editSmartCollection(id: smartCollectionId))
    }
    
    func deleteFromCustomCollection(customCollectionId: Int){
        NetworkService.deleteFromApi(endPoint: EndPoints.editCustomCollection(id: customCollectionId))
    }
}
