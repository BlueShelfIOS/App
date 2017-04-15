//
//  CModifyPassword.swift
//  ApplicationBlueshelfIOS
//
//  Created by Antoine Millet on 13/04/2017.
//  Copyright © 2017 Antoine Millet. All rights reserved.
//

import Foundation

class CModifyPassword {
    
    func requestPatchPAssword(password: String) -> Int {
        
        var returnCode = Int()
        var request = URLRequest(url: URL(string: "https://dev.blueshelf.fr/app_dev.php/api/user")!)
        let postString = "_format=json&firstName=" + ModelData.getFirstName() + "&lastName=" + ModelData.getLastName() + "&email=" + ModelData.getEmail() + "&password=" + password + "&shop_id=" + ModelData.getIdShop()
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
                self.Desieralizer(data: data!)
                semaphore.signal()
            }
        }
        task.resume()
        semaphore.wait()
        return returnCode
    }
    
    func Desieralizer(data: Data){
        var json: Array<Any>!
        do {
            json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? Array
        } catch {
            print(error)
        }
        print(json)
    }
    
}
