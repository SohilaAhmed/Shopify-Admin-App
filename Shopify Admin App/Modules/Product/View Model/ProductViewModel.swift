//
//  ProductViewModel.swift
//  Shopify Admin App
//
//  Created by Sohila on 06/03/2023.
//

import Foundation

class ProductViewModel{
    
    var bindResultToProduct: (() -> ()) = {}
    var bindImg: (() -> ()) = {}
    var bindProductCustomCollection: (() -> ()) = {}
    
    var allProduct : ProductInfo!{
        didSet{
            bindResultToProduct()
        }
    }
    
    var productImg : ProductImgModel!{
        didSet{
            bindImg()
        }
    }
    
    var productCustomCollection : ProductCustomCollectionModel!{
        didSet{
            bindProductCustomCollection()
        }
    }


    func createProduct(params: [String: Any]){
        NetworkService.createProduct(endPoint: EndPoints.createNewProduct, params: params) { [weak self] (data: ProductInfo?, error) in
            guard let responsData = data else{ return}
            self?.allProduct = responsData
            print(self?.allProduct.product)
        }
    }
    
    func createProductImg(params: [String: Any], id: Int){
        NetworkService.createProduct(endPoint: EndPoints.createProductImg(id: id), params: params) { [weak self] (data: ProductImgModel?, error) in
            guard let responsData = data else{ return}
            self?.productImg = responsData
            print(self?.productImg.image.src)
        }
    }
    
    func addProdoctCustomCollection(params: [String: Any]){
        NetworkService.createProduct(endPoint: EndPoints.addProductToCustomCollection, params: params) { [weak self] (data: ProductCustomCollectionModel?, error) in
            guard let responsData = data else{ return}
            self?.productCustomCollection = responsData
            print(self?.productCustomCollection.collect.collection_id)
        }
    }
    
}
