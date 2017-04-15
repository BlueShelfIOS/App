//
//  VShowMagasinViewController.swift
//  ApplicationBlueshelfIOS
//
//  Created by Antoine Millet on 11/04/2017.
//  Copyright © 2017 Antoine Millet. All rights reserved.
//

import UIKit

class VShowMagasinViewController: UIViewController {

    var passedValue = String()
    
    @IBOutlet weak var BtnChooseShop: UIButton!
    @IBOutlet weak var lblAdresse: UILabel!
    @IBOutlet weak var LblMagasin: UILabel!
    @IBOutlet weak var LblVille: UILabel!
    @IBOutlet weak var LblCodePostal: UILabel!
    @IBOutlet weak var LblTelephone: UILabel!
    var ShowMagasin = CShowMagasin()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ShowMagasin.RequestGetInformationMagasin(Id: passedValue)
        if (ModelData.getIdShop() == passedValue)
        {
            self.BtnChooseShop.isEnabled = false
        self.BtnChooseShop.isUserInteractionEnabled = false
            self.BtnChooseShop.alpha = 0.5;
        }
        self.lblAdresse.text = ShowMagasin.getAdresseMagasin()
        self.LblMagasin.text  = ShowMagasin.getNomMagasin()
        self.LblVille.text  = ShowMagasin.getVilleMagasin()
        self.LblTelephone.text  = ShowMagasin.getTelephoneMagasin()
        self.LblCodePostal.text  = ShowMagasin.getCodePostalMagasin()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func ChooseShop_OnClick(_ sender: UIButton) {
        let returnCode = ShowMagasin.RequestPostMagasin()
        if (returnCode == CODE_RETOUR_200)
        {
            let alert = UIAlertController(title: TITRE_POPUP_CONFIRMATION, message: MSG_CONFIRMATION_CHOIX_MAGASIN , preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: BTN_OK, style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            self.BtnChooseShop.isEnabled = false
            self.BtnChooseShop.isUserInteractionEnabled = false
            self.BtnChooseShop.alpha = 0.5;
            return
        }
        if (returnCode == CODE_RETOUR_400)
        {
            let alert = UIAlertController(title: TITRE_POPUP_ERREUR, message: MSG_ERREUR_CONNEXION, preferredStyle: UIAlertControllerStyle.alert)
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
    
}
