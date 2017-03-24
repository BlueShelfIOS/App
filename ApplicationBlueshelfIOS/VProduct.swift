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
        self.LblDescriptionProduct.text = ProductController.Description

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func AddListOnClick(_ sender: Any) {
       ModelArticle.addElemListeDeCousre(name: ProductController.name, ID: ProductController.ID)
        let alert = UIAlertController(title: "Confirmation", message: "Le produit a été ajouté à votre liste de course.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)

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
