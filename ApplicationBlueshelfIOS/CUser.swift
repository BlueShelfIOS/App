//
//  CUser.swift
//  ApplicationBlueshelfIOS
//
//  Created by Maxime Dulin on 11/15/16.
//  Copyright © 2016 Antoine Millet. All rights reserved.
//

import Foundation

class User {
    
    func RequestPostConnection(Token: String) -> Int {
        var request = URLRequest(url: URL(string: "https://dev.blueshelf.fr/app_dev.php/api/user?_format=json")!)
        request.httpMethod = "GET"
        let postString = "X-Auth-Token=" + Token
        request.httpBody = postString.data(using: .utf8)
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
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 201 {
                ReturnCode = 201
                //let responseString = try? JSONSerialization.jsonObject(with: data, options: [])
                //String(data: data, encoding: .utf8) // token
                //let data: Data
                //print("responseString = \(responseString)")
                //self.Deserializer(data: data)
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
}
