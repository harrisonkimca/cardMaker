//
//  DetailedCardViewController.swift
//  cardMaker
//
//  Created by Zenab Owaid on 8/15/17.
//  Copyright © 2017 Seantastic31. All rights reserved.
//

import UIKit
import os.log


class DetailedCardViewController: UIViewController {
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var frontImageView: UIImageView!
    var isFrontVisible = true
    var card : Card?
    var frontImage : UIImage?
    var currentCard: Card? = nil
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        deleteButton.layer.cornerRadius = 5
        deleteButton.layer.borderWidth = 1
        deleteButton.layer.borderColor = UIColor.white.cgColor
        
        editButton.layer.cornerRadius = 5
        editButton.layer.borderWidth = 1
        editButton.layer.borderColor = UIColor.white.cgColor
        
        shareButton.layer.cornerRadius = 5
        shareButton.layer.borderWidth = 1
        shareButton.layer.borderColor = UIColor.white.cgColor
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(flipLeft(_:)))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(flipRight(_:)))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func flipLeft(_ sender: Any) {
        
        frontImage = UIImage(named: "baseball")
        
        var option: UIViewAnimationOptions = .transitionFlipFromRight
        if ( self.isFrontVisible) {
            self.isFrontVisible = false
            self.frontImageView.image = frontImage
            option = .transitionFlipFromRight
        } else {
            self.isFrontVisible = true
            self.frontImageView.image = UIImage.init(named: "front")
            option = .transitionFlipFromLeft
        }
        
        UIView.transition(with: self.frontImageView, duration: 0.8, options: .transitionFlipFromRight, animations: nil, completion: nil)
    }
    
    
    func flipRight(_ sender: Any) {
        
        frontImage = UIImage(named: "baseball")
        
        var option: UIViewAnimationOptions = .transitionFlipFromLeft
        if ( self.isFrontVisible) {
            self.isFrontVisible = false
            self.frontImageView.image = frontImage
            option = .transitionFlipFromLeft
        } else {
            self.isFrontVisible = true
            self.frontImageView.image = UIImage.init(named: "front")
            option = .transitionFlipFromRight
        }
        
        UIView.transition(with: self.frontImageView, duration: 0.8, options: .transitionFlipFromLeft, animations: nil, completion: nil)
    }
    
 
    @IBAction func ActionButtonTapped(_ sender: UIButton) {
        // image to share
        
        currentCard = card
        
        let image: UIImage = currentCard!.pngImage!
        
        // set up activity view controller
        let imageToShare = [ image ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func deleteButton(_ sender: UIButton) {
        
        // Create the alert
        let alert = UIAlertController(title: "Delete Card", message: "Are you sure you want to delete this card? ", preferredStyle: UIAlertControllerStyle.alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Delete", style: UIAlertActionStyle.default, handler: { action in self.performSegue(withIdentifier: "unwindToCardListWithSender", sender: self)} ))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        // Show the alert
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
////        super.prepare(for: UIStoryboardSegue, sender: sender)
//        
//        let card = self.card
//        
//    }
    
    
    //
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //
    //        super.prepare(for: segue, sender: sender)
    //
    //        guard let button = sender as? UIBarButtonItem, button === deleteButton else {
    //            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
    //            return
    //        }
    //
    //        }
    //
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
                switch (segue.identifier ?? "") {
                    

                case "ShowEdit":
                                os_log("editing a card", log: OSLog.default, type: .debug)
                    
                                guard let cardDetailViewController = segue.destination as? CreateCardViewController else {
                                    fatalError("Unexpected destination: \(segue.destination)")
                                }
                    
//                                guard let selectedCardCell = sender as? editButton else {
//                                    fatalError("Unexpected sender: \(String(describing: sender))")
//                                }
                    
//                                guard let indexPath = collectionView?.indexPath(for: selectedCardCell) else {
//                                    fatalError("The selected cell is not being displayed by the table")
//                                }
                    
                                let selectedCard = card
                                cardDetailViewController.card = selectedCard
                                
                            default:
                                fatalError("Unexpected segue identifier; \(String(describing: segue.identifier))")
                            }

    
    
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
