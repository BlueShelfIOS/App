//
//  VUser.swift
//  ApplicationBlueshelfIOS
//
//  Created by Maxime Dulin on 11/15/16.
//  Copyright © 2016 Antoine Millet. All rights reserved.
//

import UIKit

class VUser: UIViewController {

    @IBOutlet weak var SeDeconnecter: UIButton!
    //@IBOutlet weak var BtnDeconection: UIButton!
    @IBOutlet weak var Lbl_UserName: UILabel!
    @IBOutlet weak var Lbl_UserEmail: UILabel!
    var ControlerUser = CUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let res = ControlerUser.RequestUser(Token: ModelData.getToken())
        
        if res == 200
        {
            self.Lbl_UserEmail.text = ModelData.getEmail()
            self.Lbl_UserName.text = "M." + ModelData.getFirstName() + " " + ModelData.getLastName()
            print("OK")
        }
    }

    @IBAction func BtnDeconnexion(_ sender: Any) {
        ControlerUser.Deconnection()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func BtnDeconnexion_OnClick(_ sender: Any) {
        ControlerUser.Deconnection()
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "VHome")
        self.present(vc, animated: true, completion: nil)

    }
}
