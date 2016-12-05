//
//  CScannerReading.swift
//  ApplicationBlueshelfIOS
//
//  Created by Maxime Dulin on 11/21/16.
//  Copyright © 2016 Antoine Millet. All rights reserved.
//

import Foundation

class CScannerReading {
    
    func GetItemByCode(code: String) -> String {
        var nameProduct = String()
        let urlApi = "https://dev.blueshelf.fr/app_dev.php/api/products?_format=json&reference=" + code
        var request = URLRequest(url: URL(string: urlApi)!)
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
                nameProduct = self.Deserializer(data: data)
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
        return nameProduct
    }
    
    func Deserializer(data: Data) -> String {
        var json: Array<Any>!
        do {
            json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? Array
        } catch {
            print(error)
        }
        if let item = json[0] as? [String: AnyObject] {
            return (item["name"]!) as! String
        }
        return "null"
    }
}
