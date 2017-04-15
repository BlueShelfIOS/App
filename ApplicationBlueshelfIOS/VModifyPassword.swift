//
//  VModifyPassword.swift
//  ApplicationBlueshelfIOS
//
//  Created by Antoine Millet on 13/04/2017.
//  Copyright © 2017 Antoine Millet. All rights reserved.
//

import UIKit

class VModifyPassword: UIViewController {

    
    @IBOutlet weak var TxtfPassword1: UITextField!
    @IBOutlet weak var TxtfPassword2: UITextField!
    var ModifyPassword = CModifyPassword()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func BtnValidate_OnClick(_ sender: UIButton) {
        if (self.TxtfPassword1.text == "" || self.TxtfPassword2.text == "")
        {
            let alert = UIAlertController(title: TITRE_POPUP_ERREUR , message: MSG_ERREUR_CHAMP_PASSWORD_VIDE , preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: BTN_OK, style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if (self.TxtfPassword1.text != self.TxtfPassword2.text) {
            let alert = UIAlertController(title: TITRE_POPUP_ERREUR , message: MSG_ERREUR_PASSWORD_DIFFERENT , preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: BTN_OK, style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        let returnCode = ModifyPassword.requestPatchPAssword(password: self.TxtfPassword1.text!)
        if (returnCode == CODE_RETOUR_200)
        {
            ModelData.setPassword(Password: TxtfPassword1.text!)
            let alert = UIAlertController(title: TITRE_POPUP_CONFIRMATION, message: MSG_CONFIRMATION_PASSWORD_MODIFIE, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: BTN_OK, style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in self.MooveToPreviousView()}))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if (returnCode == CODE_RETOUR_400)
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
            return
        }
    }
    
    func MooveToPreviousView()
    {
        _ = navigationController?.popViewController(animated: true)
    }
}
