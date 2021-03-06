//
//  VScannerReading.swift
//  ApplicationBlueshelfIOS
//
//  Created by Maxime Dulin on 11/24/16.
//  Copyright © 2016 Antoine Millet. All rights reserved.
//

// TOTOT TA MERE LA PUTE

import UIKit
import AVFoundation

class VScannerReading: UIViewController, AVCaptureMetadataOutputObjectsDelegate  {

    @IBOutlet weak var Btn_OpenMenu: UIBarButtonItem!
    
    var ScannerController = CScannerReading()
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var nameProduct:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Btn_OpenMenu.target = self.revealViewController()
        Btn_OpenMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())

        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()
        
        let videoCaptureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            scanningNotPossible();
            return;
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypePDF417Code]
        } else {
            scanningNotPossible()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession);
        previewLayer.frame = view.layer.bounds;
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        view.layer.addSublayer(previewLayer);
        
        captureSession.startRunning();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        if let metadataObject = metadataObjects.first {
            let readableObject = metadataObject as! AVMetadataMachineReadableCodeObject;
            
            barcodeDetected(code: readableObject.stringValue);
        }
        
        performSegue(withIdentifier: "VProd2", sender: self)
        
        self.viewDidLoad()
    }
    
    func barcodeDetected(code: String) {
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        captureSession.stopRunning()
        self.captureSession = nil
        
        nameProduct = ScannerController.GetItemByCode(code: code) as String!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "VProd2") {
            // initialize new view controller and cast it as your view controller
            let viewController = segue.destination as! VProduct
            // your new view controller should have property that will store passed value
            viewController.passedValue = nameProduct
        }
    }
    
    func scanningNotPossible() {
        let ac = UIAlertController(title: "Scanner non supporté", message: "Votre appareil doit être muni d'une caméra", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
