//
//  CHome.swift
//  ApplicationBlueshelfIOS
//
//  Created by Antoine Millet on 04/11/2016.
//  Copyright © 2016 Antoine Millet. All rights reserved.
//

import Foundation

class CConnection {

    func RequestPostConnection(Username: String, PassWord: String) -> Int {
        var ReturnCode = 0
        var request = URLRequest(url: URL(string: "https://dev.blueshelf.fr/app_dev.php/auth-tokens")!)
        request.httpMethod = "POST"
        let postString = "login=" + Username + "&password=" + PassWord + "&type=0"
        request.httpBody = postString.data(using: .utf8)
        let semaphore = DispatchSemaphore(value: 0);
        let task = URLSession.shared.dataTask(with: request)
        {
            data, response, error in
            guard let data = data, error == nil else
            {
                ReturnCode = CODE_RETOUR_ERREUR_CONNECTION
                semaphore.signal()
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == CODE_RETOUR_201 {
                ReturnCode = CODE_RETOUR_201
                self.Deserializer(data: data)
                semaphore.signal()
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == CODE_RETOUR_400 {
                ReturnCode = CODE_RETOUR_400
                semaphore.signal()
            }
        }
        task.resume()
        semaphore.wait()
        return ReturnCode
    }
    
    func Deserializer(data: Data)
    {
        let responseString = try? JSONSerialization.jsonObject(with: data, options: [])
        if let dictionary = responseString as? [String: Any]
        {
            if let token = dictionary["value"] as? String {
                print("Token de connexion= \(token)")
                ModelData.setToken(Token: token)
            }
            if let nestedDictionary = dictionary["user"] as? [String: Any] {
                ModelData.setFirstName(Firstname: (nestedDictionary["firstName"]  as? String!)!)
                ModelData.setLastName(Lastname: (nestedDictionary["lastName"] as? String!)!)
                ModelData.setEmail(Email: (nestedDictionary["email"] as? String!)!)
                //ModelData.setPassword(Password: (nestedDictionary["password"] as? String!)!)
                if let nestedDictionary2 = nestedDictionary["shop"] as? [String: Any] {
                    let x : Int = (nestedDictionary2["id"] as? Int)!
                    ModelData.setIdShop(id: String(x))
                    let test = nestedDictionary2["name"] as? String
                    if (test?.isEmpty)! {
                    ModelData.setNameMagasin(Name: "")
                }
                    else {
                    ModelData.setNameMagasin(Name: test!)
                    }
                }
            }
            
            
        }
    }
}
