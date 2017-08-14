//
//  UIView+asImage.swift
//  cardMaker
//
//  Created by swcl on 2017-08-14.
//  Copyright © 2017 Seantastic31. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
