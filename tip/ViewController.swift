//
//  ViewController.swift
//  tip
//
//  Created by Monica Yao on 8/17/20.
//  Copyright © 2020 Codepath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var tipPercentageLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var customTip: UISwitch!
    @IBOutlet weak var customTipTextField: UITextField!
    @IBOutlet weak var customTipLabel: UILabel!
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // set initial state of all the parts
        customTip.setOn(false, animated: false)
        onCustomTipTap(self)
        calculateTip(self)
        billAmountTextField.becomeFirstResponder()
    }

    @IBAction func onCustomTipTap(_ sender: Any) {
        if (customTip.isOn){
            customTipTextField.isHidden = false
            customTipLabel.isHidden = false
            tipControl.isHidden = true
        }else{
            customTipTextField.isHidden = true
            customTipLabel.isHidden = true
            tipControl.isHidden = false
        }
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        // Number formatter for the fields
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        
        // Get bill amount
        let bill = Double(billAmountTextField.text!) ?? 0.0
        let customTipValue = Double(customTipTextField.text!) ?? 0.0
        // Calculate tip and total
        var tip = 0.0
        var total = 0.0
        if (customTip.isOn){
            tip = bill * customTipValue / 100
            total = bill + tip
        }else{
            let tipPercentages = [0.15, 0.18, 0.2]
            tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
            total = bill + tip
        }
        // Update tip and total labels
        tipPercentageLabel.text = currencyFormatter.string(from: NSNumber(value:tip))! //String(format: "$%.2f", tip)
        totalLabel.text = currencyFormatter.string(from: NSNumber(value:total))! //String(format: "$%.2f", total)
    }

}

