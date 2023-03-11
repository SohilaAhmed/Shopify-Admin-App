//
//  couponPriceRuleModel.swift
//  Shopify Admin App
//
//  Created by Sohila on 10/03/2023.
//

import Foundation

struct CouponPriceRuleModel: Codable {
    let price_rule: PriceRule
}

struct AllCouponPriceRuleModel: Codable {
    let price_rules: [PriceRule]
}

// MARK: - PriceRule
struct PriceRule: Codable {
    let id: Int?
    let value, value_type: String?
//    value_type, value, customer_selection, target_type: String
//    let target_selection, allocation_method: String
//    let once_per_customer: Bool
    let title: String?
}
