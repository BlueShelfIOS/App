//
//  CList.swift
//  ApplicationBlueshelfIOS
//
//  Created by Antoine Millet on 23/02/2017.
//  Copyright © 2017 Antoine Millet. All rights reserved.
//

import Foundation

class CDetailList {
    
    var ListeProduitNom_Id = [String:Int]()
    var ListeProduitNom = [String]()
    var Retour = Int()
    
    
    func getRetour() -> Int {
        return Retour
    }
    
    func getListProduitNom() -> [String] {
        return (ListeProduitNom)
    }
    
    func removeListeProduitNom_Id() {
        ListeProduitNom_Id = [String:Int]()
    }
    
    func removeListeProduitNom() {
        ListeProduitNom = [String]()
    }
    
    func getListeProduitNom_Id() -> [String:Int] {
        return (ListeProduitNom_Id )
    }
    
    func getListProduitNomModifié() -> [String]{
        for (name, ID) in ModelArticle.getListeDeCourseModifié()
        {
            ListeProduitNom.append(name)
            ListeProduitNom_Id[name] = ID
        }
        ModelArticle.RemoveListeDeCourseModifié()
        return (ListeProduitNom)
    }
    
    func RequestProduct(Product: String){
        let newString = Product.replacingOccurrences(of: ";", with: ",", options: .literal, range: nil)
        var urlApi = "https://dev.blueshelf.fr/app_dev.php/api/products?_format=json&id="
        urlApi += newString
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

    
    func RequestPostList(ListProduitId:String, NomListe:String)
    {
        var request = URLRequest(url: URL(string: "https://dev.blueshelf.fr/app_dev.php/api/products/list")!)
        let postString = "_format=json&id_products=" + ListProduitId + "&name=" + NomListe
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)
        request.setValue(ModelData.getToken(), forHTTPHeaderField: "X-Auth-Token")
        let semaphore = DispatchSemaphore(value: 0)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let _ = data, error == nil else {
                print("error=\(error)")
                self.Retour = -1
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 201 {
                semaphore.signal()
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 401 {
                semaphore.signal()
                self.Retour = 401
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 500 {
                semaphore.signal()
                self.Retour = 500
            }
            }
        task.resume()
    }
    
    
    func getListeProduitId() -> String {
        var ListeProduitId = String()
        for (_, ID) in ListeProduitNom_Id
        {
            let newString = String(ID)
            ListeProduitId += newString
            ListeProduitId += ";"
        }
        var truncated = String()
        truncated = ListeProduitId.substring(to: ListeProduitId.index(before: ListeProduitId.endIndex))
        return (truncated)
    }
}
