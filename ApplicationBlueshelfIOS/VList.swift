//
//  VList.swift
//  ApplicationBlueshelfIOS
//
//  Created by Antoine Millet on 23/02/2017.
//  Copyright © 2017 Antoine Millet. All rights reserved.
//

import UIKit

class VList: UITableViewController, UISearchResultsUpdating{
    var passedValue = String();
    var ListeProduitNom = [String]()
    @IBOutlet weak var BtnSaveList: UIBarButtonItem!
    var filteredProduct = [String]()
    var searchController : UISearchController!
    var resultsController = UITableViewController()
    var valueToPass:String!
    var CListe = CDetailListe()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        CListe.RequestProduct(Product: passedValue)
        ListeProduitNom = CListe.getListProduitNom()
        self.resultsController.tableView.dataSource = self
        self.resultsController.tableView.delegate = self
        self.searchController = UISearchController(searchResultsController: resultsController)
        self.tableView.tableHeaderView = self.searchController.searchBar
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        self.filteredProduct = self.ListeProduitNom.filter {(Name:String) -> Bool in
            if ListeProduitNom.contains(self.searchController.searchBar.text!){
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
            return self.ListeProduitNom.count
        }
        else {
            return self.filteredProduct.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if (tableView == self.tableView) {
            cell.textLabel?.text = self.ListeProduitNom[indexPath.row]
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
        
        valueToPass = currentCell.textLabel?.text
        searchController.isActive = false
        
        performSegue(withIdentifier: "VProd2", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "VProd2")
        {
            let viewController = segue.destination as! VProduct2
            viewController.passedValue = valueToPass
            
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
            ListeProduitNom = ListeProduitNom.filter(){ $0 != temp1}
            ModelArticle.deleteElemListeDeCousre(name: temp1)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            
            
            // handle delete (by removing the data from your array and updating the tableview)
        }
        
    }
}
