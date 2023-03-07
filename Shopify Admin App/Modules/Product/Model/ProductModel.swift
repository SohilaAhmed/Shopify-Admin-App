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
    let id: Int
    let title, bodyHTML, vendor, productType, status : String?
//    let createdAt: Date
//    let handle: String
//    let updatedAt, publishedAt: Date
//    let templateSuffix: String
//    let status, publishedScope, tags, adminGraphqlAPIID: String
    let variants: [Variant]
//    let options: [Option]
    let images: [Image]
//    let image: Image

    enum CodingKeys: String, CodingKey {
        case id, title
        case bodyHTML = "body_html"
        case vendor, status
        case productType = "product_type"
//        case createdAt = "created_at"
//        case handle
//        case updatedAt = "updated_at"
//        case publishedAt = "published_at"
//        case templateSuffix = "template_suffix"
//        case status
//        case publishedScope = "published_scope"
//        case tags
//        case adminGraphqlAPIID = "admin_graphql_api_id"
        case variants, images
//        , image, options
    }
}

// MARK: - Image
struct Image: Codable {
    let id, productID, position: Int
    let alt: String
    let width, height: Int
    let src: String
    

    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case position
        case alt, width, height, src
        
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
