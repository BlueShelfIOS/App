//
//  CSideMenuRight.swift
//  ApplicationBlueshelfIOS
//
//  Created by Antoine Millet on 10/04/2017.
//  Copyright © 2017 Antoine Millet. All rights reserved.
//

import Foundation

class CSideMenuRight {
    
    var Retour = Int()
    
    func getRetour() -> Int {
    return self.Retour
    }
    
    func RequestDeleteToken()
    {
        /*var request = URLRequest(url: URL(string: "https://dev.blueshelf.fr/app_dev.php/api/auth-tokens")!)
        request.httpMethod = "DELETE"
        request.setValue(ModelData.getToken(), forHTTPHeaderField: "X-Auth-Token")
        let semaphore = DispatchSemaphore(value: 0)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let _ = data, error == nil else {
                self.Retour = -1
                return
            }
            let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print(dataString)
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 204 {
                self.Retour = 204
                semaphore.signal()
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 500 {
                semaphore.signal()
                self.Retour = 500
            }
        }
        task.resume()*/

    }
}
