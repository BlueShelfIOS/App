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
            self.LblError.text = "Veuillez remplir tous les champs."
            return
        }
        if (ControllerRegister.VerifyEmail(Email: self.TxtfEmail.text!) == false){
            self.LblError.text = "Veuillez verifier l'adresse email."
            return
        }
        if (ControllerRegister.VerifySamePassword(Password1: self.TxtfPassword1.text!, Password2: self.TxtfPassword2.text!) == false){
            self.LblError.text = "Les deux mots de passes ne sont pas identiques."
            return
        }
        let resul = ControllerRegister.RequestPostRegister(FirstName: name!, LastName: surname!, Password: password1!, Email: email!)
        if resul == 201
        {
            self.LblError.text = "Created"
        }
        if resul == 400
        {
            self.LblError.text = "error"
        }
        if resul == -1
        {
            self.LblError.text  = "Server Error"
        }

    }
}

