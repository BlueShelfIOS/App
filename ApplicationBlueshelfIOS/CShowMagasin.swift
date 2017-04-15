//
//  CShowMagasin.swift
//  ApplicationBlueshelfIOS
//
//  Created by Antoine Millet on 11/04/2017.
//  Copyright © 2017 Antoine Millet. All rights reserved.
//

import Foundation

class CShowMagasin {
    
    var NomMagasin = String()
    var VilleMagasin = String()
    var CodePostalMagasin = String()
    var TelephoneMagasin = String()
    var AdresseMagasin = String()
    var idshop = String()
    
    
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
    
     func RequestPostMagasin( ) -> Int
     {
        var returnCode = Int()
        var request = URLRequest(url: URL(string: "https://dev.blueshelf.fr/app_dev.php/api/user")!)
        let postString = "_format=json&firstName=" + ModelData.getFirstName() + "&lastName=" + ModelData.getLastName() + "&email=" + ModelData.getEmail() + "&password=" + ModelData.getPassword() + "&shop_id=" + idshop
        request.httpMethod = "PUT"
        request.httpBody = postString.data(using: String.Encoding.utf8);
        request.setValue(ModelData.getToken(), forHTTPHeaderField: "X-Auth-Token")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let semaphore = DispatchSemaphore(value: 0)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let _ = data, error == nil else {
                returnCode = CODE_RETOUR_ERREUR_CONNECTION
                print("error connection")
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == CODE_RETOUR_400 {
                returnCode = CODE_RETOUR_400
                semaphore.signal()
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == CODE_RETOUR_200 {
                returnCode = CODE_RETOUR_200
                ModelData.setIdShop(id: self.idshop)
                semaphore.signal()
            }
        }
        task.resume()
        semaphore.wait()
        return returnCode
    }
    
    
    func RequestGetInformationMagasin(Id: String)
    {
        let urlApi = "https://dev.blueshelf.fr/app_dev.php/api/magasin?_format=json&id=" + Id
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
                //TelephoneMagasin = item["phone"] as! String // PAs encore implémenter coté API
                AdresseMagasin = item["street"] as! String
                let tmp = item["id"] as! Int
                idshop = String(tmp)
            }
        }
    }

    
    
    
