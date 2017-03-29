//
//  ListArticle.swift
//  ApplicationBlueshelfIOS
//
//  Created by Antoine Millet on 23/02/2017.
//  Copyright © 2017 Antoine Millet. All rights reserved.
//

import Foundation

public class ListArticle {
    
    public var ListeDeCourse = [String:Int]();
    
    func getListeDeCourse() -> [String:Int]{
        return(ListeDeCourse);
    }
    
    func addElemListeDeCousre(name:String, ID:Int){
        ListeDeCourse[name] = ID;
    }
    func deleteElemListeDeCousre(name:String) {
    ListeDeCourse.removeValue(forKey: name)
    }
    
    func getSizeOfListeDeCourse() -> Int{
        return ListeDeCourse.count
    }
    
    func getListeProduit() -> String{
        var ListIdProduit = String()
        for (_, ID) in ListeDeCourse
        {
            let IdProduit = String(ID)
            ListIdProduit += IdProduit
            ListIdProduit += ";"
        }
        var truncated = String()
        truncated = ListIdProduit.substring(to: ListIdProduit.index(before: ListIdProduit.endIndex))
        return (truncated)
    }
}
