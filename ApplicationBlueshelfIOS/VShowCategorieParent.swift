//
//  VShowCategorieParent.swift
//  ApplicationBlueshelfIOS
//
//  Created by Antoine Millet on 15/04/2017.
//  Copyright © 2017 Antoine Millet. All rights reserved.
//

import UIKit

struct cellData{
    var ImgSrc = String()
    var LblTitre = String()
    var Id = String()
    var parent_id = String()
}


class VShowCategorieParent: UITableViewController {

    @IBOutlet weak var ItemProfile: UIBarButtonItem!
    @IBOutlet weak var ItemMenu: UIBarButtonItem!

    var ValueToPass = String()
    var arrayOfCellData = [cellData]()
    var ShowParentCat = CShowCategorieParent()
    
    override func viewDidLoad() {
        sideMenus()
    let returnCode = ShowParentCat.RequestGetParentCategorie()
        if (returnCode == CODE_RETOUR_200)
        {
            self.arrayOfCellData = ShowParentCat.getArrayOfCellData()
        }
        if (returnCode == CODE_RETOUR_400)
        {
            let alert = UIAlertController(title: TITRE_POPUP_ERREUR, message: MSG_ERREUR_CONNEXION, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: BTN_OK, style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if (returnCode == CODE_RETOUR_ERREUR_CONNECTION)
        {
            let alert = UIAlertController(title: TITRE_POPUP_ERREUR, message: MSG_ERREUR_CONNEXION, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: BTN_OK, style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfCellData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("CustomCell", owner: self, options: nil)?.first as! CustomCell
        //cell.ImgView.image = arrayOfCellData[indexPath.row].ImgSrc
        cell.LblTitle?.text = arrayOfCellData[indexPath.row].LblTitre
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        ValueToPass = arrayOfCellData[indexPath.row].Id
            performSegue(withIdentifier: "ShowSon", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let viewController = segue.destination as! VShowCategorieSon
        viewController.passedvalued = ValueToPass
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
