//
//  VInformationUser.swift
//  ApplicationBlueshelfIOS
//
//  Created by Antoine Millet on 12/04/2017.
//  Copyright © 2017 Antoine Millet. All rights reserved.
//

import UIKit

class VInformationUser: UIViewController {

    @IBOutlet weak var lblMagasin: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var LblName: UILabel!
    @IBOutlet weak var ItemProfile: UIBarButtonItem!
    @IBOutlet weak var ItemMenu: UIBarButtonItem!
    var Information = CInformationUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Information.RequestGetInformation()
        sideMenus()
        LblName.text = ModelData.getLastName() + " " + ModelData.getFirstName()
        lblEmail.text = ModelData.getEmail()
        lblMagasin.text = ModelData.getNameMagasin()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        sideMenus()
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
