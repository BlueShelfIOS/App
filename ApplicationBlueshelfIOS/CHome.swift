//
//  CHome.swift
//  ApplicationBlueshelfIOS
//
//  Created by Antoine Millet on 04/11/2016.
//  Copyright © 2016 Antoine Millet. All rights reserved.
//

import Foundation

class CHome {


    
    func RequestPostConnection(Username: String, PassWord: String) -> Int {
        var request = URLRequest(url: URL(string: "https://dev.blueshelf.fr/app_dev.php/auth-tokens")!)
        request.httpMethod = "POST"
        let postString = "login=" + Username + "&password=" + PassWord
        request.httpBody = postString.data(using: .utf8)
        var ReturnCode = 0
        let semaphore = DispatchSemaphore(value: 0);
        let task = URLSession.shared.dataTask(with: request)
        {
            data, response, error in
            guard let data = data, error == nil else
            {
                ReturnCode = -1
                semaphore.signal()
                return // Error Connection
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 201 {
                ReturnCode = 201
                //let responseString = try? JSONSerialization.jsonObject(with: data, options: [])
                //String(data: data, encoding: .utf8) // token
                //let data: Data
                //print("responseString = \(responseString)")
                self.Deserializer(data: data)
                semaphore.signal()
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 400 {
                ReturnCode = 400
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
        //String(data: data, encoding: .utf8) // token
        print("responseString = \(responseString)")
        if let dictionary = responseString as? [String: Any]
        {
            if let token = dictionary["value"] as? String {
                print("Token = \(token)")
                // access individual value in dictionary
                
            }
            if let nestedDictionary = dictionary["user"] as? [String: Any] {
                let firstname:String?
                let lastname:String?
                let email:String?
                firstname = nestedDictionary["firstName"]  as? String
                lastname = nestedDictionary["lasttName"] as? String
                email = nestedDictionary["email"] as? String
                print(firstname!)
                print(lastname!)
                print(email!)
                    }
                    
                    
                }
            }
        }
