//
//  CUser.swift
//  ApplicationBlueshelfIOS
//
//  Created by Maxime Dulin on 11/15/16.
//  Copyright © 2016 Antoine Millet. All rights reserved.
//

import Foundation

class CUser {
    
    func RequestUser(Token: String) -> Int {
        var request = URLRequest(url: URL(string: "https://dev.blueshelf.fr/app_dev.php/api/user?_format=json")!)
        request.httpMethod = "GET"
        request.setValue(Token, forHTTPHeaderField: "X-Auth-Token")
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
                self.Deserializer(data: data)
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
        return ReturnCode
    }
    
    func Deserializer(data: Data) {
        let responseString = try? JSONSerialization.jsonObject(with: data, options: [])
        print("responseString = \(responseString)")
        if let dictionary = responseString as? [String: Any]
        {
            if let fname = dictionary["firstName"] as? String {
                ModelData.setFirstName(Firstname: fname)
            }
            if let lname = dictionary["lastName"] as? String {
                ModelData.setLastName(Lastname: lname)
            }
            if let email = dictionary["email"] as? String {
                ModelData.setEmail(Email: email)
            }
        }
    }
}
