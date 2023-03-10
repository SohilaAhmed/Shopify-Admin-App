//
//  couponsViewController.swift
//  Shopify Admin App
//
//  Created by Sohila on 10/03/2023.
//

import UIKit

class CouponsViewController: UIViewController {

    
    var couponsViewModel: CouponsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        couponsViewModel = CouponsViewModel()
        
//        addNewcouponPriceRule()

        
    }
    
    
    
    func addNewcouponPriceRule(){
        var params: [String: Any] = [
            "price_rule":[
                "title": "20OFFCOLLECTION",
                "target_type": "line_item",
                "target_selection": "entitled",
                "allocation_method": "across",
                "value_type": "percentage",
                "value": "-20.0",
                "customer_selection": "all",
                "entitled_collection_ids": [
                    438126182690 //team
//                    437934555426 //MEN
                ],
                "starts_at": "200023-01-01T00:00:00-00:00"
            ]
        ]
        
        couponsViewModel.bindCouponPriceRule = { [weak self] in
            var priceRuleId = self?.couponsViewModel.newCouponPriceRule.price_rule.id ?? 0
            print(self?.couponsViewModel.newCouponPriceRule.price_rule.id ?? 0)
            
            self?.addNewCouponDiscountCode(couponPriceRuleId: priceRuleId)
        }
        
        couponsViewModel.createCouponPriceRule(params: params)
    }
    
    func addNewCouponDiscountCode(couponPriceRuleId: Int){
        var params: [String: Any] = [
            "discount_code":[
                "code": "20OFF"
                ]
        ]
        //1389305561378
        couponsViewModel.createCouponDiscountCode(params: params, couponPriceRuleId: couponPriceRuleId)
    }
     
}
