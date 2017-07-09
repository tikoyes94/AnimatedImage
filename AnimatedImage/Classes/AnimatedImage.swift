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
    let cache = NSCache<NSString, CGImage>()
    private(set) lazy var duration: CFTimeInterval = {
        var fullDuration: CFTimeInterval = 0
        if let source = self.imageSource {
            guard let type = CGImageSourceGetType(source) else { return 0 }
            
            var kAnimatedProperty: String!
            var kUnclampedDelayTime: String!
            var kDelayTime: String!
            
            if type == kUTTypeGIF {
                kAnimatedProperty = kCGImagePropertyGIFDictionary as String
                kUnclampedDelayTime = kCGImagePropertyGIFUnclampedDelayTime as String
                kDelayTime = kCGImagePropertyGIFDelayTime as String
            } else if type == kUTTypePNG {
                kAnimatedProperty = kCGImagePropertyPNGDictionary as String
                kUnclampedDelayTime = kCGImagePropertyAPNGUnclampedDelayTime as String
                kDelayTime = kCGImagePropertyAPNGDelayTime as String
            } else {
                return 0
            }
            
            for i in 0 ..< self.frameCount {
                if let properties = CGImageSourceCopyPropertiesAtIndex(source, i, self.imageSourceOptions()) as? [String: Any] {
                    if let gifProperties = properties[kAnimatedProperty] as? [String: Any] {
                        if let duration = gifProperties[kUnclampedDelayTime] as? CFTimeInterval {
                            fullDuration += duration
                        } else if let duration = gifProperties[kDelayTime] as? CFTimeInterval {
                            fullDuration += duration
                        }
                    }
                }
            }
        }
        return fullDuration
    }()
    
    private(set) lazy var frameCount: Int = {
        if let image = self.imageSource {
            return CGImageSourceGetCount(image)
        }
        return 0
    }()
    
    public init(url: URL) {
        super.init()
        self.imageSource = CGImageSourceCreateWithURL(url as CFURL, self.imageSourceOptions())
    }
    
    public init(data: Data) {
        super.init()
        self.imageSource = CGImageSourceCreateWithData(data as CFData, self.imageSourceOptions())
    }
    
    private func imageSourceOptions() -> CFDictionary {
        return [kCGImageSourceShouldCache as String : true,
                kCGImageSourceCreateThumbnailFromImageAlways as String: true] as CFDictionary
    }
    
    func imageFor(index: Int) -> CGImage? {
        if let cachedImage = cache.object(forKey: String(index) as NSString) {
            return cachedImage
        }
        
        if let source = self.imageSource {
            if let image = CGImageSourceCreateThumbnailAtIndex(source, index, self.imageSourceOptions()) {
                self.cache.setObject(image, forKey: String(index) as NSString)
                return image
            }
        }
        return nil
    }
}
