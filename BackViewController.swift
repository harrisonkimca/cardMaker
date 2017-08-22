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
    @IBOutlet weak var cardBackView: UIView!

    
    var card: Card?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        if card?.name != nil {
            nameTextField.text = card?.name
        }
        
        if card?.team != nil {
            teamTextField.text = card?.team
        }
        
        if card?.position != nil {
            positionTextField.text = card?.position
        }
        
        if card?.position != nil {
            positionTextField.text = card?.position
        }
        
        if card?.throwingHand != nil {
            throwsTextField.text = card?.throwingHand
        }
        
        if card?.battingDirection != nil {
            batsTextField.text = card?.battingDirection
        }
        
        if card?.additionalInfo != nil {
            infoTextView.text = card?.additionalInfo
        }

        
        
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

        let photo = card?.photo
        let frame = card?.frame
        let pngImage = card?.pngImage
        
        card = Card(team: team!, name: name!, photo: photo!, frame: frame!, pngImage: pngImage!)

        
        self.card?.name = name
        self.card?.team = team
        self.card?.position = position
        self.card?.battingDirection = bats
        self.card?.throwingHand = throwingHand
        self.card?.additionalInfo = info
        self.card?.backpngImage = UIImage.init(view:cardBackView)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let createCardViewController = segue.destination as? CreateCardViewController {
        createCardViewController.card = self.card
        }
    }
}
