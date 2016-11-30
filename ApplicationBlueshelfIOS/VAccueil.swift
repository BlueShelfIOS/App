//
//  VAccueil.swift
//  ApplicationBlueshelfIOS
//
//  Created by Maxime Dulin on 11/24/16.
//  Copyright © 2016 Antoine Millet. All rights reserved.
//

import UIKit

class VAccueil: UIViewController , UISearchBarDelegate{

    @IBOutlet weak var Btn_OpenMenu: UIBarButtonItem!


    override func viewDidLoad() {
        super.viewDidLoad()
        Btn_OpenMenu.target = self.revealViewController()
        Btn_OpenMenu.action = Selector("revealToggle:")
        
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
          }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Oh yeah")
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Oh yeah2")
    }
   
}
