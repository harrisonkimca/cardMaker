//
//  SeedData.swift
//  cardMaker
//
//  Created by swcl on 2017-08-11.
//  Copyright © 2017 Seantastic31. All rights reserved.
//

import UIKit

class SeedData: NSObject {

    var frames:[Frame] = []
    let myImage = UIImage(named: "LighthouseFrame2")
    let myImage2 = UIImage(named: "lighthouseFrame")
    let myImage3 = UIImage(named: "frametrans")
    
    override init() {
//        self.frames = [Frame]()
        super.init()
        
        setUpOverlays()
        
    }
    
    private func setUpOverlays() {
        let frame1 = Frame("frame1", myImage!)
        let frame2 = Frame("frame2", myImage2!)
        let frame3 = Frame("frame3", myImage3!)
        let frame4 = Frame("frame4", myImage!)
        let frame5 = Frame("frame5", myImage2!)
        let frame6 = Frame("frame5", myImage3!)
        let frame7 = Frame("frame5", myImage!)
        let frame8 = Frame("frame5", myImage2!)
        
        
        frames.append(frame1)
        frames.append(frame2)
        frames.append(frame3)
        frames.append(frame4)
        frames.append(frame5)
        frames.append(frame6)
        frames.append(frame7)
        frames.append(frame8)
        
    }

    
}
