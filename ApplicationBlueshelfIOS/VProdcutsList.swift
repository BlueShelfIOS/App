//
//  VProdcutsList.swift
//  ApplicationBlueshelfIOS
//
//  Created by Maxime Dulin on 2/28/17.
//  Copyright © 2017 Antoine Millet. All rights reserved.
//

import Foundation

class VProductsList : UITableViewController {
    @IBOutlet var Btn_OpenMenu: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Btn_OpenMenu.target = self.revealViewController()
        Btn_OpenMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
