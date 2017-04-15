//
//  CShowCategorieParent.swift
//  ApplicationBlueshelfIOS
//
//  Created by Antoine Millet on 15/04/2017.
//  Copyright © 2017 Antoine Millet. All rights reserved.
//

import Foundation

class CShowCategorieParent {
    
    var arrayOfCellData = [cellData]()

   
    func getArrayOfCellData() -> [cellData] {
        return arrayOfCellData
    }
    
    func RequestGetParentCategorie() -> Int {
        let urlApi = "https://dev.blueshelf.fr/app_dev.php/api/products/category?_format=json"
        var request = URLRequest(url: URL(string: urlApi)!)
        request.httpMethod = "GET"
        request.setValue(ModelData.getToken(), forHTTPHeaderField: "X-Auth-Token")
        var ReturnCode = Int()
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
        return(ReturnCode)
    }
    
    func Deserializer(data: Data) {
        arrayOfCellData = [cellData]()
        var json: Array<Any>!
        do {
            json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? Array
        } catch {
            print(error)
        }
        if json.count > 0 {
            var i = 0
            while (i < json.count){
                if let item = json[i] as? [String: AnyObject] {
                    var Obj = cellData()
                    Obj.ImgSrc = item["image"] as! String
                    Obj.LblTitre = item["name"] as! String
                    Obj.Id = String(item["id"] as! Int)
                    //Obj.parent_id = String(item["parent_id"] as! Int)
                    self.arrayOfCellData.append(Obj)
                    }
                i += 1
            }
        }
    }


    
    
    
    
    
}
