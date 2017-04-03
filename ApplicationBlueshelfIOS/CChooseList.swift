//
//  CChooseList.swift
//  ApplicationBlueshelfIOS
//
//  Created by Antoine Millet on 28/03/2017.
//  Copyright © 2017 Antoine Millet. All rights reserved.
//

import Foundation

class CChooseList {
    
    var ListeDeCourseNom_Id = [String:String]()
    var ListeDeCourseNom = [String]()
    
    
    func getListeDeCourseNom_Id() -> [String:String] {
        return (ListeDeCourseNom_Id)
    }
    
    func getListeDeCourseNom() -> [String]{
    return (ListeDeCourseNom)
    }
    
    func getListeProduit(NomListe: String) -> String{
        return (ListeDeCourseNom_Id[NomListe])!
    }
    
    func RequestGetList()
    {
        let urlApi = "https://dev.blueshelf.fr/app_dev.php/api/products/list?_format=json"
        var request = URLRequest(url: URL(string: urlApi)!)
        request.httpMethod = "GET"
        request.setValue(ModelData.getToken(), forHTTPHeaderField: "X-Auth-Token")
        let semaphore = DispatchSemaphore(value: 0)
        let task = URLSession.shared.dataTask(with: request)
        {
            data, response, error in
            guard let _ = data, error == nil else
            {
                
                semaphore.signal()
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 200 {
                self.Deserializer(data: data!)
                semaphore.signal()
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 401 {
                semaphore.signal()
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 500 {
                semaphore.signal() // Internal error
            }
            
        }
        task.resume()
        semaphore.wait()
    }
    
    func Deserializer(data: Data){

        if (ModelArticle.getSizeOfListeDeCourse() > 0) {
            let date = String(describing: Date())
            let NameListe = "Liste " + date
            
            let endIndex = NameListe.index(NameListe.endIndex, offsetBy: -5)
            var truncated = NameListe.substring(to: endIndex)
            
            ListeDeCourseNom.append(truncated )
            ListeDeCourseNom_Id[truncated] = ModelArticle.getListeProduit()
        }
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
                    let name = item["name"] as! String
                    let listeId = item["listId"] as! String
                    if (name != ""){
                        ListeDeCourseNom.append(name)
                        ListeDeCourseNom_Id[name] = listeId
                    }
                }
                i += 1
            }
        }
    }

    
    
    
    
}
