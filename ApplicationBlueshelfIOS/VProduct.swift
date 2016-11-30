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
    
      override func viewDidLoad() {
        super.viewDidLoad()
        print ("OHH yeah = \(self.passedValue)")

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
