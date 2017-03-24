//
//  VChoixListe.swift
//  ApplicationBlueshelfIOS
//
//  Created by Antoine Millet on 06/03/2017.
//  Copyright © 2017 Antoine Millet. All rights reserved.
//

import UIKit

class VChoixListe: UITableViewController, UISearchResultsUpdating {
    
    var ListID = [String:Int]();
    var List = [String]();
    var filteredProduct = [String]()
    var searchController : UISearchController!
    var resultsController = UITableViewController()
    
    var valueToPass:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         List = RequestGetList()
        self.resultsController.tableView.dataSource = self
        self.resultsController.tableView.delegate = self
        self.searchController = UISearchController(searchResultsController: resultsController)
        self.tableView.tableHeaderView = self.searchController.searchBar
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        self.filteredProduct = self.List.filter {(Name:String) -> Bool in
            if List.contains(self.searchController.searchBar.text!){
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
            return self.List.count
        }
        else {
            return self.filteredProduct.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if (tableView == self.tableView) {
            cell.textLabel?.text = self.List[indexPath.row]
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
        
        performSegue(withIdentifier: "VProd3", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "VProd3")
        {
            let viewController = segue.destination as! VList
            viewController.passedValue = valueToPass
            
        }
    }
    @IBAction func ONclickTest(_ sender: Any) {
        print("okey");
    }
    func RequestGetList() -> Array<String>
    {
        var product: Array<String>!
        print("yep")
        let urlApi = "https://dev.blueshelf.fr/app_dev.php/api/products/list?_format=json"
        var request = URLRequest(url: URL(string: urlApi)!)
        request.httpMethod = "GET"
        request.setValue(ModelData.getToken(), forHTTPHeaderField: "X-Auth-Token")
        let semaphore = DispatchSemaphore(value: 0)
        let task = URLSession.shared.dataTask(with: request)
        {
            data, response, error in
            guard let _ = data, error == nil else
            {
                
                semaphore.signal()
                return // Error Connection
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 200 {
                let responseString = try? JSONSerialization.jsonObject(with: data!, options: [])
                print("responseString = \(responseString)")
                product = self.Deserializer(data: data!)
                semaphore.signal()
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 401 {
                semaphore.signal()
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 500 {
                semaphore.signal() // Internal error
            }
            
        }
        task.resume()
        semaphore.wait()
        return (product)
    }
    
    func Deserializer(data: Data) -> Array<String>{
       
        var product: [String] = []
        if (ModelArticle.getSizeOfListeDeCourse() > 0) {
            product.append("Nouvelle Liste")
            ListID["Nouvelle Liste"] = -1;
        }
        var json: Array<Any>!
        do {
            json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? Array
        } catch {
            print(error)
        }
        if json.count > 0 {
            var i = 0
            while (i < json.count){
                print (json[i])
                if let item = json[i] as? [String: AnyObject] {
                    let name = item["name"] as! String
                    let id = item["id"] as! Int
                    if (name != ""){
                        product.append(name)
                        ListID[name] = id
                    }
                }
                i += 1
            }
        }
        return (product)
    }

    
       override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
            var temp1 : String!
            temp1 = currentCell.textLabel?.text
            List = List.filter(){ $0 != temp1}
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            
            
            // handle delete (by removing the data from your array and updating the tableview)
        }
        
        
    }
}
