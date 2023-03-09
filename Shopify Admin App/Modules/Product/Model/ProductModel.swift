//
//  ProductModel.swift
//  Shopify Admin App
//
//  Created by Sohila on 06/03/2023.
//

import Foundation

struct ProductInfo: Codable {
    let product: Product
}

// MARK: - Product
struct Product: Codable {
    let id: Int?
    let title, body_html, vendor, product_type, status : String?
//    let createdAt: Date
//    let handle: String
//    let updatedAt, publishedAt: Date
//    let templateSuffix: String
//    let status, publishedScope, tags, adminGraphqlAPIID: String
    let variants: [Variant]
//    let options: [Option]
    let images: [Image]
//    let image: Image

}

// MARK: - Image
struct Image: Codable {
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



// MARK: - Variant
struct Variant: Codable {
    let id, productID: Int
    let title, price: String
    

    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case title, price
        
    }
}
