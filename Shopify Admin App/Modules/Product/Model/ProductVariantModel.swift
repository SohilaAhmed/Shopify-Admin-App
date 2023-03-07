//
//  ProductVariantModel.swift
//  Shopify Admin App
//
//  Created by Sohila on 06/03/2023.
//

import Foundation

struct ProductVariantModel: Codable {
    let variant: VariantProduct
}

struct VariantProduct: Codable {
    let id, productID: Int
    let title, price: String
    

    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case title, price
        
    }
}
