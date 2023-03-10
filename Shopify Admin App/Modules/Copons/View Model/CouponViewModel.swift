//
//  couponsViewModel.swift
//  Shopify Admin App
//
//  Created by Sohila on 10/03/2023.
//

import Foundation

class CouponsViewModel{
    
    var bindCouponPriceRule: (() -> ()) = {}
    
    var newCouponPriceRule : CouponPriceRuleModel!{
        didSet{
            bindCouponPriceRule()
        }
    }
    
    func createCouponPriceRule(params: [String: Any]){
        NetworkService.postApi(endPoint: EndPoints.couponPriceRule, params: params) { [weak self] (data: CouponPriceRuleModel?, error) in
            guard let responsData = data else{ return}
            self?.newCouponPriceRule = responsData
            print(self?.newCouponPriceRule.price_rule ?? 0)
        }
    }
    
    func createCouponDiscountCode(params: [String: Any], couponPriceRuleId: Int){
        NetworkService.postApi(endPoint: EndPoints.couponDiscountCode(id: couponPriceRuleId), params: params) {  (data: CouponDiscountCodeModel?, error) in
            guard let responsData = data else{ return}
 
            print(responsData.discount_code.code ?? "")
        }
    }
    
    
}
