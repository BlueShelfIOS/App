//
//  CProduct.swift
//  ApplicationBlueshelfIOS
//
//  Created by Antoine Millet on 30/11/2016.
//  Copyright © 2016 Antoine Millet. All rights reserved.
//

import Foundation

class CProduct {
    
    var Description = String()
    var Price = String()
    var name = String()
    
    
    func RequestProduct(Product: String){
        var tmp = String()
        self.name = Product
        var urlApi = "https://dev.blueshelf.fr/app_dev.php/api/products?_format=json&name="
        urlApi += self.name.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        tmp = urlApi.folding(options: .diacriticInsensitive, locale: .current)
        print ("Requete :\(urlApi)")
        var request = URLRequest(url: URL(string: tmp)!)
        request.httpMethod = "GET"
        request.setValue(ModelData.getToken(), forHTTPHeaderField: "X-Auth-Token")
        let semaphore = DispatchSemaphore(value: 0)
        let task = URLSession.shared.dataTask(with: request)
        {
            data, response, error in
            guard let data = data, error == nil else
            {

                semaphore.signal()
                return // Error Connection
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 200 {
                self.Deserializer(data: data)
                semaphore.signal()
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 401 {
                semaphore.signal()
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 500 {
                semaphore.signal() // Internal error
            }

        }
        task.resume()
        semaphore.wait()
    }
    
    func Deserializer(data: Data) {
        var json: Array<Any>!
        do {
            json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? Array
        } catch {
            print(error)
        }
        if let item = json[0] as? [String: AnyObject] {
            print (item)
            self.Price = item["price"] as! String
            self.Description = item["description"] as! String
        }
    }
}
