//
//  EndPoints.swift
//  Shopify Admin App
//
//  Created by Sohila on 06/03/2023.
//

import Foundation
enum EndPoints {
    case createNewProduct
    case createProductImg(id: Int)
    case createProductVariants(id: Int)
    case addProductToCustomCollection
    case updateProduct(id: Int)
 
    
    var path:String{
        switch self {
            case .createNewProduct:
                return "products.json"
            case .createProductImg(id: let productId):
                return "products/\(productId)/images.json"
            case .createProductVariants(id: let productId):
                return "products/\(productId)/variants.json"
            case .addProductToCustomCollection:
                return "collects.json"
            case .updateProduct(id: let productId):
                return "products/\(productId).json"
        }
    }
    
}
