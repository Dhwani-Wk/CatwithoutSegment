//
//  ViewController.swift
//  MittalDhwani-Sem-7-037
//
//  Created by Manthan Mittal on 23/12/2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var colorview: UIView!
    
    @IBOutlet weak var rslider: UISlider!
    
    @IBOutlet weak var gslider: UISlider!
    
    @IBOutlet weak var bslider: UISlider!
    
    @IBOutlet weak var opacityslider: UISlider!
    
    
    private var rValue:CGFloat!
    private var gValue:CGFloat!
    private var bValue:CGFloat!
    private var opacityValue:CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func setColor(r: CGFloat, g: CGFloat, b: CGFloat, o: CGFloat) {
            colorview.backgroundColor =  UIColor(red: r/255, green: g/255, blue: b/255, alpha: o)
        }
    
    func color1(r: CGFloat, g: CGFloat, b: CGFloat, o: CGFloat) {
        
        self.view.backgroundColor = UIColor(red: r/255, green: g/255, blue: b/255, alpha: o)
        
    }
    
    @IBAction func changecolor(_ sender: Any) {
        rValue = CGFloat(rslider.value)
        gValue = CGFloat(gslider.value)
        bValue = CGFloat(bslider.value)
        opacityValue = CGFloat(opacityslider.value)
        
        color1(r: rValue, g: gValue, b: bValue, o: opacityValue)
    }

    @IBAction func red(_ sender: Any) {
        rValue = CGFloat(rslider.value)
        gValue = CGFloat(gslider.value)
        bValue = CGFloat(bslider.value)
        opacityValue = CGFloat(opacityslider.value)
        
        setColor(r: rValue, g: gValue, b: bValue, o: opacityValue)
    }
    
    @IBAction func green(_ sender: Any) {
        rValue = CGFloat(rslider.value)
        gValue = CGFloat(gslider.value)
        bValue = CGFloat(bslider.value)
        opacityValue = CGFloat(opacityslider.value)
        
        setColor(r: rValue, g: gValue, b: bValue, o: opacityValue)
    }
    
    @IBAction func blue(_ sender: Any) {
        rValue = CGFloat(rslider.value)
        gValue = CGFloat(gslider.value)
        bValue = CGFloat(bslider.value)
        opacityValue = CGFloat(opacityslider.value)
        
        setColor(r: rValue, g: gValue, b: bValue, o: opacityValue)
    }
    
    @IBAction func opacity(_ sender: Any) {
        rValue = CGFloat(rslider.value)
        gValue = CGFloat(gslider.value)
        bValue = CGFloat(bslider.value)
        opacityValue = CGFloat(opacityslider.value)
        
        setColor(r: rValue, g: gValue, b: bValue, o: opacityValue)
    }
    
}

