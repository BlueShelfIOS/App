//
//  VHome.swift
//  ApplicationBlueshelfIOS
//
//  Created by Antoine Millet on 04/11/2016.
//  Copyright © 2016 Antoine Millet. All rights reserved.
//

import UIKit

class VHome: UIViewController {


   
    @IBOutlet weak var TxtfUser: UITextField!
    @IBOutlet weak var TxtfPassword: UITextField!
    @IBOutlet weak var BtnValidate: UIButton!
    @IBOutlet weak var BtnForgottenPassword: UIButton!
    @IBOutlet weak var BtnRegister: UIButton!
    var ControllerHome = CHome()
    
    
     override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func TxtfPassword(_ sender: Any) {
        self.TxtfPassword.isSecureTextEntry = true
    }

    @IBAction func showAlertButtonTapped(_ sender: UIButton) {
        
        // create the alert
        let alert = UIAlertController(title: "My Title", message: "This is my message.", preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func BtnValidate_OnClick(_ sender: Any) {
        let UserName = self.TxtfUser.text
        let  Password =  self.TxtfPassword.text
        let resul = ControllerHome.RequestPostConnection(Username: UserName! , PassWord: Password!)
        if resul == 201
        {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "VUser")
            self.present(vc, animated: true, completion: nil)
        }
        if resul == 400
        {
            let alert = UIAlertView()
            alert.title = "Erreur"
            alert.message = "Adresse mail ou mot de passe incorect, Veuillez réesayer."
            alert.addButton(withTitle: "OK")
            alert.show()
        }
        if resul == -1
        {
            let alert = UIAlertView()
            alert.title = "Erreur"
            alert.message = "Une erreur est survenue, Veuillez réesayer ultérieurement."
            alert.addButton(withTitle: "OK")
            alert.show()
        }

    }
    
}

