//
//  VProductCatalogue.swift
//  ApplicationBlueshelfIOS
//
//  Created by Antoine Millet on 30/11/2016.
//  Copyright © 2016 Antoine Millet. All rights reserved.
//

import UIKit

class VProductCatalogue: UIViewController {

    var passedvalued:String = ""
    
    var ProductController = CProductCatalogue()
    @IBOutlet weak var LblNameProduct: UILabel!
    @IBOutlet weak var ImgProduct: UIImageView!
    @IBOutlet weak var LblPriceProduct: UILabel!
    @IBOutlet weak var LblDescriptionProduct: UILabel!
    
      override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        ProductController.RequestProduct(Product: passedvalued)
        self.LblNameProduct.text = passedvalued
        self.LblPriceProduct.text = ProductController.Price
        self.LblDescriptionProduct.text = ProductController.Description
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func AddListOnClick(_ sender: Any) {
        if (ModelArticle.getMode() == 0) {
            ModelArticle.addElemListeDeCousre(name: ProductController.name, ID: ProductController.ID)
        }
        else if (ModelArticle.getMode() == 1) {
            ModelArticle.addElemListeDeCourseModifié(name: ProductController.name, ID: ProductController.ID)
        }
        let alert = UIAlertController(title: "Confirmation", message: "Le produit a été ajouté à votre liste de course.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
