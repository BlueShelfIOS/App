//
//  VBugReport.swift
//  ApplicationBlueshelfIOS
//
//  Created by Maxime Dulin on 4/5/17.
//  Copyright © 2017 Antoine Millet. All rights reserved.
//

import Foundation
import MessageUI

class VBugReport : UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var Btn_OpenMenu: UIBarButtonItem!
    @IBOutlet weak var Picker_ViewSelection: UIPickerView!
    
    @IBOutlet weak var TF_Description: UITextField!
    @IBOutlet weak var Btn_Send: UIButton!
    var PickerData: [String] = [String]()
    
    override func viewDidLoad() {
        PickerData = ["Accueil", "Scanner", "Liste des rayons", "Contact", "Tutorial", "Mot de passe oublié", "Page produit", "Nouveautés", "Trouver un magasin"]
        super.viewDidLoad()
        Btn_OpenMenu.target = self.revealViewController()
        Btn_OpenMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func Send(_ sender: Any) {
        let toRecipients = ["maximedulin@gmail.com"]
        
        let mc:MFMailComposeViewController = MFMailComposeViewController()
        
        mc.mailComposeDelegate = self
        
        mc.setToRecipients(toRecipients)
        
        let selectedValue = PickerData[Picker_ViewSelection.selectedRow(inComponent: 0)]
        
        mc.setSubject("[BUG REPORT] : \(selectedValue)")
        
        mc.setMessageBody("Message : \(TF_Description.text)", isHTML: false)
        
        self.present(mc, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result.rawValue {
        case MFMailComposeResult.cancelled.rawValue:
            print("Cancelled")
        case MFMailComposeResult.failed.rawValue:
            print("Failed")
        case MFMailComposeResult.saved.rawValue:
            print("Saved")
        case MFMailComposeResult.sent.rawValue:
            print("sent")
        default:
            break
            
        }
        
        self.dismiss(animated: true, completion: nil)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 9
    }
    
    @IBAction func DismissKeyboard(_ sender: Any) {
        self.resignFirstResponder()
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return PickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return PickerData[row]
    }

}
