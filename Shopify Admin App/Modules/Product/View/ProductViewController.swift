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
    @IBOutlet weak var productImgSrc: UITextField!
    
    
    var productTypeRes: String?
    var productVendorRes: String?
    var productCustomCellectionRes: Int?
    
    var productId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productViewModel = ProductViewModel()
        
        productTypeMenu()
        productVendorMenuMethod()
        productCustomCellectionMenuMethod()
        
        
        // NetworkService.deleteFromApi(endPoint: EndPoints.updateProduct(id: 8155363213602))
    }
    
    
    //add product title, vender(smart collection), varint(price), productType(floaty button filter)
    func addProductInfo(title: String, details: String, vendor: String,productType: String, price: String, imgSrc: String, collectionId: Int){
        
        let params: [String: Any] = [
            "product":[
                "title": "\(vendor) | \(title)",
                "body_html": details,
                "vendor": vendor,
                "product_type": productType,
                "status": "draft",
                "published": false,
                "variants": [
                    [
                        "option1": "Black",
                        "price": price,
                        "inventory_management": "shopify"
                    ]
                ]
            ]
        ]
        
        productViewModel.bindResultToProduct = {[weak self] in
            print((self?.productViewModel.allProduct.product.id) ?? 0)
            self?.productId = (self?.productViewModel.allProduct.product.id) ?? 0
            
            self?.addProductImg(productId: self?.productId ?? 0, imgSrc: imgSrc)
            
            self?.addProductToCustomCollection(productId: self?.productId ?? 0, collectionId: collectionId)
            
            self?.editProductState(productId: self?.productId ?? 0)
        }
        productViewModel.createProduct(params: params)
    }
    
    // add product image
    func addProductImg(productId: Int, imgSrc: String){
        let params: [String : Any] = [
            "image":[
                //                8151494459682  8154944569634 8154956955938 "https://images.pexels.com/photos/90946/pexels-photo-90946.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
                "product_id": productId,
                "src": imgSrc
            ]
        ]
        productViewModel.bindImg = {[weak self] in
            print((self?.productViewModel.productImg.image.src) ?? "")
        }
        productViewModel.createProductImg(params: params, id: productId)
    }
    
    //add product to custom collection
    func addProductToCustomCollection(productId: Int, collectionId: Int){
        let params: [String : Any] = [
            "collect":[
                "product_id": productId,
                "collection_id": collectionId
            ]
        ]
        productViewModel.bindProductCustomCollection = {[weak self] in
            print((self?.productViewModel.productCustomCollection.collect.collection_id) ?? "")
        }
        
        productViewModel.addProdoctCustomCollection(params: params)
    }
    
    // edit product state
    func editProductState(productId: Int){
        let params: [String: Any] = [
            "product":[
                "status": "active",
                "published": true
            ]
        ]
        productViewModel.editProduct(params: params, id: productId)
    }
    
    
    @IBAction func addProductButtonAction(_ sender: Any) {
        let title = productTitleTF.text ?? ""
        let details = productDetailsTF.text ?? ""
        let vendor = productVendorRes ?? ""
        let productType = productTypeRes ?? ""
        let price = productPriceTF.text ?? ""
        let imgSrc = productImgSrc.text ?? ""
        let collectionId = productCustomCellectionRes ?? 0
        
        addProductInfo(title: title, details: details, vendor: vendor, productType: productType, price: price, imgSrc: imgSrc, collectionId: collectionId)
    }
    
    
    func productTypeMenu(){
        productmenu.menu = UIMenu(title: "Product Type", options: .singleSelection, children: [
            UIAction(title: "ACCESSORIES",handler: { [weak self] action in
                self?.productTypeRes = "ACCESSORIES"
            }),
            UIAction(title: "T-SHIRTS", handler: { [weak self] action in
                self?.productTypeRes = "T-SHIRTS"
            }),
            UIAction(title: "SHOES",handler: { [weak self] action in
                self?.productTypeRes = "SHOES"
            })
        ])
        
        productmenu.showsMenuAsPrimaryAction = true
        productmenu.changesSelectionAsPrimaryAction = true
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
            }),
            UIAction(title: "TEST",handler: { [weak self] action in
                self?.productVendorRes = "TEST"
            })
            
        ])
        
        productVendorMenu.showsMenuAsPrimaryAction = true
        productVendorMenu.changesSelectionAsPrimaryAction = true
    }
    
    
    func productCustomCellectionMenuMethod(){
        
        productCustomCellectionMenu.menu = UIMenu(title: "Product Custom Collection", options: .singleSelection, children: [
            UIAction(title: "Home page",handler: { [weak self] action in
                self?.productCustomCellectionRes = 437933703458
            }),
            UIAction(title: "KID", handler: { [weak self] action in
                self?.productCustomCellectionRes = 437934620962
            }),
            UIAction(title: "MEN",handler: { [weak self] action in
                self?.productCustomCellectionRes = 437934555426
            }),
            UIAction(title: "TEAM",handler: { [weak self] action in
                self?.productCustomCellectionRes = 438126182690
            }),
            UIAction(title: "SALE",handler: { [weak self] action in
                self?.productCustomCellectionRes = 437934653730
            }),
            UIAction(title: "WOMEN",handler: { [weak self] action in
                self?.productCustomCellectionRes = 437934588194
            })
            
        ])
        
        productCustomCellectionMenu.showsMenuAsPrimaryAction = true
        productCustomCellectionMenu.changesSelectionAsPrimaryAction = true
        //       // productVendor.preferredBehavioralStyle = .automatic
    }
}
