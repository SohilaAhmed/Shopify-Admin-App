//
//  CouponsViewModel.swift
//  Shopify Admin App
//
//  Created by Sohila on 10/03/2023.
//

import Foundation

class CouponsViewModel{
    
    var bindCouponPriceRule: (() -> ()) = {}
    
    var bindEditCouponPriceRule: (() -> ()) = {}
    
    var newCouponPriceRule: CouponPriceRuleModel!{
        didSet{
            bindCouponPriceRule()
        }
    }
    
    var editCouponPriceRule: CouponPriceRuleModel!{
        didSet{
            bindEditCouponPriceRule()
        }
    }
    
    func createCouponPriceRule(params: [String: Any]){
        NetworkService.postApi(endPoint: EndPoints.couponPriceRule, params: params) { [weak self] (data: CouponPriceRuleModel?, error) in
            guard let responsData = data else{ return}
            self?.newCouponPriceRule = responsData
         //   print(self?.newCouponPriceRule.price_rule ?? 0)
        }
    }
    
    func createCouponDiscountCode(params: [String: Any], couponPriceRuleId: Int){
        NetworkService.postApi(endPoint: EndPoints.couponDiscountCode(id: couponPriceRuleId), params: params) {(data: CouponDiscountCodeModel?, error) in
            guard let responsData = data else{ return}
 
          //  print(responsData.discount_code.code ?? "")
        }
    }
    
    func editCouponPriceRule(priceRuleId: Int, params: [String: Any]){
        NetworkService.updateApi(endPoint: EndPoints.editPriceRule(id: priceRuleId), params: params) { [weak self] (data: CouponPriceRuleModel?, error)  in
            guard let responsData = data else{ return}
            self?.editCouponPriceRule = responsData
          //  print(self?.editCouponPriceRule.price_rule ?? 0)
        }
    }
    
    
}
