//
//  ProductCustomCollectionModel.swift
//  Shopify Admin App
//
//  Created by Sohila on 08/03/2023.
//

import Foundation
struct ProductCustomCollectionModel: Codable {
    let collect: CustomCollection
}

// MARK: - Collect
struct CustomCollection: Codable {
    let id, collection_id, product_id: Int
    let position: Int
    let sort_value: String

   
}
