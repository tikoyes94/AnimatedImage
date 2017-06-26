//
//  AnimatedImage.swift
//  AnimatedImage
//
//  Created by Tigran Yesayan on 6/26/17.
//  Copyright © 2017 Tigran Yesayan. All rights reserved.
//

import UIKit
import ImageIO
import MobileCoreServices

public class AnimatedImage: NSObject {
    var imageSource: CGImageSource?
    
    public init(url: URL) {
        super.init()
        self.imageSource = CGImageSourceCreateWithURL(url as CFURL, self.imageSourceOptions())
    }
    
    public init(data: Data) {
        super.init()
        self.imageSource = CGImageSourceCreateWithData(data as CFData, self.imageSourceOptions())
    }
    
    private func imageSourceOptions() -> CFDictionary {
        return [kCGImageSourceTypeIdentifierHint as String : kUTTypeGIF,
                kCGImageSourceShouldCache as String : true] as CFDictionary
    }
    
    func imageFor(index: Int) -> CGImage? {
        if let source = self.imageSource {
            return CGImageSourceCreateImageAtIndex(source, index, self.imageSourceOptions())
        }
        return nil
    }
    
    func frameCount() -> Int {
        if let image = self.imageSource {
            return CGImageSourceGetCount(image)
        }
        return 0
    }
    
    func duration() -> CFTimeInterval {
        var fullDuration:CFTimeInterval = 0
        if let source = self.imageSource {
            for i in 0..<frameCount() {
                if let properties = CGImageSourceCopyPropertiesAtIndex(source, i, self.imageSourceOptions()) {
                    if let gifProperties = (properties as Dictionary)[kCGImagePropertyGIFDictionary] {
                        if let duration = gifProperties[kCGImagePropertyGIFUnclampedDelayTime] as? CFTimeInterval {
                            fullDuration += duration
                        } else if let duration = gifProperties[kCGImagePropertyGIFDelayTime] as? CFTimeInterval {
                            fullDuration += duration
                        }
                    }
                }
            }
        }
        return fullDuration
    }
}
