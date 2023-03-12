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
    @IBOutlet weak var couponCollectionTargetLabel: UILabel!
    @IBOutlet weak var couponCodeLabel: UILabel!
    
    
    
    var couponsViewModel: CouponsViewModel!
    
    var couponValueTypeMenuRes: String = "fixed_amount"
    var couponCollectionTargetMenuCollectionIdRes: [Int] = []
    var couponCollectionTargetMenuTargetRes: String = "all"
    
    var flagEditAdd: Int? // 0 if add, 1 if edit
    var priceRuleid: Int?
    var priceRuleValue: String?
    var priceRuleTitle: String?
    var priceRuleValueType: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        couponsViewModel = CouponsViewModel()
        
        
        couponCollectionTargetMenuDetails()

       // print(flagEditAdd ?? 7)

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if flagEditAdd == 1{ //edit
            couponCollectionTargetMenu.isHidden = true
            couponCodeTF.isHidden = true
            couponCollectionTargetLabel.isHidden = true
            couponCodeLabel.isHidden = true
           // print(priceRuleid!)
            if(priceRuleValueType == "fixed_amount"){
                couponValueTypeMenuRes = "fixed_amount"
                couponValueTypeMenuDetails(fixedState: .on, percentageState: .off)
            }else{
                couponValueTypeMenuRes = "percentage"
                couponValueTypeMenuDetails(fixedState: .off, percentageState: .on)
            }
            
            couponTitleTF.text = priceRuleTitle ?? ""
            couponValueTF.text = priceRuleValue ?? ""
            
        }else{ //add
            couponValueTypeMenuDetails(fixedState: .on, percentageState: .off)
        }
    }
    
    
    @IBAction func addCouponAction(_ sender: Any) {
        let title = couponTitleTF.text ?? ""
        let targetSelection = couponCollectionTargetMenuTargetRes
        let valueType = couponValueTypeMenuRes
        let value = couponValueTF.text ?? ""
        let collectionId = couponCollectionTargetMenuCollectionIdRes
        let couponCode = couponCodeTF.text ?? ""
 
        if flagEditAdd == 1{ //edit
         //   print(priceRuleid!)
            editCouponPriceRule(priceRuleId: priceRuleid!, title: title, valueType: valueType, value: value)
            self.navigationController?.popViewController(animated: true)
        }else{ //add
            if(title.isEmpty || value.isEmpty || couponCode.isEmpty){
                self.showAlert(title: "⚠️", message: "Fields can't be empty!!")
            }else{
                addNewcouponPriceRule(title: title, targetSelection: targetSelection, valueType: valueType, value: value, collectionId: collectionId, couponCode: couponCode)
            }
        } 
    }
    
    
    
    
    func addNewcouponPriceRule(title: String, targetSelection: String, valueType: String, value: String, collectionId: [Int], couponCode: String){
        let params: [String: Any] = [
            "price_rule":[
                "title": title,
                "target_type": "line_item",
                "target_selection": targetSelection,
                "allocation_method": "across",
                "value_type": valueType,
                "value": "-\(value)",
                "customer_selection": "all",
                "entitled_collection_ids": collectionId,
                "starts_at": "2023-03-10T12:00:00-04:00",
                "ends_at": "2023-04-31T12:00:00-04:00"
            ]
        ]
        
        couponsViewModel.bindCouponPriceRule = { [weak self] in
            let priceRuleId = self?.couponsViewModel.newCouponPriceRule.price_rule.id ?? 0
          //  print(self?.couponsViewModel.newCouponPriceRule.price_rule.id ?? 0)
            
            self?.addNewCouponDiscountCode(couponPriceRuleId: priceRuleId, couponCode: couponCode)
            DispatchQueue.main.async {
                self?.navigationController?.popViewController(animated: true)
            }
        }
        
        couponsViewModel.createCouponPriceRule(params: params)
    }
    
    func addNewCouponDiscountCode(couponPriceRuleId: Int, couponCode: String){
        let params: [String: Any] = [
            "discount_code":[
                "code": couponCode
                ]
        ]
        couponsViewModel.createCouponDiscountCode(params: params, couponPriceRuleId: couponPriceRuleId)
    }
    
    
    func editCouponPriceRule(priceRuleId: Int, title: String, valueType: String, value: String){
        let params: [String: Any] = [
            "price_rule":[
                "id": priceRuleId,
                "value_type": valueType,
                "value": value,
                "title": title
                ]
        ]
        couponsViewModel.editCouponPriceRule(priceRuleId: priceRuleId, params: params)
    }
    
    
    
    func couponValueTypeMenuDetails(fixedState: UIMenuElement.State, percentageState: UIMenuElement.State){
        couponValueTypeMenu.menu = UIMenu(title: "Value Type", options: .singleSelection, children: [
            UIAction(title: "Fixed Amount",state: fixedState,handler: { [weak self] action in
                self?.couponValueTypeMenuRes = "fixed_amount"
            }),
            UIAction(title: "Percentage",state: percentageState,handler: { [weak self] action in
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
    
    func showAlert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
        
    }
     
}
