//
//  CChooseMagasin.swift
//  ApplicationBlueshelfIOS
//
//  Created by Antoine Millet on 11/04/2017.
//  Copyright © 2017 Antoine Millet. All rights reserved.
//

import Foundation

class CChooseMagasin {
    
    
    var ListeMagasinNom_Id = [String:String]()
    var ListeMagasinNom = [String]()
    
       
    func getListeMagasinNom_Id() -> [String:String] {
        return (ListeMagasinNom_Id)
    }
    
    func getListeMagasinNom() -> [String]{
        return (ListeMagasinNom)
    }
    
    func getIdMagasin(NomListe: String) -> String{
        return (ListeMagasinNom_Id[NomListe])!
    }
    
    func RequestGetListMagasinByZipCode(zipcode: String) -> [String]
    {
        let urlApi = "https://dev.blueshelf.fr/app_dev.php/api/magasin?_format=json&zipcode=" + zipcode
        var request = URLRequest(url: URL(string: urlApi)!)
        request.httpMethod = "GET"
        request.setValue(ModelData.getToken(), forHTTPHeaderField: "X-Auth-Token")
        let semaphore = DispatchSemaphore(value: 0)
        let task = URLSession.shared.dataTask(with: request)
        {
            data, response, error in
            guard let _ = data, error == nil else
            {
                
                semaphore.signal()
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 200 {
                self.Deserializer(data: data!)
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
        return ListeMagasinNom
    }
    
    func RequestGetListMagasinByCity(city: String) -> [String]
    {
        let urlApi = "https://dev.blueshelf.fr/app_dev.php/api/magasin?_format=json&city=" + city
        var request = URLRequest(url: URL(string: urlApi)!)
        request.httpMethod = "GET"
        request.setValue(ModelData.getToken(), forHTTPHeaderField: "X-Auth-Token")
        let semaphore = DispatchSemaphore(value: 0)
        let task = URLSession.shared.dataTask(with: request)
        {
            data, response, error in
            guard let _ = data, error == nil else
            {
                semaphore.signal()
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 200 {
                self.Deserializer(data: data!)
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
        return ListeMagasinNom
    }

    
    
    func RequestGetListMagasin()
    {
        let urlApi = "https://dev.blueshelf.fr/app_dev.php/api/magasin?_format=json"
        var request = URLRequest(url: URL(string: urlApi)!)
        request.httpMethod = "GET"
        request.setValue(ModelData.getToken(), forHTTPHeaderField: "X-Auth-Token")
        let semaphore = DispatchSemaphore(value: 0)
        let task = URLSession.shared.dataTask(with: request)
        {
            data, response, error in
            guard let _ = data, error == nil else
            {
                
                semaphore.signal()
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 200 {
                self.Deserializer(data: data!)
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
    
    
    func Deserializer(data: Data){
        ListeMagasinNom_Id = [String:String]()
        ListeMagasinNom = [String]()
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
                    let id = item["id"] as! Int
                    if (name != ""){
                        ListeMagasinNom.append(name)
                        let myString = String(id)
                        ListeMagasinNom_Id[name] = myString
                    }
                }
                i += 1
            }
        }
    }
    
    
    
    

    
}
