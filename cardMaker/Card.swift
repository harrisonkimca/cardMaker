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
    
    var team: String
    var name: String
    var photo: UIImage?
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("cards")
    
    //MARK: Types
    struct PropertyKey {
        static let team = "team"
        static let name = "name"
        static let photo = "photo"
    }

    init?(team: String, name: String, photo: UIImage?) {
        
        if name.isEmpty || team.isEmpty {
            return nil
        }

        guard !name.isEmpty else {
            return nil
        }
        
        guard !team.isEmpty else {
            return nil
        }
        
        self.team = team
        self.name = name
        self.photo = photo
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(team, forKey: PropertyKey.team)
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
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
        
        self.init(team: team, name: name, photo: photo)
    }
}
