//
//  CardCollectionViewCell.swift
//  cardMaker
//
//  Created by Seantastic31 on 09/08/2017.
//  Copyright © 2017 Seantastic31. All rights reserved.
//

import UIKit


class CardCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var text: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 12
        clipsToBounds = false
        
    }
    
    override var center: CGPoint {
        didSet {
            updateSmileVote()
        }
    }
    

    func updateSmileVote() {
//        let rotation = atan2(transform.b, transform.a) * 100
//        var smileImageName = "smile_neutral"
        
//        if rotation > 15 {
//            smileImageName = "smile_face_2"
//        } else if rotation > 0 {
//            smileImageName = "smile_face_1"
//        } else if rotation < -15 {
//            smileImageName = "smile_rotten_2"
//        } else if rotation < 0 {
//            smileImageName = "smile_rotten_1"
//        }
        
        //photoImageView.image = UIImage(named: )
    }
    
    override open func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        let center = layoutAttributes.center
        let animation = CABasicAnimation(keyPath: "position.y")
        animation.toValue = center.y
        animation.duration = 0.3
        animation.timingFunction = CAMediaTimingFunction(controlPoints: 0.8, 2.0, 1.0, 1.0)
        layer.add(animation, forKey: "position.y")
        
        super.apply(layoutAttributes)
    }

    
}
