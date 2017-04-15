//
//  Model.swift
//  ApplicationBlueshelfIOS
//
//  Created by Antoine Millet on 16/11/2016.
//  Copyright © 2016 Antoine Millet. All rights reserved.
//

import Foundation

class Model {
    
    var _FirstName:String?
    var _LastName:String?
    var _Email:String?
    var _Token:String?
    var _Password:String?
    var _idShop = String()
    var _nameMagasin = String()
    
    
    func getFirstName() -> String {
        return(self._FirstName)!
    }
    
    func getNameMagasin() -> String {
        return(self._nameMagasin)
    }

    
    func getIdShop() -> String
    {
        return(self._idShop)
    }
    
    func getLastName() -> String {
        return(self._LastName)!
    }

    func getEmail() -> String {
        return(self._Email)!
    }
    func getToken() -> String {
        return(self._Token)!
    }
    func getPassword() -> String  {
        return(self._Password)!
    }

    func setIdShop(id:String) {
        self._idShop = id
    }
    
    func setNameMagasin(Name:String) {
        self._nameMagasin = Name
    }
    
    func setFirstName(Firstname:String) {
        self._FirstName = Firstname
    }
    
    func setLastName(Lastname:String) {
        _LastName = Lastname
    }
    
    func setEmail(Email:String) {
        _Email = Email
    }
    
    func setToken(Token:String) {
        _Token = Token
    }
    func setPassword(Password:String) {
        _Password = Password
    }

}
