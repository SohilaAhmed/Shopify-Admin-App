//
//  PresentAllCouponViewModel.swift
//  Shopify Admin App
//
//  Created by Sohila on 10/03/2023.
//

import Foundation


class PresentAllCouponViewModel{
    
    var bindAllCouponPriceRule: (() -> ()) = {}
    
    var allCouponPriceRule : AllCouponPriceRuleModel!{
        didSet{
            bindAllCouponPriceRule()
        }
    }
    
    func retrieveAllCoupon(){
        NetworkService.getApi(endPoint: EndPoints.couponPriceRule) { [weak self] (data: AllCouponPriceRuleModel?, error) in
            guard let responsData = data else{ return}
            self?.allCouponPriceRule = responsData
          //  print(self?.allCouponPriceRule.price_rules[0].title ?? 0)
        }
    }
    
    
    
    func deleteCoupon(priceRuleId: Int){
        NetworkService.deleteFromApi(endPoint: EndPoints.editPriceRule(id: priceRuleId))
    }
    
    
}
