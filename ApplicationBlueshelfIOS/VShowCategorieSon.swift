//
//  VShowCategorieSon.swift
//  ApplicationBlueshelfIOS
//
//  Created by Antoine Millet on 15/04/2017.
//  Copyright © 2017 Antoine Millet. All rights reserved.
//

import UIKit

class VShowCategorieSon: UITableViewController {
    
    var passedvalued = String()
    var ValueToPass = String()
    var arrayOfCellData = [cellData]()
    var ShowParentCat = CShowCategorieSon()
    
    override func viewDidLoad() {
        let returnCode = ShowParentCat.RequestGetSonCategorie(parent_id: passedvalued)
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
        if let checkedUrl = URL(string: arrayOfCellData[indexPath.row].ImgSrc ) {
            cell.ImgView.contentMode = .scaleAspectFit
            downloadImage(url: checkedUrl, image: cell.ImgView )
        }
        cell.LblTitle?.text = arrayOfCellData[indexPath.row].LblTitre
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL, image: UIImageView) {
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            DispatchQueue.main.async() { () -> Void in
                image.image = UIImage(data: data)
            }
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        ValueToPass = arrayOfCellData[indexPath.row].Id
        performSegue(withIdentifier: "ShowGrandSon", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let viewController = segue.destination as! VShowGrandSon
        viewController.passedvalued = ValueToPass
    }

}
