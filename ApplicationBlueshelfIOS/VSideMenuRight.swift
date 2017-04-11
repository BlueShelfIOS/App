//
//  VSideMenuRight.swift
//  ApplicationBlueshelfIOS
//
//  Created by Antoine Millet on 10/04/2017.
//  Copyright © 2017 Antoine Millet. All rights reserved.
//

import UIKit

class VSideMenuRight: UITableViewController {

    var _CSideMenuRight = CSideMenuRight()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
        var tmp : String!
        tmp = currentCell.textLabel?.text
        if (tmp == "Se deconnecter")
        {
            let alert = UIAlertController(title: TITRE_POPUP_ERREUR, message: MSG_DECONNECTION, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: BTN_OK, style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in self.disconnect()}))
            alert.addAction(UIAlertAction(title: BTN_ANNULER, style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

    }
    func disconnect() {
        _CSideMenuRight.RequestDeleteToken()
        print(_CSideMenuRight.getRetour())
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "Entry")
        self.present(vc, animated: true, completion: nil)

        
    }
}
