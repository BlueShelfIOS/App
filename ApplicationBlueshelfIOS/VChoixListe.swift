//
//  VChoixListe.swift
//  ApplicationBlueshelfIOS
//
//  Created by Antoine Millet on 06/03/2017.
//  Copyright © 2017 Antoine Millet. All rights reserved.
//

import UIKit

class VChoixListe: UITableViewController, UISearchResultsUpdating {
    
    var ListDeCourseNom_Id = [String:String]();
    var ListDeCourseNom = [String]();
    var filteredProduct = [String]()
    var searchController : UISearchController!
    var resultsController = UITableViewController()
    var CListe = CChoixListe()
    
    var valueToPass:String!
    var valueToPass2:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CListe.RequestGetList()
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        ListDeCourseNom = CListe.getListeDeCourseNom()
        self.resultsController.tableView.dataSource = self
        self.resultsController.tableView.delegate = self
        self.searchController = UISearchController(searchResultsController: resultsController)
        self.tableView.tableHeaderView = self.searchController.searchBar
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
         }
    
    
       func updateSearchResults(for searchController: UISearchController) {
        self.filteredProduct = self.ListDeCourseNom.filter {(Name:String) -> Bool in
            if ListDeCourseNom.contains(self.searchController.searchBar.text!){
                return true
            } else {
                return false
            }
        }
        self.resultsController.tableView.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == self.tableView) {
            return self.ListDeCourseNom.count
        }
        else {
            return self.filteredProduct.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if (tableView == self.tableView) {
            cell.textLabel?.text = self.ListDeCourseNom[indexPath.row]
        }
        else  {
            cell.textLabel?.text = self.filteredProduct[indexPath.row]
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
        valueToPass = CListe.getListeProduit(NomListe: (currentCell.textLabel?.text)!)
        valueToPass2 = currentCell.textLabel?.text
        searchController.isActive = false
        performSegue(withIdentifier: "VProd3", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "VProd3")
        {
            let viewController = segue.destination as! VList
            viewController.passedValue = valueToPass
            viewController.NomListe = valueToPass2
        }
    }
    
    @IBAction func ONclickTest(_ sender: Any) {
        print("okey");
    }

       override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
        
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
            var temp1 : String!
            temp1 = currentCell.textLabel?.text
            ListDeCourseNom = ListDeCourseNom.filter(){ $0 != temp1}
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
        
       }
}
