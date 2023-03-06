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
//    let variants: [Variant]
//    let options: [Option]
//    let images: [Image]
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
//        case variants, options, images, image
    }
}

// MARK: - Image
struct Image: Codable {
    let id, productID, position: Int
    let createdAt, updatedAt: Date
    let alt: String
    let width, height: Int
    let src: String
    let variantIDS: [String]
    let adminGraphqlAPIID: String

    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case position
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case alt, width, height, src
        case variantIDS = "variant_ids"
        case adminGraphqlAPIID = "admin_graphql_api_id"
    }
}

// MARK: - Option
struct Option: Codable {
    let id, productID: Int
    let name: String
    let position: Int
    let values: [String]

    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case name, position, values
    }
}

// MARK: - Variant
struct Variant: Codable {
    let id, productID: Int
    let title, price, sku: String
    let position: Int
    let inventoryPolicy: String
    let compareAtPrice: String
    let fulfillmentService, inventoryManagement, option1, option2: String
    let option3: String
    let createdAt, updatedAt: Date
    let taxable: Bool
    let barcode: String
    let grams: Int
    let imageID: String
    let weight: Int
    let weightUnit: String
    let inventoryItemID, inventoryQuantity, oldInventoryQuantity: Int
    let requiresShipping: Bool
    let adminGraphqlAPIID: String

    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case title, price, sku, position
        case inventoryPolicy = "inventory_policy"
        case compareAtPrice = "compare_at_price"
        case fulfillmentService = "fulfillment_service"
        case inventoryManagement = "inventory_management"
        case option1, option2, option3
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case taxable, barcode, grams
        case imageID = "image_id"
        case weight
        case weightUnit = "weight_unit"
        case inventoryItemID = "inventory_item_id"
        case inventoryQuantity = "inventory_quantity"
        case oldInventoryQuantity = "old_inventory_quantity"
        case requiresShipping = "requires_shipping"
        case adminGraphqlAPIID = "admin_graphql_api_id"
    }
}
