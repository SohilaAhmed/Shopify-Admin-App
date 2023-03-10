//
//  couponDiscountCodeModel.swift
//  Shopify Admin App
//
//  Created by Sohila on 10/03/2023.
//

import Foundation


struct CouponDiscountCodeModel: Codable {
    let discount_code: DiscountCode
}
 
struct DiscountCode: Codable {
    let id, price_rule_id, usage_count: Int?
    let code: String?
}
