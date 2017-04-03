//
//  VAccueil.swift
//  ApplicationBlueshelfIOS
//
//  Created by Maxime Dulin on 11/24/16.
//  Copyright © 2016 Antoine Millet. All rights reserved.
//

import UIKit

class VHome: UIViewController , UISearchBarDelegate{

    @IBOutlet weak var Btn_OpenMenu: UIBarButtonItem!
    @IBOutlet weak var TopBar: UINavigationItem!
    var Home = CHome();


    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = Home.hexStringToUIColor(hex: "#025F64")
        Btn_OpenMenu.target = self.revealViewController()
        Btn_OpenMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
          }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Oh yeah")
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Oh yeah2")
    }*/
   }
