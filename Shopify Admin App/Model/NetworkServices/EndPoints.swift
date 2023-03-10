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
    case couponPriceRule
    case couponDiscountCode(id: Int)
    case editPriceRule(id: Int)
    case createSmartCollection
    case createCustomCollection
    case editSmartCollection(id: Int)
    case editCustomCollection(id: Int)
    
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
            case .couponPriceRule:
                return "price_rules.json"
            case .couponDiscountCode(id: let priceRuleId):
                return "price_rules/\(priceRuleId)/discount_codes.json"
            case .editPriceRule(id: let priceRuleId):
                return "price_rules/\(priceRuleId).json"
            case .createSmartCollection:
                return "smart_collections.json"
            case .createCustomCollection:
                return "custom_collections.json"
            case .editCustomCollection(id: let customCollectionId):
                return "custom_collections/\(customCollectionId).json"
            case .editSmartCollection(id: let smartCollectionId):
                return "smart_collections/\(smartCollectionId).json"
        }
    }
    
}
