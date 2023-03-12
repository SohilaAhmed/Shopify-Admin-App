//
//  NetworkService.swift
//  Shopify App
//
//  Created by Sohila on 06/03/2023.
//

import Foundation

private let BASE_URL = "https://b24cfe7f0d5cba8ddb793790aaefa12a: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@mad-ios-2.myshopify.com/admin/api/2023-01/"

protocol Service{
    static func postApi<T: Codable>(endPoint: EndPoints, params: [String: Any], completionHandeler: @escaping ((T?), Error?) -> Void)
    static func getApi<T: Decodable>(endPoint: EndPoints, completionHandeler: @escaping ((T?), Error?) -> Void)
    static  func updateApi<T: Codable>(endPoint: EndPoints, params: [String: Any], completionHandeler: @escaping ((T?), Error?) -> Void)
    static  func deleteFromApi(endPoint: EndPoints)
}

class NetworkService : Service{
    
    static  func postApi<T: Codable>(endPoint: EndPoints, params: [String: Any], completionHandeler: @escaping ((T?), Error?) -> Void){
        let path = "\(BASE_URL)\(endPoint.path)"
        let url = URL(string: path)
        guard let url = url else{ return }
        var urlRequst = URLRequest(url: url)
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
                  //  print(myData)
                    completionHandeler(myData, nil)
                } catch {
                    print("Error decoding JSON: \(error)")
                    completionHandeler(nil, error)
                }
            }
            
        }.resume()
        
    }
    
    
    
    // using url session
    static func getApi<T: Decodable>(endPoint: EndPoints, completionHandeler: @escaping ((T?), Error?) -> Void){
        
        let path = "\(BASE_URL)\(endPoint.path)"
        let url = URL(string: path)
        guard let url = url else{ return }
        let req = URLRequest(url: url)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: req) { data, response, error in
            
            if let error = error{
                completionHandeler(nil, error)
            }else{
                let res = try? JSONDecoder().decode(T.self, from: data!)
                
                completionHandeler(res, nil)
            }
            
        }
        task.resume()
    }
    
    static  func updateApi<T: Codable>(endPoint: EndPoints, params: [String: Any], completionHandeler: @escaping ((T?), Error?) -> Void){
        let path = "\(BASE_URL)\(endPoint.path)"
        let url = URL(string: path)
        var urlRequst = URLRequest(url: url!)
        urlRequst.httpMethod = "PUT"
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
                    //                    print(myData)
                    completionHandeler(myData, nil)
                } catch {
                    print("Error decoding JSON: \(error)")
                    completionHandeler(nil, error)
                }
            }
            
        }.resume()
        
    }
    
    static  func deleteFromApi(endPoint: EndPoints){
        let path = "\(BASE_URL)\(endPoint.path)"
        let url = URL(string: path)
        var urlRequst = URLRequest(url: url!)
        urlRequst.httpMethod = "DELETE"
        urlRequst.httpShouldHandleCookies = false
        
//        do{
//            let requestBody = try JSONSerialization.data(withJSONObject: params,options: .prettyPrinted)
//            urlRequst.httpBody = requestBody
//            urlRequst.addValue("application/Json", forHTTPHeaderField: "content-type")
//
//        }catch let error{
//            debugPrint(error.localizedDescription)
//        }
        
        URLSession.shared.dataTask(with: urlRequst){ (data,response, error)  in
            
            if let data = data {
                let result = String(data: data, encoding: .utf8)
                debugPrint(result!)
            }
        
    }.resume()
    
}

}
