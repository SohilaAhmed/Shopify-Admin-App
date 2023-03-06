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

        let params: [String : Any] = [
            "product":[
                "title": "sohila",
                "body_html": "Good sohila!",
                "vendor": "sohila",
                "product_type": "sohila",
                "status": "active"
            ]
        ]
    
        let url = "https://b24cfe7f0d5cba8ddb793790aaefa12a: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@mad-ios-2.myshopify.com/admin/api/2023-01/products.json"
        
        productViewModel = ProductViewModel()
        
        productViewModel.bindResultToProduct = {[weak self] in
            
            print((self?.productViewModel.allProduct.product.id) ?? 0)
            
        }
        
        productViewModel.createProduct(urlStr: url, params: params)
        
    }
    


}
