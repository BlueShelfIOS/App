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
        var request = URLRequest(url: URL(string: "http://dev.blueshelf.fr/app_dev.php/auth-tokens")!)
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
                let responseString = String(data: data, encoding: .utf8) // token
                print("responseString = \(responseString)")
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
