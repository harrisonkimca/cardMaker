//
//  ViewController.swift
//  cardMaker
//
//  Created by swcl on 2017-08-11.
//  Copyright © 2017 Seantastic31. All rights reserved.
//

import UIKit

class CardBuilderViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var seedData: SeedData!
    
    
    @IBOutlet weak var compositeFrame: UIImageView!
    @IBOutlet weak var frameCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        seedData = SeedData()
        
        // Do any additional setup after loading the view.
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return seedData.frames.count
        
    }
    
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"Cell", for: indexPath)
        if let frameCell = cell as? FrameCollectionViewCell {
            frameCell.frameCellImage.image
                = seedData.frames[indexPath.row].frameImage
            frameCell.backgroundView = UIImageView(image: UIImage(named:"Steve"))
            return frameCell
            
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        compositeFrame.image = seedData.frames[indexPath.row].frameImage
        
        //TODO: Write function to set elements of CompositeView
        //        if let newCard = seedData.frames[indexPath.row] as? Card{
        //        compositeFrame.image = newCard.baseImage
        //        }
        
    }
    
}

func displayComposite(object: Card){
    
}
