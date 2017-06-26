//
//  AnimatedImageLayer.swift
//  AnimatedImage
//
//  Created by Tigran Yesayan on 6/26/17.
//  Copyright © 2017 Tigran Yesayan. All rights reserved.
//

import UIKit
import ImageIO

class AnimatedImageLayer: CALayer {
    var animatedImage: AnimatedImage?
    var index: Int = 0
    override init(layer: Any) {
        super.init(layer: layer)
        if layer is AnimatedImageLayer {
            let animatedLayer = layer as! AnimatedImageLayer
            self.animatedImage = animatedLayer.animatedImage
            self.index = animatedLayer.index
        }
    }
    
    override init() {
        super.init()
    }
    
    override class func needsDisplay(forKey key: String) -> Bool {
        if key == "index" {
            return true
        }
        return super.needsDisplay(forKey: key)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func display() {
        let index = self.presentation()!.index
        self.contents = self.animatedImage?.imageFor(index: index)
    }
}
