//
//  Card.swift
//  cardMaker
//
//  Created by Seantastic31 on 09/08/2017.
//  Copyright © 2017 Seantastic31. All rights reserved.
//

import UIKit
import os.log

class Card: NSObject, NSCoding {
    var team: String?
    var name: String?
    var photo: UIImage?
    var frame: UIImage?
    var pngImage: UIImage?
    var backpngImage: UIImage?
    var position: String?
    var battingDirection: String?
    var throwingHand: String?
    var additionalInfo: String?
    var imgScale: CGFloat = 0.5
    var imgOffSet: CGPoint = CGPoint(x: 0, y: 0)
    var imgRect: CGRect?
    var imgOrigin: CGPoint = CGPoint(x: 0, y: 0)
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("cards")
    
    //MARK: Types
    struct PropertyKey {
        static let team = "team"
        static let name = "name"
        static let photo = "photo"
        static let frame = "frame"
        static let pngImage = "pngImage"
        static let backpngImage = "backpngImage"
        static let position = "position"
        static let battingDirection = "battingDirection"
        static let throwingHand = "throwingHand"
        static let additionalInfo = "additionalInfo"
        static let imgScale = "imgScale"
        static let imgOffSet = "imgOffSet"
        static let imgRect = "imgRect"
        static let imgOrigin = "imgOrigin"
    }
    
    init?(team: String, name: String, photo: UIImage?, frame: UIImage?, pngImage: UIImage?) {
        self.team = team
        self.name = name
        self.photo = photo
        self.frame = frame
        self.pngImage = pngImage
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(team, forKey: PropertyKey.team)
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(frame, forKey: PropertyKey.frame)
        aCoder.encode(pngImage, forKey: PropertyKey.pngImage)
        aCoder.encode(backpngImage, forKey: PropertyKey.backpngImage)
        aCoder.encode(position, forKey: PropertyKey.position)
        aCoder.encode(battingDirection, forKey: PropertyKey.battingDirection)
        aCoder.encode(throwingHand, forKey: PropertyKey.throwingHand)
        aCoder.encode(additionalInfo, forKey: PropertyKey.additionalInfo)
        aCoder.encode(imgScale, forKey: PropertyKey.imgScale)
        aCoder.encode(imgOffSet, forKey: PropertyKey.imgOffSet)
        aCoder.encode(imgRect, forKey: PropertyKey.imgRect)
        aCoder.encode(imgOrigin, forKey: PropertyKey.imgOrigin)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        guard let team = aDecoder.decodeObject(forKey: PropertyKey.team) as? String else {
            os_log("Unable to decode the team for Card object", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for Card object", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage else {
            os_log("Unable to decode the photo for Card object", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let frame = aDecoder.decodeObject(forKey: PropertyKey.frame) as? UIImage else {
            os_log("Unable to decode the frame image for Card object", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let pngImage = aDecoder.decodeObject(forKey: PropertyKey.pngImage) as? UIImage else {
            os_log("Unable to decode the pngImage image for Card object", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let backpngImage = aDecoder.decodeObject(forKey: PropertyKey.backpngImage) as? UIImage else {
         os_log("Unable to decode the backPNG image for Card object", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let position = aDecoder.decodeObject(forKey: PropertyKey.position) as? String else {
            os_log("Unable to decode the position for Card object", log: OSLog.default, type: .debug)
            return nil
        }
        
        
        guard let battingDirection = aDecoder.decodeObject(forKey: PropertyKey.battingDirection) as? String else {
            os_log("Unable to decode the battingDirection for Card object", log: OSLog.default, type: .debug)
            return nil
            }
        
        guard let throwingHand = aDecoder.decodeObject(forKey: PropertyKey.throwingHand) as? String else {
            os_log("Unable to decode the throwingHand for Card object", log: OSLog.default, type: .debug)
            return nil
        }
       
        guard let additionalInfo = aDecoder.decodeObject(forKey: PropertyKey.additionalInfo) as? String else {
            os_log("Unable to decode the additionalInfo for Card object", log: OSLog.default, type: .debug)
            return nil
        }
       
        guard let imgScale = aDecoder.decodeObject(forKey: PropertyKey.imgScale) as? CGFloat else {
            os_log("Unable to decode the imgScale for Card object", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let imgOffSet = aDecoder.decodeObject(forKey: PropertyKey.imgOffSet) as? CGPoint else {
            os_log("Unable to decode the imgOffSet for Card object", log: OSLog.default, type: .debug)
            return nil
        }

        guard let imgRect = aDecoder.decodeObject(forKey: PropertyKey.imgRect) as? CGRect else {
            os_log("Unable to decode the imgRect for Card object", log: OSLog.default, type: .debug)
            return nil
        }
        
        
        guard let imgOrigin = aDecoder.decodeObject(forKey: PropertyKey.imgOrigin) as? CGPoint else {
            os_log("Unable to decode the imgOrigin for Card object", log: OSLog.default, type: .debug)
            return nil
        }
        
        
        self.init(team: team, name: name, photo: photo, frame: frame, pngImage: pngImage)
    }
}
