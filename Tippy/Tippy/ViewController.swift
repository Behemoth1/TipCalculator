//
//  ViewController.swift
//  Tippy
//
//  Created by Svetlana Yarmolik on 8/4/17.
//  Copyright © 2017 Svetlana Yarmolik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    
    @IBOutlet weak var tipPercentageLabel: UILabel!
    @IBOutlet weak var tipSlider: UISlider!
    
    @IBOutlet weak var minPercentageLabel: UILabel!
    @IBOutlet weak var maxPercentageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true);
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        let tipPercentage = Double(round(100*tipSlider.value)/100)
        let billTotal = Double(billField.text!) ?? 0
        let tipTotal = billTotal*tipPercentage
        let total = tipTotal + billTotal
        
        tipPercentageLabel.text = String(format: "%.0f%%", tipPercentage*100)
        
        tipLabel.text = String(format: "$%.2f", tipTotal)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    @IBAction func endEditing(_ sender: Any) {
        view.endEditing(true);
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = UserDefaults.standard

        if (defaults.object(forKey: "tip_calculator_min_value") != nil &&            defaults.object(forKey: "tip_calculator_max_value") != nil) {
            let minPercentageValue = defaults.integer(forKey: "tip_calculator_min_value")
            let maxPercentageValue = defaults.integer(forKey: "tip_calculator_max_value")
            tipSlider.minimumValue = Float(minPercentageValue) / 100.00
            tipSlider.maximumValue = Float(maxPercentageValue) / 100.00
        
            minPercentageLabel.text = String(format: "%d%%", minPercentageValue)
            maxPercentageLabel.text = String(format: "%d%%", maxPercentageValue)
        }
    }
    
}

