//
//  ViewController.swift
//  First App
//
//  Created by Shravan Shetty on 2/27/18.
//  Copyright © 2018 Shravan Shetty. All rights reserved.
//

import UIKit

enum modes {
    case not_set
    case addition
    case substraction
    case multiplication
}

class ViewController: UIViewController {
    var labelString:String = "0"
    var currentMode:modes = .not_set
    var savedNum:Int = 0
    var lastButtonWasMode:Bool = false
    
    @IBOutlet weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressPlus(_ sender: Any) {
        changeModes(newMode: .addition)
    }
    
    
    @IBAction func didPressSub(_ sender: Any) {
        changeModes(newMode: .substraction)
    }
    
    @IBAction func didPressMulti(_ sender: Any) {
        changeModes(newMode: .multiplication)
    }
    
    @IBAction func didPressEquals(_ sender: Any) {
        guard let labelInt:Int = Int(labelString) else {
            return
        }
        
        if (currentMode == .not_set || lastButtonWasMode) {
            return
        }
        
        if (currentMode == .addition) {
            savedNum += labelInt
        }
        else if (currentMode == .substraction) {
            savedNum -= labelInt
        }
        else if (currentMode == .multiplication) {
            savedNum *= labelInt        }
        
        currentMode = .not_set
        labelString = "\(savedNum)"
        updateText()
    }
    
    @IBAction func didPressClear(_ sender: Any) {
        labelString = "0"
        currentMode = .not_set
        savedNum = 0
        lastButtonWasMode = false
        label.text = "0"
    }
    
    @IBAction func didPressNumber(_ sender: UIButton) {
        let stringValue:String? = sender.titleLabel?.text
        
        if(lastButtonWasMode) {
            lastButtonWasMode = false
            labelString = "0"
        }
        
        labelString = labelString.appending(stringValue!)
        updateText()
    }
    
    
    func updateText() {
        guard let labelInt:Int = Int(labelString) else {
            return
        }
        
        if (currentMode == .not_set) {
            savedNum = labelInt
        }
        
        let formatter:NumberFormatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let num:NSNumber = NSNumber(value: labelInt)
        
        label.text = formatter.string(from: num)
    }

    func changeModes(newMode:modes) {
        if (savedNum == 0) {
            return
        }
        currentMode = newMode
        lastButtonWasMode = true
    }
    
}

