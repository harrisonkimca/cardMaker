//
//  BackViewController.swift
//  cardMaker
//
//  Created by swcl on 2017-08-18.
//  Copyright © 2017 Seantastic31. All rights reserved.
//

import UIKit

class BackViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var teamTextField: UITextField!
    
    @IBOutlet weak var positionTextField: UITextField!
    
    @IBOutlet weak var batsTextField: UITextField!
    
    @IBOutlet weak var throwsTextField: UITextField!
    
    
    @IBOutlet weak var infoTextView: UITextView!
    
    var card: Card?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        nameTextField.text = card?.name
        teamTextField.text = card?.team
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func doneButtonTapped(_ sender: Any) {
        
        let name = nameTextField.text
        let team = teamTextField.text
        let position = positionTextField.text
        let bats = batsTextField.text
        let throwingHand = throwsTextField.text
        let info = infoTextView.text
        
        self.card?.name = name
        self.card?.team = team
        self.card?.position = position
        self.card?.battingDirection = bats
        self.card?.throwingHand = throwingHand
        self.card?.additionalInfo = info
        
        self.dismiss(animated: true, completion: nil)
    }
 
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
 

}
