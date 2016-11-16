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
    
    
    func getFirstName() -> String {
        return(self._FirstName)!
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


}
