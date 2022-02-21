//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var billTextField: UITextField!
    @IBOutlet var zeroPctButton: UIButton!
    @IBOutlet var tenPctButton: UIButton!
    @IBOutlet var twentyPctButton: UIButton!
    @IBOutlet var splitNumberLabel: UILabel!
    
    
    var tip: Double = 0.0
    var numberOfPeople: Int = 2
    var totallBill: Double = 0.0
    var outResult: String = ""
    
    
    
    @IBAction func tipChanged(_ sender: UIButton) {
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        sender.isSelected = true
        
        let buttonTitle = Double((sender.currentTitle?.dropLast())!)
        if let openTip = buttonTitle {
            tip = openTip / 100
        }
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        numberOfPeople = Int(sender.value)
        
    }
    
    @IBAction func calculateButton(_ sender: UIButton) {
        let bill = billTextField.text!
        
        if bill != "" {
            totallBill = Double(bill)!
            let result = (totallBill + (totallBill * tip)) / Double(numberOfPeople)
            outResult = String(format: "%.2f", result)
        }
        
        self.performSegue(withIdentifier: "result", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "result" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.result = outResult
            destinationVC.settings = "Split between \(numberOfPeople) people, with \(Int(tip * 100))% tip"
        }
    }
}

