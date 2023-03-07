//
//  ProductImgModel.swift
//  Shopify Admin App
//
//  Created by Sohila on 06/03/2023.
//

import Foundation
struct ProductImgModel: Codable {
    let image: ProductImage
}


struct ProductImage: Codable {
    let id, productID, position: Int
    let width, height: Int
    let src: String
    

    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case position
        case width, height, src
        
    }
}
