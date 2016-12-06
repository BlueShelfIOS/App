//
//  Product.swift
//  ApplicationBlueshelfIOS
//
//  Created by Maxime Dulin on 12/6/16.
//  Copyright © 2016 Antoine Millet. All rights reserved.
//

import Foundation

class Product {
    private var name: String?
    private var price: String?
    private var description: String?
    
    init(n: String, p: String) {
        name = n
        price = p
    }
    
    func getName() -> String {
        return name!
    }
    
    func getPrice() -> String {
        return price!
    }
    
    func getDescription() -> String {
        return description!
    }
    
    func setName(n: String) {
        name = n
    }
    
    func setPrice(p: String) {
        price = p
    }
    
    func setDescription(d: String) {
        description = d
    }    
}
