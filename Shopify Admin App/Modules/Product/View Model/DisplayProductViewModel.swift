//
//  DisplayProductViewModel.swift
//  Product
//
//  Created by Zienab on 10/03/2023.
//

import Foundation
class DisplayProductViewModel {
    
    var bindResultToDisplayProducts: (( ) -> Void)?
    
    var allProducts : AllProductInfo!{
        didSet{
            bindResultToDisplayProducts?()
            
        }
    }
    
    func getAllProducts (){
        NetworkService.getApi(endPoint: EndPoints.createNewProduct ) { [weak self] (data : AllProductInfo? , error ) in
            guard let data = data else{ return}
            self?.allProducts = data
            print(data)
        }
    }
    
    func deleteProduct(productId: Int){
        NetworkService.deleteFromApi(endPoint: EndPoints.updateProduct(id: productId))
    }
}
