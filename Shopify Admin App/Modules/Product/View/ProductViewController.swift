//
//  ProductViewController.swift
//  Shopify Admin App
//
//  Created by Sohila on 06/03/2023.
//

import UIKit

class ProductViewController: UIViewController {
    
    var productViewModel : ProductViewModel!
    
    @IBOutlet weak var productTitleTF: UITextField!
    @IBOutlet weak var productDetailsTF: UITextField!
    @IBOutlet weak var productPriceTF: UITextField!
    @IBOutlet weak var productVendorMenu: UIButton!
    @IBOutlet weak var productmenu: UIButton!
    @IBOutlet weak var productCustomCellectionMenu: UIButton!
    
    var productTypeRes: String?
    var productVendorRes: String?
    var productCustomCellectionRes: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productViewModel = ProductViewModel()
        //        let url = "https://b24cfe7f0d5cba8ddb793790aaefa12a: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@mad-ios-2.myshopify.com/admin/api/2023-01/products/8149693366562.json"
        //        NetworkService.loadDataFromURL(urlStr: url) { [weak self] (data: ProductInfo?, error) in
        //            print(data?.product.title)
        //        }
        
        productTypeMenu()
        productVendorMenuMethod()
        productCustomCellectionMenuMethod()
//        addProductInfo(title: productTitleTF.text ?? "", details: productDetailsTF.text ?? "", vendor: productVendorRes ?? "", productType: productTypeRes ?? "", price: productPriceTF.text ?? "")
        
    }
    
    
    
    func addProductInfo(title: String, details: String, vendor: String,productType: String, price: String){
        let params: [String : Any] = [
            "product":[
                "title": title,
                "body_html": details,
                "vendor": vendor,
                "product_type": productType,
                "status": "draft",
                "published": false,
                "variants": [
                    "option1": "Black",
                    "price": price
                ]
            ]
        ]
        
        productViewModel.bindResultToProduct = {[weak self] in
            
            print((self?.productViewModel.allProduct.product.id) ?? 0)
            
        }
        
        productViewModel.createProduct(params: params)
    }
    
    
    func productTypeMenu(){
        productmenu.menu = UIMenu(title: "Product Type", options: .singleSelection, children: [
            UIAction(title: "ACCESSORIES",handler: { [weak self] action in
                self?.productTypeRes = "ACCESSORIES"
                print("1")
            }),
            UIAction(title: "T-SHIRTS", handler: { [weak self] action in
                self?.productTypeRes = "T-SHIRTS"
                print("2")
            }),
            UIAction(title: "SHOES",handler: { [weak self] action in
                self?.productTypeRes = "SHOES"
            })
        ])
        
        productmenu.showsMenuAsPrimaryAction = true
        productmenu.changesSelectionAsPrimaryAction = true
     //   productType.preferredBehavioralStyle = .automatic
    }
    
    func productVendorMenuMethod(){
        productVendorMenu.menu = UIMenu(title: "Product Vendor", options: .singleSelection, children: [
            UIAction(title: "ADIDAS",handler: { [weak self] action in
                self?.productVendorRes = "ADIDAS"
            }),
            UIAction(title: "ASICS TIGER", handler: { [weak self] action in
                self?.productVendorRes = "ASICS TIGER"
            }),
            UIAction(title: "CONVERSE",handler: { [weak self] action in
                self?.productVendorRes = "CONVERSE"
            }),
            UIAction(title: "DR MARTENS",handler: { [weak self] action in
                self?.productVendorRes = "DR MARTENS"
            }),
            UIAction(title: "FLEX FIT",handler: { [weak self] action in
                self?.productVendorRes = "FLEX FIT"
            }),
            UIAction(title: "HERSCHEL",handler: { [weak self] action in
                self?.productVendorRes = "HERSCHEL"
            }),
            UIAction(title: "NIKE",handler: { [weak self] action in
                self?.productVendorRes = "NIKE"
            }),
            UIAction(title: "PALLADIUM",handler: { [weak self] action in
                self?.productVendorRes = "PALLADIUM"
            }),
            UIAction(title: "PUMA",handler: { [weak self] action in
                self?.productVendorRes = "PUMA"
            }),
            UIAction(title: "SUPRA",handler: { [weak self] action in
                self?.productVendorRes = "SUPRA"
            }),
            UIAction(title: "TIMBERLAND",handler: { [weak self] action in
                self?.productVendorRes = "TIMBERLAND"
            }),
            UIAction(title: "VANS",handler: { [weak self] action in
                self?.productVendorRes = "VANS"
            })

        ])

        productVendorMenu.showsMenuAsPrimaryAction = true
        productVendorMenu.changesSelectionAsPrimaryAction = true
//       // productVendor.preferredBehavioralStyle = .automatic
    }

    
    func productCustomCellectionMenuMethod(){
        
        productCustomCellectionMenu.menu = UIMenu(title: "Product Custom Collection", options: .singleSelection, children: [
            UIAction(title: "Home page",handler: { [weak self] action in
                self?.productCustomCellectionRes = "Home page"
            }),
            UIAction(title: "KID", handler: { [weak self] action in
                self?.productCustomCellectionRes = "KID"
            }),
            UIAction(title: "MEN",handler: { [weak self] action in
                self?.productCustomCellectionRes = "MEN"
            }),
            UIAction(title: "TEAM",handler: { [weak self] action in
                self?.productCustomCellectionRes = "TEAM"
            }),
            UIAction(title: "SALE",handler: { [weak self] action in
                self?.productCustomCellectionRes = "SALE"
            }),
            UIAction(title: "WOMEN",handler: { [weak self] action in
                self?.productCustomCellectionRes = "WOMEN"
            })

        ])

        productCustomCellectionMenu.showsMenuAsPrimaryAction = true
        productCustomCellectionMenu.changesSelectionAsPrimaryAction = true
//       // productVendor.preferredBehavioralStyle = .automatic
    }
}
