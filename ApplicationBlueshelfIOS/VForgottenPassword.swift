//
//  VForgottenPassword.swift
//  ApplicationBlueshelfIOS
//
//  Created by Antoine Millet on 16/11/2016.
//  Copyright © 2016 Antoine Millet. All rights reserved.
//

import UIKit

class VForgottenPassword: UIViewController {

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
            let alert = UIAlertView()
            alert.title = "Erreur"
            alert.message = "Adresse mail incorect, Veuillez réesayer."
            alert.addButton(withTitle: "OK")
            alert.show()

            return
        }
        let resul = ControllerForgotenPassword.RequestPostResetPassword(Email: self.TxtbEmail.text!)
        if resul == 201
        {
            let alert = UIAlertView()
            alert.title = "Confirmation"
            alert.message = "Un mail a bien été envoyé à cette adresse."
            alert.addButton(withTitle: "OK")
            alert.show()
        }
        if resul == 400
        {
            let alert = UIAlertView()
            alert.title = "Erreur"
            alert.message = "Adresse mail incorect, Veuillez réesayer."
            alert.addButton(withTitle: "OK")
            alert.show()
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
