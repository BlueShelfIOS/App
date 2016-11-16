//
//  VHome.swift
//  ApplicationBlueshelfIOS
//
//  Created by Antoine Millet on 04/11/2016.
//  Copyright © 2016 Antoine Millet. All rights reserved.
//

import UIKit

class VHome: UIViewController {

    @IBOutlet weak var testlbl: UILabel!
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

    @IBAction func BtnValidate_OnClick(_ sender: Any) {
        let UserName = self.TxtfUser.text
        let  Password =  self.TxtfPassword.text
        let resul = ControllerHome.RequestPostConnection(Username: UserName! , PassWord: Password!)
        if resul == 201
        {
            self.testlbl.text = "OK"
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "VUser")

            self.present(vc, animated: true, completion: nil)
            
            //let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            //let uv = storyboard.instantiateViewController(withIdentifier: "VUser") as! VUser;
            //navigationController?.pushViewController(uv, animated: true)
        }
        if resul == 400
        {
            self.testlbl.text = "Error name or password"
        }
        if resul == -1
        {
            self.testlbl.text = "Server Error"
        }

    }
}

