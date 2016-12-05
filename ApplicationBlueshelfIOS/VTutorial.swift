//
//  VTutorial.swift
//  ApplicationBlueshelfIOS
//
//  Created by Maxime Dulin on 11/24/16.
//  Copyright © 2016 Antoine Millet. All rights reserved.
//

import UIKit

class VTutorial: UIViewController {

    @IBOutlet weak var Btn_OpenMenu: UIBarButtonItem!
    
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
