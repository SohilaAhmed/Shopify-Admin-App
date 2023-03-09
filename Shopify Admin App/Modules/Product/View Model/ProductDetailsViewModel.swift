////
////  ProductDetailsViewModel.swift
////  Shopify Admin App
////
////  Created by Sohila on 06/03/2023.
////
//
//import Foundation
//
//class ProductDetailsViewModel{
//    
//    var bindImg: (() -> ()) = {}
//    
//    var bindVariant: (() -> ()) = {}
//    
//    var productImg : ProductImgModel!{
//        didSet{
//            bindImg()
//            
//        }
//    }
//    
//    var productVariant : ProductVariantModel!{
//        didSet{
//            bindVariant()
//            
//        }
//    }
//    
//    func createProductImg(params: [String: Any], id: Int){
//        
//        NetworkService.postApi(endPoint: EndPoints.createProductImg(id: id), params: params) { [weak self] (data: ProductImgModel?, error) in
//            guard let responsData = data else{ return}
//            self?.productImg = responsData
//            print(self?.productImg.image.src)
//            
//        }
//    }
//    
//    func createProductVariant(params: [String: Any], id: Int){
//        NetworkService.postApi(endPoint: EndPoints.createProductVariants(id: id), params: params) { [weak self] (data: ProductVariantModel?, error) in
//            guard let responsData = data else{ return}
//            self?.productVariant = responsData
//            print(self?.productVariant.variant.title)
//            
//        }
//    }
//    
//}
