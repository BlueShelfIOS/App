 //
//  ProductTableViewController.swift
//  ApplicationBlueshelfIOS
//
//  Created by Antoine Millet on 29/11/2016.
//  Copyright © 2016 Antoine Millet. All rights reserved.
//

import UIKit

class ProductTableViewController: UITableViewController, UISearchResultsUpdating{
    
    var product = [String]()
    var filteredProduct = [String]()
    var searchController : UISearchController!
    var resultsController = UITableViewController()
    var valueToPass:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        product = RequestProduct(Product: "")
        self.resultsController.tableView.dataSource = self
        self.resultsController.tableView.delegate = self
        self.searchController = UISearchController(searchResultsController: resultsController)
        self.tableView.tableHeaderView = self.searchController.searchBar
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        }
    
    func updateSearchResults(for searchController: UISearchController) {
        /*var Text = searchController.searchBar.text
         Text = Text?.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
         self.product = RequestProduct(Product: Text!)
         self.filteredProduct = self.product*/
        
        self.filteredProduct = self.product.filter {(product:String) -> Bool in
            if product.contains(self.searchController.searchBar.text!){
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
            return self.product.count
        }
        else {
            return self.filteredProduct.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if (tableView == self.tableView) {
            cell.textLabel?.text = self.product[indexPath.row]
        }
        else  {
            cell.textLabel?.text = self.filteredProduct[indexPath.row]
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
        
        valueToPass = currentCell.textLabel?.text
        /*----------------------------------------Problème à regler ---------------------------*/
        searchController.isActive = false // Probleme du fait que si la bar de recherche est active la nouvelle view ne s'affiche pas
        /*-------------------------------------------------------------------------------------*/
        performSegue(withIdentifier: "VProd", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "VProd") {
            // initialize new view controller and cast it as your view controller
            let viewController = segue.destination as! VProduct
            // your new view controller should have property that will store passed value
            viewController.passedValue = valueToPass
        }
    }
    /*---------------------- REQUETE JSON ---------------------------*/
    
    func RequestProduct(Product: String) -> Array<String>{
        var product: Array<String>!
        var urlApi = "https://dev.blueshelf.fr/app_dev.php/api/products?_format=json&name="
        urlApi += Product
        var request = URLRequest(url: URL(string: urlApi)!)
        request.httpMethod = "GET"
        request.setValue(ModelData.getToken(), forHTTPHeaderField: "X-Auth-Token")
        var ReturnCode = 0
        let semaphore = DispatchSemaphore(value: 0)
        let task = URLSession.shared.dataTask(with: request)
        {
            data, response, error in
            guard let data = data, error == nil else
            {
                ReturnCode = -1
                semaphore.signal()
                return // Error Connection
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 200 {
                ReturnCode = 200
                product = self.Deserializer(data: data)
                semaphore.signal()
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 401 {
                ReturnCode = 401
                semaphore.signal()
            }
        }
        task.resume()
        semaphore.wait()
        return(product)
    }
    
    func Deserializer(data: Data) -> Array<String>{
        var product: [String] = []
        var json: Array<Any>!
        do {
            json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? Array
        } catch {
            print(error)
        }
        if json.count > 0 {
            var i = 0
            while (i < json.count){
                if let item = json[i] as? [String: AnyObject] {
                    let name = item["name"] as! String
                    if (name != ""){
                        product.append(name)
                    }
                }
                i += 1
            }
        }
        return (product)
    }
 }
