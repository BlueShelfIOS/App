//
//  VHome.swift
//  ApplicationBlueshelfIOS
//
//  Created by Antoine Millet on 04/11/2016.
//  Copyright © 2016 Antoine Millet. All rights reserved.
//

import UIKit

class VConnection: UIViewController {


   
    @IBOutlet weak var TxtfUser: UITextField!
    @IBOutlet weak var TxtfPassword: UITextField!
    @IBOutlet weak var BtnValidate: UIButton!
    @IBOutlet weak var BtnForgottenPassword: UIButton!
    @IBOutlet weak var BtnRegister: UIButton!
    var Connection = CConnection()
    
    
     override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func TxtfPassword(_ sender: Any) {
        self.TxtfPassword.isSecureTextEntry = true
    }

    
    @IBAction func BtnValidate_OnClick(_ sender: Any) {
        if (self.TxtfUser.text == "")
        {
            let alert = UIAlertController(title: TITRE_POPUP_ERREUR, message: MSG_ERREUR_CHAMP_EMAIL_VIDE , preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: BTN_OK, style: UIAlertActionStyle.default, handler: nil))
            return
        }
        if (self.TxtfPassword.text == "")
        {
            let alert = UIAlertController(title: TITRE_POPUP_ERREUR, message: MSG_ERREUR_CHAMP_PASSWORD_VIDE, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: BTN_OK, style: UIAlertActionStyle.default, handler: nil))
            return
        }
        let UserName = self.TxtfUser.text
        let  Password =  self.TxtfPassword.text
        let resul = Connection.RequestPostConnection(Username: UserName! , PassWord: Password!)
        if (resul == CODE_RETOUR_201)
        {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "SWRevealViewController")
            self.present(vc, animated: true, completion: nil)
            return
        }
        else if (resul == CODE_RETOUR_400)
        {
            let alert = UIAlertController(title: TITRE_POPUP_ERREUR, message: MSG_ERREUR_400, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: BTN_OK, style: UIAlertActionStyle.default, handler: nil))
            return
                     }
        else if (resul == CODE_RETOUR_ERREUR_CONNECTION)
        {
            let alert = UIAlertController(title: TITRE_POPUP_ERREUR, message: MSG_ERREUR_CONNEXION, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: BTN_OK, style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
}

