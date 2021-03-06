//
//  VUser.swift
//  ApplicationBlueshelfIOS
//
//  Created by Maxime Dulin on 11/15/16.
//  Copyright © 2016 Antoine Millet. All rights reserved.
//

import UIKit

class VUser: UIViewController {

    @IBOutlet weak var Btn_OpenMenu: UIBarButtonItem!
    @IBOutlet weak var SeDeconnecter: UIButton!
    //@IBOutlet weak var BtnDeconection: UIButton!
    @IBOutlet weak var TF_UserLastName: UITextField!
    @IBOutlet weak var TF_UserEmail: UITextField!
    @IBOutlet weak var TF_UserName: UITextField!
    var ControlerUser = CUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let res = ControlerUser.RequestUser(Token: ModelData.getToken())
        
        if res == 200
        {
            self.TF_UserEmail.text = ModelData.getEmail()
            self.TF_UserName.text = ModelData.getFirstName()
            self.TF_UserLastName.text = ModelData.getLastName()
        }
        
        Btn_OpenMenu.target = self.revealViewController()
        Btn_OpenMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }

    @IBAction func TF_UserNameModified(_ sender: Any) {
        let res = ControlerUser.ModifyUserNameInformation(Name: self.TF_UserName.text!)
        if (res == 200) {

        }
    }
    
    @IBAction func TF_UserLastNameModified(_ sender: Any) {
        let res = ControlerUser.ModifyUserLastNameInformation(LastName: self.TF_UserLastName.text!)
        if (res == 200) {
            
        }
    }
    
    @IBAction func TF_UserEmailModified(_ sender: Any) {
        let res = ControlerUser.ModifyUserEmailInformation(Email: self.TF_UserEmail.text!)
        if (res == 200) {
            
        }
    }
    
    @IBAction func BtnDeconnexion(_ sender: Any) {
        ControlerUser.Deconnection()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func BtnDeconnexion_OnClick(_ sender: Any) {
        ControlerUser.Deconnection()
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "VHome")
        self.present(vc, animated: true, completion: nil)
    }
}
