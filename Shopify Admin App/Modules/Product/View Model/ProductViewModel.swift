//
//  ProductViewModel.swift
//  Shopify Admin App
//
//  Created by Sohila on 06/03/2023.
//

import Foundation

class ProductViewModel{
    
    var bindResultToProduct: (() -> ()) = {}
    
    var allProduct : ProductInfo!{
        didSet{
            bindResultToProduct()
            
        }
    }

    func createProduct(params: [String: Any]){
        NetworkService.createProduct(endPoint: EndPoints.createNewProduct, params: params) { [weak self] (data: ProductInfo?, error) in
            guard let responsData = data else{ return}
            self?.allProduct = responsData
            print(self?.allProduct.product)
            
        }
    }
    
}
