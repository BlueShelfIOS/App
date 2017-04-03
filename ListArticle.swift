//
//  ListArticle.swift
//  ApplicationBlueshelfIOS
//
//  Created by Antoine Millet on 23/02/2017.
//  Copyright © 2017 Antoine Millet. All rights reserved.
//

import Foundation

public class ListArticle {
    
    public var Mode = Int();    // 0 ajout liste de course par defaut - 1 ajout liste de course modifié
    public var ListeDeCourse = [String:Int](); // uniquement pour creation de liste par defaut 
    
    public var ListeDeCourseModifié = [String:Int](); // var global pour enregistrer les nouveaux produits 
    
    
    func setMode(mode:Int){
        self.Mode = mode
    }
    
    func getMode() ->Int{
        return(self.Mode)
    }
    
    func getListeDeCourseModifié() -> [String:Int]{
        return(ListeDeCourseModifié);
    }
    
    func RemoveListeDeCourseModifié(){
        ListeDeCourseModifié = [String:Int]()
    }
    
    func RemoveListeDeCourse() {
        ListeDeCourse = [String:Int]();
    }
    
    func getListeDeCourse() -> [String:Int]{
        return(ListeDeCourse);
    }
    
    func getNumberArticleListeDeCourseModifié() -> Int{
        return(ListeDeCourseModifié.count)
    }
    
    func addElemListeDeCourseModifié(name:String, ID:Int){
        ListeDeCourseModifié[name] = ID;
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
