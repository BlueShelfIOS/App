//
//  CForgottenPassword.swift
//  ApplicationBlueshelfIOS
//
//  Created by Antoine Millet on 16/11/2016.
//  Copyright © 2016 Antoine Millet. All rights reserved.
//

import Foundation


class CForgottenPassword {
    
    
    func VerifyEmail(Email: String) -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: Email)
    }

    func RequestPostResetPassword(Email: String) -> Int {
        var request = URLRequest(url: URL(string: "https://dev.blueshelf.fr/app_dev.php/api/users/reset")!)
        request.httpMethod = "POST"
        let postString = "email=" + Email
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
                let responseString = try? JSONSerialization.jsonObject(with: data, options: [])
                print("responseString = \(responseString)")
                ReturnCode = 201
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
