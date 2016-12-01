//
//  VRegister.swift
//  ApplicationBlueshelfIOS
//
//  Created by Antoine Millet on 04/11/2016.
//  Copyright © 2016 Antoine Millet. All rights reserved.
//

import UIKit

class VRegister: UIViewController {

   
    @IBOutlet weak var LblError: UILabel!
    @IBOutlet weak var TxtfName: UITextField!
    @IBOutlet weak var TxtfSurname: UITextField!
    @IBOutlet weak var TxtfEmail: UITextField!
    @IBOutlet weak var TxtfPassword1: UITextField!
    @IBOutlet weak var TxtfPassword2: UITextField!
    var ControllerRegister = CRegister()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func TxtPassword1_OnClick(_ sender: Any) {
        self.TxtfPassword1.isSecureTextEntry = true
    }
    
    @IBAction func TxtPassword2_OnClick(_ sender: Any) {
        self.TxtfPassword2.isSecureTextEntry = true
    }
    
    @IBAction func BtnValidate_OnClick(_ sender: Any) {
        
        let name = self.TxtfName.text
        let surname = self.TxtfSurname.text
        let email = self.TxtfEmail.text
        let password1 = self.TxtfPassword1.text
        let password2 = self.TxtfPassword2.text
        if (ControllerRegister.VerifyInputFields(FirstName: name!, LastName: surname!, Email: email!, Password1: password1!, Password2: password2!) == false ){
            let alert = UIAlertController(title: "Erreur", message: "Veuillez remplir tous les champs.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if (ControllerRegister.VerifyEmail(Email: self.TxtfEmail.text!) == false){
            let alert = UIAlertController(title: "Erreur", message: "Adresse mail incorect, Veuillez réesayer.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if (ControllerRegister.VerifySamePassword(Password1: self.TxtfPassword1.text!, Password2: self.TxtfPassword2.text!) == false){
            let alert = UIAlertController(title: "Erreur", message: "Les deux mots sont de passe ne sont pas identiques, Veuillez réesayer.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        let resul = ControllerRegister.RequestPostRegister(FirstName: name!, LastName: surname!, Password: password1!, Email: email!)
        if resul == 201
        {
            let alert = UIAlertController(title: "Erreur", message: "Votre compte a bien été créer.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        if resul == 400
        {
            self.LblError.text = "error"
        }
        if resul == -1
        {
            let alert = UIAlertController(title: "Erreur", message: "Une erreur est survenue, Veuillez réesayer ultérieurement.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

    }
}

