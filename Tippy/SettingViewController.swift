//
//  SettingViewController.swift
//  Tippy
//
//  Created by Svetlana Yarmolik on 8/7/17.
//  Copyright © 2017 Svetlana Yarmolik. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var minPercentageLabel: UITextField!
    @IBOutlet weak var maxPercentageLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
     @IBAction func clearMinField(_ sender: Any) {
     }
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBOutlet weak var colorSchemeSwitch: UISwitch!
    @IBOutlet weak var colorSchemeLabel: UILabel!
    
    // change the settings of the min/max percents
    func changeSettings(){
        let defaults = UserDefaults.standard
        
        let minPercentageValue = Int(minPercentageLabel.text!) ?? 0
        var maxPercentageValue = Int(maxPercentageLabel.text!) ?? 0
        
        if (maxPercentageValue < minPercentageValue){
            maxPercentageValue = minPercentageValue
        }
        defaults.set(minPercentageValue, forKey: "tip_calculator_min_value")
        defaults.set(maxPercentageValue, forKey: "tip_calculator_max_value")
        defaults.synchronize()
    }
    
    // change the color theme swich
    func changeSwitch(){
        let defaults = UserDefaults.standard
        let isDarkColorSchemeOn = colorSchemeSwitch.isOn
        
        defaults.set(isDarkColorSchemeOn, forKey: "tip_calculator_color_scheme")
        defaults.synchronize()
        
        if (isDarkColorSchemeOn){
            colorSchemeLabel.text = "Dark Color Scheme ON"
            colorSchemeLabel.isEnabled = true
        }
        else{
            colorSchemeLabel.text = "Dark Color Scheme OFF"
            colorSchemeLabel.isEnabled = false
        }
    }
    
    // change the color theme
    @IBAction func changeColorScheme(_ sender: Any) {
        changeSwitch()
    }
    
    // clear the max percent field
    @IBAction func clearMaxField(_ sender: Any) {
        maxPercentageLabel.text = ""
    }
    // clear the min percent field
    @IBAction func clearMinField(_ sender: Any) {
        minPercentageLabel.text = ""
    }
    
    @IBAction func settingsChanged(_ sender: Any){
        changeSettings()
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = UserDefaults.standard
        // put the color theme switch in the correct position
        if ( defaults.object(forKey: "tip_calculator_min_value") != nil){
            colorSchemeSwitch.isOn = defaults.bool(forKey: "tip_calculator_color_scheme")
            changeSwitch()
        }
        // put hte min and max values of percents in the fields
        if (defaults.object(forKey: "tip_calculator_min_value") == nil ||
            defaults.object(forKey: "tip_calculator_max_value") == nil){
            // default values
            minPercentageLabel.text = "10"
            maxPercentageLabel.text = "25"
            changeSettings()
        }
        else{
            // values saved in settings
            let minPercentageValue = defaults.integer(forKey: "tip_calculator_min_value")
            let maxPercentageValue = defaults.integer(forKey: "tip_calculator_max_value")
            minPercentageLabel.text = String(format: "%d", minPercentageValue)
            maxPercentageLabel.text = String(format: "%d", maxPercentageValue)
        }
    }
}
