//
//  ProductModel.swift
//  Shopify Admin App
//
//  Created by Sohila on 06/03/2023.
//

import Foundation


struct AllProductInfo: Codable {
    var products: [Product]
}

struct ProductInfo: Codable {
    var product: Product
}



// MARK: - Product
struct Product: Codable {
    var id: Int?
    var title, body_html, vendor, product_type, status : String?
//    let createdAt: Date
//    let handle: String
//    let updatedAt, publishedAt: Date
//    let templateSuffix: String
//    let status, publishedScope, tags, adminGraphqlAPIID: String
    var variants: [Variant]?
//    let options: [Option]
    var images: [Image]?
    var image: Image?

}

// MARK: - Image
struct Image: Codable {
    var id, productID, position: Int
    var width, height: Int
    var src: String
    

    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case position
        case width, height, src
        
    }
}



// MARK: - Variant
struct Variant: Codable {
    var id, productID: Int
    var title, price: String
    

    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case title, price
        
    }
}
