//
//  CRegister.swift
//  ApplicationBlueshelfIOS
//
//  Created by Antoine Millet on 04/11/2016.
//  Copyright © 2016 Antoine Millet. All rights reserved.
//

import Foundation

class CRegister {
    
    
    func VerifySamePassword(Password1: String, Password2: String) -> Bool
    {
        if (Password1 == Password2)
        {
            return (true)
        }
        return (false)
    }
    
    func VerifyEmail(Email: String) -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: Email)
    }
    
    func VerifyInputFields(FirstName: String, LastName: String, Email: String, Password1: String, Password2: String) -> Bool
    {
        if (FirstName.isEmpty || LastName.isEmpty || Email.isEmpty || Password1.isEmpty || Password2.isEmpty) {
            return false
        }
        return (true)
    }
 
    func RequestPostRegister(FirstName: String, LastName: String, Password: String, Email: String) -> Int {
        var request = URLRequest(url: URL(string: "https://dev.blueshelf.fr/app_dev.php/api/users")!)
        request.httpMethod = "POST"
        let postString = "firstName=" + FirstName + "&lastName=" + LastName + "&email=" + Email + "&password=" + Password
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
        
        print(ReturnCode)
        semaphore.signal()
        task.resume()
        semaphore.wait()
        return ReturnCode
    }

    
}
