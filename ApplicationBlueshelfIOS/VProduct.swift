//
//  VProduct.swift
//  ApplicationBlueshelfIOS
//
//  Created by Antoine Millet on 30/11/2016.
//  Copyright © 2016 Antoine Millet. All rights reserved.
//

import UIKit

class VProduct: UIViewController {

    var passedValue:String = ""
    
    var ProductController = CProduct()
    @IBOutlet weak var LblNameProduct: UILabel!
    @IBOutlet weak var ImgProduct: UIImageView!
    @IBOutlet weak var LblPriceProduct: UILabel!
    @IBOutlet weak var LblDescriptionProduct: UILabel!
    
      override func viewDidLoad() {
        super.viewDidLoad()
        ProductController.RequestProduct(Product: passedValue)
        self.LblNameProduct.text = passedValue
        self.LblPriceProduct.text = ProductController.Price

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
