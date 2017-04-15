//
//  CInformationUser.swift
//  ApplicationBlueshelfIOS
//
//  Created by Antoine Millet on 12/04/2017.
//  Copyright © 2017 Antoine Millet. All rights reserved.
//

import Foundation

class CInformationUser {
    
      func RequestGetInformation()
    {
        let urlApi = "https://dev.blueshelf.fr/app_dev.php/api/user?_format=json"
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
                semaphore.signal() 
            }
            
        }
        task.resume()
        semaphore.wait()
    }
    
    func Deserializer(data: Data){
        
        let responseString = try? JSONSerialization.jsonObject(with: data, options: [])
        if let dictionary = responseString as? [String: Any]
        {
            ModelData.setLastName(Lastname: dictionary["lastName"] as! String)
            ModelData.setFirstName(Firstname: dictionary["firstName"] as! String)
            ModelData.setEmail(Email: dictionary["email"] as! String)
            if let nestedDictionary = dictionary["shop"] as? [String: Any] {
                ModelData.setIdShop(id: String(nestedDictionary["id"] as! Int))
                ModelData.setNameMagasin(Name: nestedDictionary["name"] as! String)
                
            }
        }
    }
}
