//
//  CProductTree.swift
//  ApplicationBlueshelfIOS
//
//  Created by Maxime Dulin on 11/24/16.
//  Copyright © 2016 Antoine Millet. All rights reserved.
//

import Foundation

class CProductTree {
    
    func FindAllCategory() -> Array<Product_category> {
        var CategoryArray = Array<Product_category>()
        
        let endUrl = ""
        let urlApi = "https://dev.blueshelf.fr/app_dev.php/api/products?_format=json&name=" + endUrl
        var request = URLRequest(url: URL(string: urlApi)!)
        request.httpMethod = "GET"
        request.setValue(ModelData.getToken(), forHTTPHeaderField: "X-Auth-Token")
        var ReturnCode = 0
        let semaphore = DispatchSemaphore(value: 0)
        let task = URLSession.shared.dataTask(with: request)
        {
            data, response, error in
            guard let data = data, error == nil else
            {
                ReturnCode = -1
                semaphore.signal()
                return // Error Connection
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 200 {
                ReturnCode = 200
                CategoryArray = self.Deserializer(data: data)
                semaphore.signal()
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 401 {
                ReturnCode = 401
                semaphore.signal()
            }
        }
        task.resume()
        semaphore.wait()
        print(ReturnCode)
        return(CategoryArray)
    }
    
    func Deserializer(data: Data) -> Array<Product_category> {
        var MainCategory = Array<Product_category>()
        var json: Array<Any>!
        do {
            json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? Array
        } catch {
            print(error)
        }
        if json.count > 0 {
            var i = 0
            while (i < json.count){
                if let item = json[i] as? [String: AnyObject] {
                    let name = item["name"] as! String
                    if (name != ""){
                        if let result_number = item["category"] as? NSNumber
                        {
                            var indexMatch: Int = 0
                            var ct: Int = 0
                            var isPassed: Bool = false
                            let result_string = "\(result_number)"
                            let newProduct = Product(n: name, p: item["price"] as! String)
                            for category in MainCategory {
                                if (category.getId() == result_string) {
                                    isPassed = true
                                    indexMatch = ct
                                }
                                ct += 1
                            }
                            if (isPassed == true) {
                                MainCategory[indexMatch].addProduct(p: newProduct)
                            }
                            else {
                                let newCategory = Product_category(i: result_string)
                                newCategory.addProduct(p: newProduct)
                                MainCategory.append(newCategory)
                            }
                        }
                    }
                }
                i += 1
            }
        }
        return (MainCategory)
    }
}
