//
//  CContact.swift
//  ApplicationBlueshelfIOS
//
//  Created by Antoine Millet on 16/04/2017.
//  Copyright © 2017 Antoine Millet. All rights reserved.
//

import Foundation

class CContact {
    
    var telephone = String()
    var CodePostalMagasin = String()
    var NomMagasin = String()
    var AdresseMagasin = String()
    var VilleMagasin = String()
    var TelephoneMagasin = String()
    
    
    func getNomMagasin() -> String {
        return self.NomMagasin
    }
    
    func getVilleMagasin() -> String {
        return self.VilleMagasin
    }
    
    func getCodePostalMagasin() -> String {
        return self.CodePostalMagasin
    }
    
    func getTelephoneMagasin() -> String {
        return self.TelephoneMagasin
    }
    
    func getAdresseMagasin() -> String {
        return self.AdresseMagasin
    }

 
    func RequestGetMagasin()
    {
        let urlApi = "https://dev.blueshelf.fr/app_dev.php/api/magasin?_format=json&id=" + ModelData._idShop
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
        var json: Array<Any>!
        do {
            json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? Array
        } catch {
            print(error)
        }
        if let item = json[0] as? [String: AnyObject] {
            NomMagasin = item["name"] as! String
            VilleMagasin = item["city"] as! String
            CodePostalMagasin = item["zipcode"] as! String
            TelephoneMagasin = item["telephone"] as! String
            AdresseMagasin = item["street"] as! String
        }
    }

}
