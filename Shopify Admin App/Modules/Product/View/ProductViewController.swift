//
//  ProductViewController.swift
//  Shopify Admin App
//
//  Created by Sohila on 06/03/2023.
//

import UIKit

class ProductViewController: UIViewController {

    var productViewModel : ProductViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        productViewModel = ProductViewModel()
//        let url = "https://b24cfe7f0d5cba8ddb793790aaefa12a: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@mad-ios-2.myshopify.com/admin/api/2023-01/products/8149693366562.json"
//        NetworkService.loadDataFromURL(urlStr: url) { [weak self] (data: ProductInfo?, error) in
//            print(data?.product.title)
//        }
        addProductInfo()
        
        
    }
    
    
    
    func addProductInfo(){
        let params: [String : Any] = [
            "product":[
                "title": "hadeer",
                "body_html": "Good hadeer!",
                "vendor": "hadeer",
                "product_type": "hadeer",
                "status": "draft"
            ]
        ]
        
        productViewModel.bindResultToProduct = {[weak self] in
            
            print((self?.productViewModel.allProduct.product.id) ?? 0)
            
        }
        
        productViewModel.createProduct(params: params)
    }


}
