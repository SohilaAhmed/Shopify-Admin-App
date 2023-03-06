//
//  NetworkService.swift
//  Shopify App
//
//  Created by Zienab on 04/03/2023.
//

import Foundation

protocol Service{
    static func createProduct<T: Codable>(urlStr: String, params: [String: Any], completionHandeler: @escaping ((T?), Error?) -> Void)
}

class NetworkService : Service{
    
    static  func createProduct<T: Codable>(urlStr: String, params: [String: Any], completionHandeler: @escaping ((T?), Error?) -> Void){
//        let params: [String : Any] = [
//            "product":[
//                "title": "Zinab",
//                "body_html": "Good Zinab!",
//                "vendor": "Zinab",
//                "product_type": "Zinab",
//                "status": "active"
//            ]
//        ]
        

//        let url = URL(string: "https://b24cfe7f0d5cba8ddb793790aaefa12a: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@mad-ios-2.myshopify.com/admin/api/2023-01/products.json" )
        
        let url = URL(string: urlStr)
        var urlRequst = URLRequest(url: url!)
        urlRequst.httpMethod = "post"
        urlRequst.httpShouldHandleCookies = false
        
        do{
            let requestBody = try JSONSerialization.data(withJSONObject: params,options: .prettyPrinted)
            urlRequst.httpBody = requestBody
            urlRequst.addValue("application/Json", forHTTPHeaderField: "content-type")
            
        }catch let error{
            debugPrint(error.localizedDescription)
        }
        
        URLSession.shared.dataTask(with: urlRequst){ (data,response, error)  in
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let myData = try decoder.decode(T.self , from: data)
                    print(myData)
                    completionHandeler(myData, nil)
                } catch {
                    print("Error decoding JSON: \(error)")
                    completionHandeler(nil, error)
                }
            }
            
        }.resume()
        
    }
    
    
    
    // using url sesion
    func loadDataFromURL<T: Decodable>( urlStr: String, completionHandeler: @escaping ((T?), Error?) -> Void){
        
        let url = URL(string: urlStr)
        guard let url = url else{ return }
        let req = URLRequest(url: url)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: req) { data, response, error in
            
            if let error = error{
                completionHandeler(nil, error)
            }else{
                let res = try? JSONDecoder().decode(T.self, from: data!)
                // print(res?.customers)
                //                let movieArray = res?.items
                completionHandeler(res, nil)
            }
            
        }
        task.resume()
    }
    
    
}
