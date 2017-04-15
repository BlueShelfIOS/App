//
//  Home3.swift
//  ApplicationBlueshelfIOS
//
//  Created by Antoine Millet on 10/04/2017.
//  Copyright © 2017 Antoine Millet. All rights reserved.
//

import UIKit

class VHome: UIViewController {

    @IBOutlet weak var ItemProfile: UIBarButtonItem!
    @IBOutlet weak var ItemMenu: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenus()
        if (ModelData.getNameMagasin() == "")
        {
            let alert = UIAlertController(title: TITRE_POPUP_WARNING, message: MSG_CHOIX_MAGASIN_OBLIGATOIR, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: BTN_OK, style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sideMenus()
    {
        if (revealViewController() != nil)
        {
            ItemMenu.target = revealViewController()
            ItemMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 275
            revealViewController().rightViewRevealWidth = 200
            
            ItemProfile.target = revealViewController()
            ItemProfile.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer() )
        }
    }

}
