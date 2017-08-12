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
    @IBOutlet weak var tipPercentageLabel: UILabel!
    @IBOutlet weak var tipSlider: UISlider!
    
    @IBOutlet weak var billField: UITextField!
    
    @IBOutlet weak var minPercentageLabel: UILabel!
    @IBOutlet weak var maxPercentageLabel: UILabel!
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var billView: UIView!
    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var tipView: UIView!
    
    let timeBillAmountSaved = 600 // 10 minutes in seconds
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
    
    
    // calculate the tip amount
    @IBAction func calculateTip(_ sender: Any) {
        let tipPercentage = Double(round(100*tipSlider.value)/100)
        let billTotal = Double(billField.text!) ?? 0
        let tipTotal = billTotal*tipPercentage
        let total = tipTotal + billTotal
        
        // set the current
        tipPercentageLabel.text = String(format: "%.0f%%", tipPercentage*100)

        // calculate the tips and total amount
        tipLabel.text = formatCurrency(value: tipTotal)
        totalLabel.text = formatCurrency(value: total)
    }
    
    @IBAction func endEditing(_ sender: Any) {
        view.endEditing(true);
    }
    
    // format the string
    func formatCurrency(value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale(identifier: Locale.current.identifier)
        let result = formatter.string(from: value as NSNumber)
        return result!
    }
    
    // function to get the number from fotmatted string
    func removeFormatAmount(str: String) -> Double {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale(identifier: Locale.current.identifier)
        return formatter.number(from: str) as! Double? ?? 0
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let defaults = UserDefaults.standard
        
        // save the bill amount in user defaults for future re-use of app        
        defaults.set(billField.text!, forKey: "tip_calculator_bill_amount")
        defaults.set(Date(), forKey: "tip_calculator_bill_time")
        defaults.synchronize()
    }
    
    // animate the view
    func viewAnimate() {
        UIView.animate(withDuration: 1.0, animations: {
            self.totalView.alpha = 1
            self.tipView.alpha = 1
            self.billView.alpha = 1
        })
    }
    

    
   // function to change the theme to dark
   func makeDarkTheme() {
        let blackColor = UIColor.black
        self.mainView.backgroundColor = blackColor
    }
 
    // function to change the theme to light
    func makeLightTheme() {
        let whiteColor = UIColor.white
        self.mainView.backgroundColor = whiteColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = UserDefaults.standard

        // put the initial values for animation
        self.totalView.alpha = 0
        self.tipView.alpha = 0
        self.billView.alpha = 0
        
        // set the focus to the bill amount field
        billField.becomeFirstResponder()
        
        //set the corresponding color theme
        if ( defaults.object(forKey: "tip_calculator_min_value") != nil){
            let isDarkThemeOn = defaults.bool(forKey: "tip_calculator_color_scheme") 
            if (isDarkThemeOn){
                makeDarkTheme()
            }
            else{
                makeLightTheme()
            }
        }

        // if the defaults values of min and max are saved - use them in the view
        if (defaults.object(forKey: "tip_calculator_min_value") != nil &&
            defaults.object(forKey: "tip_calculator_max_value") != nil) {
            let minPercentageValue = defaults.integer(forKey: "tip_calculator_min_value")
            let maxPercentageValue = defaults.integer(forKey: "tip_calculator_max_value")
            tipSlider.minimumValue = Float(minPercentageValue) / 100.00
            tipSlider.maximumValue = Float(maxPercentageValue) / 100.00
        
            minPercentageLabel.text = String(format: "%d%%", minPercentageValue)
            maxPercentageLabel.text = String(format: "%d%%", maxPercentageValue)
        }
        
        // restore saved the bill amount
        if (defaults.object(forKey: "tip_calculator_bill_amount") != nil){
            let date = defaults.object(forKey: "tip_calculator_bill_time") as? Date ?? Date()
            let elapsedTime = Int(Date().timeIntervalSince(date))
            
            if (elapsedTime <= timeBillAmountSaved){
                billField.text = defaults.string(forKey: "tip_calculator_bill_amount")
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewAnimate()
    }

    
}

