////
////  ProductDetailsViewController.swift
////  Shopify Admin App
////
////  Created by Sohila on 06/03/2023.
////
//
//import UIKit
//
//class ProductDetailsViewController: UIViewController {
//    
//    var productDetailsViewModel : ProductDetailsViewModel!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        productDetailsViewModel = ProductDetailsViewModel()
//        addProductImg()
//        addProductVariant()
//        // Do any additional setup after loading the view.
//    }
//    
//    
//    func addProductImg(){
//        let params: [String : Any] = [
//            "image":[
//                "product_id": 8151494459682,
//                "src": "https://images.pexels.com/photos/90946/pexels-photo-90946.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
//            ]
//        ]
//        productDetailsViewModel.bindImg = {[weak self] in
//            
//            print((self?.productDetailsViewModel.productImg.image.src) ?? "")
//        }
//        
//        productDetailsViewModel.createProductImg(params: params, id: 8151494459682)
//    }
//    
//    
//    
//    func addProductVariant(){
//        let params: [String : Any] = [
//            "variant":[
//                "product_id": 8151494459682,
//                "option1": "Purple",
//                "price": "100.00"
//            ]
//        ]
//        
//        productDetailsViewModel.bindVariant = {[weak self] in
//            
//            print((self?.productDetailsViewModel.productVariant.variant.title) ?? "")
//        }
//        
//        productDetailsViewModel.createProductVariant(params: params, id: 8151494459682)
//    }
//    
//    
//}
