//
//  UIImage+asImage2.swift
//  cardMaker
//
//  Created by swcl on 2017-08-14.
//  Copyright © 2017 Seantastic31. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    convenience init(view: UIView){
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: false)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image?.cgImage)!)
    
    
    }

}


