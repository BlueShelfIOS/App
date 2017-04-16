//
//  VContact.swift
//  ApplicationBlueshelfIOS
//
//  Created by Antoine Millet on 16/04/2017.
//  Copyright © 2017 Antoine Millet. All rights reserved.
//

import UIKit

class VContact: UIViewController {

    @IBOutlet weak var ItemMenu: UIBarButtonItem!
    @IBOutlet weak var ItemProfile: UIBarButtonItem!
    var Contact = CContact()
    
    @IBOutlet weak var LblTelephone: UILabel!
    @IBOutlet weak var LblZipcode: UILabel!
    @IBOutlet weak var LblRue: UILabel!
    @IBOutlet weak var LblVille: UILabel!
    @IBOutlet weak var LblName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenus()
        Contact.RequestGetMagasin()
        LblTelephone.text = Contact.getTelephoneMagasin()
        LblZipcode.text = Contact.getCodePostalMagasin()
        LblRue.text = Contact.getAdresseMagasin()
        LblVille.text = Contact.getVilleMagasin()
        LblName.text = Contact.getNomMagasin()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
