//
//  Frame.swift
//  cardMaker
//
//  Created by swcl on 2017-08-11.
//  Copyright © 2017 Seantastic31. All rights reserved.
//

import UIKit

class Frame: NSObject {

    var frameName: String
    var frameImage: UIImage
    
    
    init(_ imageName: String, _ image: UIImage){
        frameName = imageName
        frameImage = image
    }
    
    
}
