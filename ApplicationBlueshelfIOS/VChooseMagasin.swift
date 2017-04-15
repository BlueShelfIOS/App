//
//  VChooseMagasin.swift
//  ApplicationBlueshelfIOS
//
//  Created by Antoine Millet on 11/04/2017.
//  Copyright © 2017 Antoine Millet. All rights reserved.
//

import UIKit

class VChooseMagasin: UITableViewController, UISearchResultsUpdating {

    var ListMagasinNom_Id = [String:String]();
    var ListMagasinNom = [String]();
    var filteredMagasin = [String]()
    var searchController : UISearchController!
    var resultsController = UITableViewController()
    var CListe = CChooseMagasin()
    var valueToPass:String!
    
    @IBOutlet weak var ItemMenu: UIBarButtonItem!
    @IBOutlet weak var ItemProfile: UIBarButtonItem!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        CListe.RequestGetListMagasin()
        ListMagasinNom = CListe.getListeMagasinNom()
        self.resultsController.tableView.dataSource = self
        self.resultsController.tableView.delegate = self
        self.searchController = UISearchController(searchResultsController: resultsController)
        self.tableView.tableHeaderView = self.searchController.searchBar
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Rechercher un magasin par ville, code postal..."
        sideMenus()
    }

    func updateSearchResults(for searchController: UISearchController)
    {
        if (isNumeric(str: self.searchController.searchBar.text!) == true)
        {
             self.filteredMagasin = CListe.RequestGetListMagasinByZipCode(zipcode: self.searchController.searchBar.text!)
            for element in filteredMagasin {
                print(element)
            }
        }
        else
        {
           self.filteredMagasin = CListe.RequestGetListMagasinByCity(city: self.searchController.searchBar.text!)
        }
        print("fin")
        self.resultsController.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == self.tableView) {
            return self.ListMagasinNom.count
        }
        else {
            return self.filteredMagasin.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if (tableView == self.tableView) {
            cell.textLabel?.text = self.ListMagasinNom[indexPath.row]
        }
        else  {
            cell.textLabel?.text = self.filteredMagasin[indexPath.row]
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
        valueToPass = CListe.getIdMagasin(NomListe: (currentCell.textLabel?.text)!)
        searchController.isActive = false
        performSegue(withIdentifier: "VMagasin", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "VMagasin")
        {
            let viewController = segue.destination  as! VShowMagasinViewController
            viewController.passedValue = valueToPass
        }
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
            var temp1 : String!
            temp1 = currentCell.textLabel?.text
            ListMagasinNom = ListMagasinNom.filter(){ $0 != temp1}
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
        
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
    
    func isNumeric(str: String) -> Bool {
        let num = Int(str);
        if num != nil {
            return true
        }
        else {
            return false
        }
    }
}
