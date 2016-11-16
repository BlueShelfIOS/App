//
//  VForgottenPassword.swift
//  ApplicationBlueshelfIOS
//
//  Created by Antoine Millet on 16/11/2016.
//  Copyright © 2016 Antoine Millet. All rights reserved.
//

import UIKit

class VForgottenPassword: UIViewController {

    @IBOutlet weak var LblError: UILabel!
    @IBOutlet weak var TxtbEmail: UITextField!
    @IBOutlet weak var BtnValidate: UIButton!
    var ControllerForgotenPassword = CForgottenPassword()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func BtnValidate_OnClick(_ sender: Any) {
        if (ControllerForgotenPassword.VerifyEmail(Email: self.TxtbEmail.text!) == false){
            self.LblError.text = "Veuillez verifier l'adresse email."
            return
        }
        let resul = ControllerForgotenPassword.RequestPostResetPassword(Email: self.TxtbEmail.text!)
        if resul == 201
        {
            self.LblError.text = "OK"
        }
        if resul == 400
        {
            self.LblError.text = "Error name or password"
        }
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
