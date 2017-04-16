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
         self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "bg_login2"))
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func BtnValidate_OnClick(_ sender: Any) {
        if (ControllerForgotenPassword.VerifyEmail(Email: self.TxtbEmail.text!) == false){
            let alert = UIAlertController(title: "Erreur", message: "Adresse mail incorect, Veuillez réesayer.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        let resul = ControllerForgotenPassword.RequestPostResetPassword(Email: self.TxtbEmail.text!)
        if resul == 201
        {
            let alert = UIAlertController(title: "Erreur", message: "Un mail a bien été envoyé à cette adresse.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        if resul == 400
        {
            let alert = UIAlertController(title: "Erreur", message: "Adresse mail incorect, Veuillez réesayer.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
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
