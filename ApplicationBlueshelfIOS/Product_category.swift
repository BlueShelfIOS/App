//
//  Product_category.swift
//  ApplicationBlueshelfIOS
//
//  Created by Maxime Dulin on 12/6/16.
//  Copyright © 2016 Antoine Millet. All rights reserved.
//

import Foundation

class Product_category {
    private var products = Array<Product>()
    private var sub_category = Array<Product_category>()
    private var id:String?
    
    init(i: String) {
        id = i
    }
    
    func getProducts() -> Array<Product> {
        return products
    }
    
    func addProduct(p: Product) {
        products.append(p)
    }
    
    func getSubCategory() -> Array<Product_category> {
        return sub_category
    }
    
    func addSubCategory(newitem: Product_category) {
        sub_category.append(newitem)
    }
    
    func getId() -> String {
        return id!
    }
    
    func setId(i: String) {
        id = i
    }
}
