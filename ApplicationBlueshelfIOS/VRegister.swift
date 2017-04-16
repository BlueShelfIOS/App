//
//  VRegister.swift
//  ApplicationBlueshelfIOS
//
//  Created by Antoine Millet on 04/11/2016.
//  Copyright © 2016 Antoine Millet. All rights reserved.
//

import UIKit

class VRegister: UIViewController {

    @IBOutlet weak var TxtfName: UITextField!
    
    @IBOutlet weak var TxtfSurname: UITextField!
    @IBOutlet weak var TxtfEmail: UITextField!
    @IBOutlet weak var TxtfPassword1: UITextField!
    @IBOutlet weak var TxtfPassword2: UITextField!
    var ControllerRegister = CRegister()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "bg_login2"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

   /* func checkTxtInput() -> Int {
        if (self.TxtfName.text == "")
        {
            let alert = UIAlertController(title: TITRE_POPUP_ERREUR , message: MSG_ERREUR_CHAMP_NOM_VIDE , preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: BTN_OK, style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return 0
        }
        if (self.TxtfSurname.text == "")
        {
            let alert = UIAlertController(title: TITRE_POPUP_ERREUR , message: MSG_ERREUR_CHAMP_PRENOM_VIDE , preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: BTN_OK, style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return 0
        }
        if (self.TxtfEmail.text == "")
        {
            let alert = UIAlertController(title: TITRE_POPUP_ERREUR , message: MSG_ERREUR_CHAMP_EMAIL_VIDE , preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: BTN_OK, style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return 0
        }
        if (ControllerRegister.VerifyEmail(Email: self.TxtfEmail.text!) == true)
        {
            let alert = UIAlertController(title: TITRE_POPUP_ERREUR , message: MSG_ERREUR_EMAIL_INVALIDE , preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: BTN_OK, style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return 0
        }
        if (self.TxtfPassword1.text == "" || self.TxtfPassword2.text == "")
        {
            let alert = UIAlertController(title: TITRE_POPUP_ERREUR , message: MSG_ERREUR_CHAMP_PASSWORD_VIDE , preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: BTN_OK, style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return 0
        }
        if (self.TxtfPassword1.text != self.TxtfPassword2.text) {
            let alert = UIAlertController(title: TITRE_POPUP_ERREUR , message: MSG_ERREUR_PASSWORD_DIFFERENT , preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: BTN_OK, style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return 0
        }
        return 1
    }
    @IBAction func BtnValidate_OnClick(_ sender: UIButton) {
        if (checkTxtInput() == 0){
            return
        }
        let returnCode = ControllerRegister.RequestPostRegister(FirstName: self.TxtfName.text!, LastName: self.TxtfSurname.text!, Password: self.TxtfPassword1.text!, Email: self.TxtfEmail.text!)
        if (returnCode == CODE_RETOUR_201)
        {
            let alert = UIAlertController(title: TITRE_POPUP_CONFIRMATION, message: MSG_CONFIRMATION_CREATION_COMPTE, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: BTN_OK, style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in self.RemoveInput()}))
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        if (returnCode == CODE_RETOUR_200)
        {
            let alert = UIAlertController(title: TITRE_POPUP_ERREUR, message: MSG_ERREUR_COMPTE_DEJA_EXISTANT, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: BTN_OK, style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if (returnCode == CODE_RETOUR_ERREUR_CONNECTION)
        {
            let alert = UIAlertController(title: TITRE_POPUP_ERREUR, message: MSG_ERREUR_CONNEXION, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: BTN_OK, style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }

    
    
        func RemoveInput()
        {
            self.TxtfName.text = ""
            self.TxtfSurname.text = ""
            self.TxtfEmail.text = ""
            self.TxtfPassword1.text = ""
            self.TxtfPassword2.text = ""
            
        }*/
}

