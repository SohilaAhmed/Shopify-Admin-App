//
//  SmartCollectionModel.swift
//  Shopify Admin App
//
//  Created by Sohila on 11/03/2023.
//

import Foundation

struct SmartCollectionModel: Codable {
    let smart_collection: SmartCollection
 
}

struct AllSmartCollectionModel: Codable {
    let smart_collections: [SmartCollection]
 
}

// MARK: - SmartCollection
struct SmartCollection: Codable {
    let id: Int
    let title, sort_order: String
//    let rules: [Rule]
//    let published_scope : String
//    let image: Img
}

// MARK: - Image
struct Img: Codable {
    let src: String
}

// MARK: - Rule
struct Rule: Codable {
    let column, relation, condition: String
}
