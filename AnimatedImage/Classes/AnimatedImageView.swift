//
//  AnimatedImageView.swift
//  AnimatedImage
//
//  Created by Tigran Yesayan on 6/26/17.
//  Copyright © 2017 Tigran Yesayan. All rights reserved.
//

import UIKit

private let kContentChangeAnimation = "__contentChangeAnimation"

public class AnimatedImageView: UIImageView {
    
    public override class var layerClass: AnyClass {
        get {
            return AnimatedImageLayer.self
        }
    }
    
    private var animatedLayer: AnimatedImageLayer {
        return self.layer as! AnimatedImageLayer
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK - Setup
    
    private func setup() -> Void {
        animatedLayer.contentsGravity = kCAGravityResizeAspect
    }
    
    public var animatedImage: AnimatedImage? {
        set {
            animatedLayer.animatedImage = newValue
            animatedLayer.removeAnimation(forKey: kContentChangeAnimation)
            if let image = newValue {
                animatedLayer.add(contentChangeAnimation(frameCount: image.frameCount(), duration: image.duration()), forKey: kContentChangeAnimation)
            }
        }
        
        get {
            return self.animatedLayer.animatedImage
        }
    }
    
    private func contentChangeAnimation(frameCount: Int, duration: CFTimeInterval) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "index")
        animation.fromValue = 0
        animation.toValue = frameCount
        animation.fillMode = kCAFillModeForwards
        animation.repeatCount = Float.infinity
        animation.duration = duration
        return animation
    }
    
    public var paused: Bool {
        set {
            animatedLayer.speed = newValue ? 0 : 1
        }
        
        get {
            return animatedLayer.speed == 0
        }
    }
}
