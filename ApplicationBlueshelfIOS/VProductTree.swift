//
//  VProductTree.swift
//  ApplicationBlueshelfIOS
//
//  Created by Maxime Dulin on 11/24/16.
//  Copyright © 2016 Antoine Millet. All rights reserved.
//

import UIKit

class VProductTree: UICollectionViewController {

    @IBOutlet weak var Btn_OpenMenu: UIBarButtonItem!
   
    var ProductTreeController = CProductTree()
    var CategoryArray = Array<Product_category>()
    let reuseIdentifier = "CategoryCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        Btn_OpenMenu.target = self.revealViewController()
        Btn_OpenMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        CategoryArray = ProductTreeController.FindAllCategory()
        
        for cat in CategoryArray {
            print("CATEGORY = " + cat.getId())
            for p in cat.getProducts() {
                print("NAME = " + p.getName() + " - PRICE = " + p.getPrice())
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return CategoryArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection index: Int) -> Int {
        return CategoryArray[index].getProducts().count
    }
    
    /*override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath) as! CategoryCell
        cell.backgroundColor = UIColor.black
        // Configure the cell
        return cell
    }*/

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
