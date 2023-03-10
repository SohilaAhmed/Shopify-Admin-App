//
//  couponsViewController.swift
//  Shopify Admin App
//
//  Created by Sohila on 10/03/2023.
//

import UIKit

class CouponsViewController: UIViewController {

    @IBOutlet weak var couponValueTypeMenu: UIButton!
    @IBOutlet weak var couponCollectionTargetMenu: UIButton!
    @IBOutlet weak var couponTitleTF: UITextField!
    @IBOutlet weak var couponValueTF: UITextField!
    @IBOutlet weak var couponCodeTF: UITextField!
    
    
    var couponsViewModel: CouponsViewModel!
    
    var couponValueTypeMenuRes: String?
    var couponCollectionTargetMenuCollectionIdRes: [Int]?
    var couponCollectionTargetMenuTargetRes: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        couponsViewModel = CouponsViewModel()
        
        couponValueTypeMenuDetails()
        couponCollectionTargetMenuDetails()


        
    }
    
    
    
    @IBAction func addCouponAction(_ sender: Any) {
        let title = couponTitleTF.text ?? ""
        let targetSelection = couponCollectionTargetMenuTargetRes ?? ""
        let valueType = couponValueTypeMenuRes ?? ""
        let value = couponValueTF.text ?? ""
        let collectionId = couponCollectionTargetMenuCollectionIdRes ?? []
        let couponCode = couponCodeTF.text ?? ""
        addNewcouponPriceRule(title: title, targetSelection: targetSelection, valueType: valueType, value: value, collectionId: collectionId, couponCode: couponCode)
    }
    
    
    
    
    func addNewcouponPriceRule(title: String, targetSelection: String, valueType: String, value: String, collectionId: [Int], couponCode: String){
        var params: [String: Any] = [
            "price_rule":[
                "title": title,
                "target_type": "line_item",
                "target_selection": targetSelection,
                "allocation_method": "across",
                "value_type": valueType,
                "value": "-\(value)",
                "customer_selection": "all",
                "entitled_collection_ids": collectionId,
//                    [
//                    438126182690 //team
//                    437934555426 //MEN
//                ],
                "starts_at": "2023-03-10T12:00:00-04:00",
                "ends_at": "2023-04-31T12:00:00-04:00"
            ]
        ]
        
        couponsViewModel.bindCouponPriceRule = { [weak self] in
            var priceRuleId = self?.couponsViewModel.newCouponPriceRule.price_rule.id ?? 0
            print(self?.couponsViewModel.newCouponPriceRule.price_rule.id ?? 0)
            
            self?.addNewCouponDiscountCode(couponPriceRuleId: priceRuleId, couponCode: couponCode)
        }
        
        couponsViewModel.createCouponPriceRule(params: params)
    }
    
    func addNewCouponDiscountCode(couponPriceRuleId: Int, couponCode: String){
        var params: [String: Any] = [
            "discount_code":[
                "code": couponCode
                ]
        ]
        //1389305561378
        couponsViewModel.createCouponDiscountCode(params: params, couponPriceRuleId: couponPriceRuleId)
    }
    
    
    
    func couponValueTypeMenuDetails(){
        couponValueTypeMenu.menu = UIMenu(title: "Value Type", options: .singleSelection, children: [
            UIAction(title: "Fixed Amount",handler: { [weak self] action in
                self?.couponValueTypeMenuRes = "fixed_amount"
            }),
            UIAction(title: "Percentage", handler: { [weak self] action in
                self?.couponValueTypeMenuRes = "percentage"
            })
        ])
        
        couponValueTypeMenu.showsMenuAsPrimaryAction = true
        couponValueTypeMenu.changesSelectionAsPrimaryAction = true
    }
    
    
    
    
    
    func couponCollectionTargetMenuDetails(){
        
        couponCollectionTargetMenu.menu = UIMenu(title: "Product Custom Collection", options: .singleSelection, children: [
            UIAction(title: "All",handler: { [weak self] action in
                self?.couponCollectionTargetMenuCollectionIdRes = []
                self?.couponCollectionTargetMenuTargetRes = "all"
            }),
            UIAction(title: "Home page",handler: { [weak self] action in
                self?.couponCollectionTargetMenuCollectionIdRes = [437933703458]
                self?.couponCollectionTargetMenuTargetRes = "entitled"
            }),
            UIAction(title: "KID", handler: { [weak self] action in
                self?.couponCollectionTargetMenuCollectionIdRes = [437934620962]
                self?.couponCollectionTargetMenuTargetRes = "entitled"
            }),
            UIAction(title: "MEN",handler: { [weak self] action in
                self?.couponCollectionTargetMenuCollectionIdRes = [437934555426]
                self?.couponCollectionTargetMenuTargetRes = "entitled"
            }),
            UIAction(title: "TEAM",handler: { [weak self] action in
                self?.couponCollectionTargetMenuCollectionIdRes = [438126182690]
                self?.couponCollectionTargetMenuTargetRes = "entitled"
            }),
            UIAction(title: "SALE",handler: { [weak self] action in
                self?.couponCollectionTargetMenuCollectionIdRes = [437934653730]
                self?.couponCollectionTargetMenuTargetRes = "entitled"
            }),
            UIAction(title: "WOMEN",handler: { [weak self] action in
                self?.couponCollectionTargetMenuCollectionIdRes = [437934588194]
                self?.couponCollectionTargetMenuTargetRes = "entitled"
            })
            
        ])
        
        couponCollectionTargetMenu.showsMenuAsPrimaryAction = true
        couponCollectionTargetMenu.changesSelectionAsPrimaryAction = true
        //       // productVendor.preferredBehavioralStyle = .automatic
    }
     
}
