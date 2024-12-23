//
//  FormVC.swift
//  MittalDhwani-Sem-7-037
//
//  Created by Manthan Mittal on 23/12/2024.
//

import UIKit

class FormVC: UIViewController {

    @IBOutlet weak var textid: UITextField!
    
    @IBOutlet weak var texturl: UITextField!
    
    @IBOutlet weak var textheigth: UITextField!
    
    @IBOutlet weak var textwidth: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitbtn(_ sender: Any) {
        
        let id = textid.text!
        let url = texturl.text!
        let width = Int(textwidth.text!)!
        let heigth = Int(textheigth.text!)!
        
        
        let cat = CatModel(id: id, url: url, width: width, height: heigth)
        DispatchQueue.main.async {
            CatApi().addtocd(catobject: cat)
            self.navigationController?.popViewController(animated: true)
            
        }
    }
    
}



