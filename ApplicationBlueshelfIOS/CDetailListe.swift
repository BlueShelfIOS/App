//
//  CList.swift
//  ApplicationBlueshelfIOS
//
//  Created by Antoine Millet on 23/02/2017.
//  Copyright © 2017 Antoine Millet. All rights reserved.
//

import Foundation

class CDetailListe {
    
    
    var ListeProduitNom_Id = [String:Int]()
    var ListeProduitNom = [String]()
    
    
    func getListProduitNom() -> [String] {
        return (ListeProduitNom)
    }
    
    func getListeProduitNom_Id() -> [String:Int] {
        return (ListeProduitNom_Id )
    }
    
    func RequestProduct(Product: String){
        let newString = Product.replacingOccurrences(of: ";", with: ",", options: .literal, range: nil)
        var urlApi = "https://dev.blueshelf.fr/app_dev.php/api/products?_format=json&id="
        urlApi += newString
        print(urlApi)
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
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 200 {
                self.DeserializerListIdToProduct(data: data)
                semaphore.signal()
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 401 {
                semaphore.signal()
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 500 {
                semaphore.signal()
            }
            
        }
        task.resume()
        semaphore.wait()
    }
    
    
  
    func DeserializerListIdToProduct(data: Data){
        var json: Array<Any>!
        do {
            json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? Array
        } catch {
            print(error)
        }
        if json.count > 0 {
            var i = 0
            while (i < json.count){
                print (json[i])
                if let item = json[i] as? [String: AnyObject] {
                    let nomProduit = item["name"] as! String
                    let idProduit = item["id"] as! Int
                    if (nomProduit != ""){
                        ListeProduitNom.append(nomProduit)
                        ListeProduitNom_Id[nomProduit] = idProduit
                    }
                }
                i += 1
            }
        }
    }

    
    func RequestPostList(ListProduct:String)
    {
        var request = URLRequest(url: URL(string: "https://dev.blueshelf.fr/app_dev.php/api/products/list")!)
        request.httpMethod = "POST"
        request.setValue(ModelData.getToken(), forHTTPHeaderField: "X-Auth-Token")
        let postString = "id_product=" + ListProduct + "name=" + "test"
        request.httpBody = postString.data(using: .utf8)
        let semaphore = DispatchSemaphore(value: 0);
        _ = URLSession.shared.dataTask(with: request)
        {
            
            data, response, error in
            guard let data = data, error == nil else
            {
                semaphore.signal()
                return // Error Connection
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 201 {
                let responseString = String(data: data, encoding: .utf8) // token
                print("responseString = \(responseString)")
                semaphore.signal()
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 401 {
                semaphore.signal()
            }
        }
    }
    
    @IBAction func OnclickSave(_ sender: Any) {
        print("putain")
        let product = ModelArticle.getListeDeCourse()
        var ListProduct = String();
        for (_, ID) in product
        {
            let myString = String(ID)
            ListProduct += myString
            ListProduct += ";"
        }
        ListProduct = ListProduct.substring(to: ListProduct.index(before: ListProduct.endIndex))
        print(ListProduct);
        RequestPostList(ListProduct: ListProduct)
    }

    
    
    
}
