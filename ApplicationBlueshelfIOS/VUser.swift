//
//  VUser.swift
//  ApplicationBlueshelfIOS
//
//  Created by Maxime Dulin on 11/15/16.
//  Copyright © 2016 Antoine Millet. All rights reserved.
//

import UIKit

class VUser: UIViewController {

    @IBOutlet weak var Lbl_UserName: UILabel!
    @IBOutlet weak var Lbl_UserEmail: UILabel!
    var ControlerUser = CUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let res = ControlerUser.RequestPostConnection(Token: ModelData.getToken())
        
        if res == 201
        {
            print("OK")
        }
        else
        {
            self.Lbl_UserName.text = ModelData.getFirstName() + " " + ModelData.getLastName()
            self.Lbl_UserEmail.text = ModelData.getEmail()
        }
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
