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
    
// MARK: prepare(for segue)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch (segue.identifier ?? "") {
            
        case "AddItem":
            os_log("Adding a new card", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            os_log("Segue to ShowDetail", log: OSLog.default, type: .debug)

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

    //MARK: UNwind to CardList gets index path if card has been editied so it can replace the old version in the array
    @IBAction func unwindToCardList(sender: UIStoryboardSegue) {
        
        //If sender is cardViewcontroller
        if let sourceViewController = sender.source as?
            CreateCardViewController, let card = sourceViewController.card {
            if let index = cards.index(of: card){ cards[index] = card
            }else{
                cards.insert(card, at: 0)
            }
             collectionView?.reloadData()

            
 //           saveCards()
            
        }
        //if sender is detailedCardViewController
        if let sourceViewController = sender.source as?
            DetailedCardViewController, let card = sourceViewController.card {
        let indexToRemove = cards.index(of: card)
        cards.remove(at: indexToRemove!)
        collectionView?.reloadData()
 //       saveCards()
    }
    }
    
    
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
