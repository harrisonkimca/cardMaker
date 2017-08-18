//
//  CardCollectionViewController.swift
//  cardMaker
//
//  Created by Seantastic31 on 09/08/2017.
//  Copyright © 2017 Seantastic31. All rights reserved.
//

import UIKit
import os.log



class CardCollectionViewController:  TisprCardStackViewController, TisprCardStackViewControllerDelegate {
    
    //MARK: Properties
    var cards = [Card]()
    
    fileprivate let colors = [UIColor(red: 45.0/255.0, green: 62.0/255.0, blue: 79.0/255.0, alpha: 1.0),
                              UIColor(red: 48.0/255.0, green: 173.0/255.0, blue: 99.0/255.0, alpha: 1.0),
                              UIColor(red: 141.0/255.0, green: 72.0/255.0, blue: 171.0/255.0, alpha: 1.0),
                              UIColor(red: 241.0/255.0, green: 155.0/255.0, blue: 44.0/255.0, alpha: 1.0),
                              UIColor(red: 234.0/255.0, green: 78.0/255.0, blue: 131.0/255.0, alpha: 1.0),
                              UIColor(red: 80.0/255.0, green: 170.0/255.0, blue: 241.0/255.0, alpha: 1.0)
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedCards = loadCards() {
            cards += savedCards
        }
        //        else {
        //            loadSampleCards()
        //        }
        
        //set animation speed
        setAnimationSpeed(0.85)
        
        //set size of cards
        let size = CGSize(width: view.bounds.width - 40, height: 2*view.bounds.height/3)
        setCardSize(size)
        
        cardStackDelegate = self
        
        //configuration of stacks
        layout.topStackMaximumSize = 4
        layout.bottomStackMaximumSize = 30
        layout.bottomStackCardHeight = 45
    }
    
    //method to add new card
    @IBAction func addNewCards(_ sender: AnyObject) {
        //countOfCards += 1
        newCardWasAdded()
    }
    
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> CardCollectionViewCell {
        
        let reuseIdentifier = "Cell"
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CardCollectionViewCell  else {
            
            fatalError("The deqeued cell is not an instance of CardCollectionViewCell")
        }
        
        let card = cards[indexPath.row]
        cell.photoImageView.image = card.pngImage
        
        return cell
    }
    
    // MARK: - Navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        super.prepare(for: segue, sender: sender)
//        
//        switch (segue.identifier ?? "") {
//            
//        case "AddItem":
//            os_log("Adding a new card", log: OSLog.default, type: .debug)
//            
//            guard let cardDetailViewController = segue.destination as? DetailedCardViewController else {
//                fatalError("Unexpected destination: \(segue.destination)")
//            }
//            
//            guard let selectedCardCell = sender as? CardCollectionViewCell else {
//                fatalError("Unexpected sender: \(String(describing: sender))")
//            }
//            
//            guard let indexPath = collectionView?.indexPath(for: selectedCardCell) else {
//                fatalError("The selected cell is not being displayed by the table")
//            }
//            
//            let selectedCard = cards[indexPath.row]
//            cardDetailViewController.card = selectedCard
//            
//
//            
//            
//        case "ShowDetail":
//            os_log("deleting a card", log: OSLog.default, type: .debug)
//
//            guard let cardDetailViewController = segue.destination as? DetailedCardViewController else {
//                fatalError("Unexpected destination: \(segue.destination)")
//            }
//            
//            guard let selectedCardCell = sender as? CardCollectionViewCell else {
//                fatalError("Unexpected sender: \(String(describing: sender))")
//            }
//            
//            guard let indexPath = collectionView?.indexPath(for: selectedCardCell) else {
//                fatalError("The selected cell is not being displayed by the table")
//            }
//            
//            let selectedCard = cards[indexPath.row]
//            cardDetailViewController.card = selectedCard
//            
//        default:
//            fatalError("Unexpected segue identifier; \(String(describing: segue.identifier))")
//        }
//    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch (segue.identifier ?? "") {
            
        case "AddItem":
            os_log("Adding a new card", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            os_log("deleting a card", log: OSLog.default, type: .debug)

            guard let cardDetailViewController = segue.destination as? DetailedCardViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedCardCell = sender as? CardCollectionViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = collectionView?.indexPath(for: selectedCardCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedCard = cards[indexPath.row]
            cardDetailViewController.card = selectedCard
            
        default:
            fatalError("Unexpected segue identifier; \(String(describing: segue.identifier))")
        }
    }

    //MARK: Actions
    @IBAction func unwindToCardList(sender: UIStoryboardSegue) {
        //If sender is cardViewcontroller
        if let sourceViewController = sender.source as?
            CreateCardViewController, let card = sourceViewController.card {
            
            //            if let selectedIndexPaths = collectionView?.indexPathsForSelectedItems,
            //                let indexPath = selectedIndexPaths.first {
            //
            //                cards[indexPath.row] = card
            //                collectionView?.reloadItems(at: [indexPath])
            //            }
            //            else {
            let newIndexPath = IndexPath(row: cards.count, section: 0)
            
            cards.append(card)
            
            collectionView?.insertItems(at: [newIndexPath])
            //            }
            
            saveCards()
            
        }
        //if sender is detailedCardViewController
        if let sourceViewController = sender.source as?
            DetailedCardViewController, let card = sourceViewController.card {
        let indexToRemove = cards.index(of: card)
        cards.remove(at: indexToRemove!)
        collectionView?.reloadData()
        saveCards()
    }
    }
    
    //    // MARK : Sharing the image
    //    @IBAction func actionButtonTapped(_ sender: Any) {
    //
    //        // image to share
    //
    //        let image: UIImage = currentCard!.pngImage!
    //
    //        // set up activity view controller
    //        let imageToShare = [ image ]
    //        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
    //        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
    //
    //        // exclude some activity types from the list (optional)
    //        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop ]
    //
    //        // present the view controller
    //        self.present(activityViewController, animated: true, completion: nil)
    //    }
    //
    
    
    //MARK: Private Methods
    //    private func loadSampleCards() {
    //        let photo1 = UIImage(named: "IMG_6751")
    //        let photo2 = UIImage(named: "card2")
    //        let photo3 = UIImage(named: "card3")
    //        let photo4 = UIImage(named: "card4")
    //        let photo5 = UIImage(named: "card5")
    //
    //        guard let card1 = Card(team: "Blue Jays", name: "Josh Donaldson", photo: photo1, frame: photo1, pngImage: photo1) else {
    //            fatalError("Unable to instantiate card1")
    //        }
    //
    //        guard let card2 = Card(team: "Blue Jays", name: "Jose Bautista", photo: photo2, frame: nil, pngImage: nil) else {
    //            fatalError("Unable to instantiate card2")
    //        }
    //
    //        guard let card3 = Card(team: "Blue Jays", name: "Russel Martin", photo: photo3, frame: nil, pngImage: nil) else {
    //            fatalError("Unable to instantiate card3")
    //        }
    //
    //        guard let card4 = Card(team: "Chicago Cubs", name: "Kyle Schwarber", photo: photo4, frame: nil, pngImage: nil) else {
    //            fatalError("Unable to instantiate card4")
    //        }
    //
    //        guard let card5 = Card(team: "Blue Jays", name: "Aaron Sanchez", photo: photo5, frame: nil, pngImage: nil) else {
    //            fatalError("Unable to instantiate card5")
    //        }
    //
    //        cards += [card1, card2, card3, card4, card5]
    //    }
    //
    private func saveCards() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(cards, toFile: Card.ArchiveURL.path)
        
        
        if isSuccessfulSave {
            os_log("Cards successfully saved", log: OSLog.default, type: .debug)
        }
        else {
            os_log("Failed to save cards...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadCards() -> [Card]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Card.ArchiveURL.path) as?
            [Card]
    }
    
    @IBAction func moveUP(_ sender: AnyObject) {
        moveCardUp()
    }
    
    @IBAction func moveCardDown(_ sender: AnyObject) {
        moveCardDown()
    }
    
    func cardDidChangeState(_ cardIndex: Int) {
        print("card with index - \(cardIndex) changed position")
    }
}
