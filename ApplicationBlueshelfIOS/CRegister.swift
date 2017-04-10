//
//  CRegister.swift
//  ApplicationBlueshelfIOS
//
//  Created by Antoine Millet on 04/11/2016.
//  Copyright © 2016 Antoine Millet. All rights reserved.
//

import Foundation

class CRegister {
    
    
    func VerifyEmail(Email: String) -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: Email)
    }
    
    
    func RequestPostRegister(FirstName: String, LastName: String, Password: String, Email: String) -> Int {
        var returnCode = Int()
        var request = URLRequest(url: URL(string: "https://dev.blueshelf.fr/app_dev.php/api/users")!)
        request.httpMethod = "POST"
        let postString = "_format=json&firstName=" + FirstName + "&lastName=" + LastName + "&email=" + Email + "&password=" + Password
        request.httpBody = postString.data(using: .utf8)
        let semaphore = DispatchSemaphore(value: 0)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let _ = data, error == nil else {
                returnCode = CODE_RETOUR_ERREUR_CONNECTION
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == CODE_RETOUR_201 {
                returnCode = CODE_RETOUR_201
                semaphore.signal()
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == CODE_RETOUR_200 {
                returnCode = CODE_RETOUR_200
                semaphore.signal()
            }
        }
        task.resume()
        semaphore.wait()
        return returnCode
    }

    
}
