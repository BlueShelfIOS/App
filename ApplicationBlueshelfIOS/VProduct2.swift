//
//  VProduct2.swift
//  ApplicationBlueshelfIOS
//
//  Created by Antoine Millet on 24/02/2017.
//  Copyright © 2017 Antoine Millet. All rights reserved.
//

import UIKit

class VProduct2: UIViewController {

    @IBOutlet weak var ImgProduct: UIImageView!
    @IBOutlet weak var LblDescription: UILabel!
    @IBOutlet weak var LblPriceProduct: UILabel!
    @IBOutlet weak var LblNameProduct: UILabel!
    @IBOutlet weak var BtnDeleteArticle: UIButton!
    
    
    var passedValue:String = "";
    var ProductController = CProductCatalogue()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProductController.RequestProduct(Product: passedValue)
        self.LblNameProduct.text = passedValue
        self.LblPriceProduct.text = ProductController.Price
        self.LblDescription.text = ProductController.Description

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func DelArtOnClick(_ sender: Any) {
        print(LblNameProduct.text!);
        
    }
  }
