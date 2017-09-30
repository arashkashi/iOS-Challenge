//
//  PaintCode.swift
//  JodelChallenge
//
//  Created by Arash K. on 2017-09-28.
//  Copyright © 2017 Jodel. All rights reserved.
//

import Foundation
import UIKit



class Add: NSObject {
  
  
  //MARK: - Canvas Drawings
  
  /// Page 1
  
  class func draw(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 45, height: 45), resizing: ResizingBehavior = .aspectFit) {
    /// General Declarations
    let context = UIGraphicsGetCurrentContext()!
    
    /// Resize to Target Frame
    context.saveGState()
    let resizedFrame = resizing.apply(rect: CGRect(x: 0, y: 0, width: 45, height: 45), target: targetFrame)
    context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
    context.scaleBy(x: resizedFrame.width / 45, y: resizedFrame.height / 45)
    
    /// Oval
    let oval = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45))
    context.saveGState()
    UIColor(hue: 0.133, saturation: 1, brightness: 1, alpha: 1).setFill()
    oval.fill()
    context.saveGState()
    oval.lineWidth = 2
    context.beginPath()
    context.addPath(oval.cgPath)
    context.clip(using: .evenOdd)
    UIColor(hue: 1, saturation: 0.907, brightness: 0.892, alpha: 1).setStroke()
    oval.stroke()
    context.restoreGState()
    context.restoreGState()
    /// cancel
    let cancel2 = UIBezierPath()
    cancel2.move(to: CGPoint(x: 0.15, y: 2.91))
    cancel2.addLine(to: CGPoint(x: 5.72, y: 8.43))
    cancel2.addLine(to: CGPoint(x: 0.15, y: 13.95))
    cancel2.addCurve(to: CGPoint(x: 0.14, y: 14.63), controlPoint1: CGPoint(x: -0.05, y: 14.14), controlPoint2: CGPoint(x: -0.05, y: 14.44))
    cancel2.addLine(to: CGPoint(x: 2.24, y: 16.71))
    cancel2.addCurve(to: CGPoint(x: 2.93, y: 16.71), controlPoint1: CGPoint(x: 2.43, y: 16.9), controlPoint2: CGPoint(x: 2.74, y: 16.9))
    cancel2.addLine(to: CGPoint(x: 8.5, y: 11.19))
    cancel2.addLine(to: CGPoint(x: 14.07, y: 16.71))
    cancel2.addCurve(to: CGPoint(x: 14.76, y: 16.71), controlPoint1: CGPoint(x: 14.26, y: 16.9), controlPoint2: CGPoint(x: 14.57, y: 16.9))
    cancel2.addLine(to: CGPoint(x: 16.86, y: 14.63))
    cancel2.addCurve(to: CGPoint(x: 16.85, y: 13.95), controlPoint1: CGPoint(x: 17.05, y: 14.44), controlPoint2: CGPoint(x: 17.05, y: 14.14))
    cancel2.addLine(to: CGPoint(x: 11.28, y: 8.43))
    cancel2.addLine(to: CGPoint(x: 16.85, y: 2.91))
    cancel2.addCurve(to: CGPoint(x: 16.86, y: 2.22), controlPoint1: CGPoint(x: 17.05, y: 2.72), controlPoint2: CGPoint(x: 17.05, y: 2.41))
    cancel2.addLine(to: CGPoint(x: 14.76, y: 0.14))
    cancel2.addCurve(to: CGPoint(x: 14.07, y: 0.15), controlPoint1: CGPoint(x: 14.57, y: -0.05), controlPoint2: CGPoint(x: 14.26, y: -0.05))
    cancel2.addLine(to: CGPoint(x: 8.5, y: 5.67))
    cancel2.addLine(to: CGPoint(x: 2.93, y: 0.15))
    cancel2.addCurve(to: CGPoint(x: 2.24, y: 0.14), controlPoint1: CGPoint(x: 2.74, y: -0.04), controlPoint2: CGPoint(x: 2.43, y: -0.05))
    cancel2.addLine(to: CGPoint(x: 0.14, y: 2.22))
    cancel2.addCurve(to: CGPoint(x: 0.15, y: 2.91), controlPoint1: CGPoint(x: -0.05, y: 2.41), controlPoint2: CGPoint(x: -0.05, y: 2.71))
    cancel2.addLine(to: CGPoint(x: 0.15, y: 2.91))
    cancel2.close()
    cancel2.move(to: CGPoint(x: 0.15, y: 2.91))
    context.saveGState()
    context.translateBy(x: 22.5, y: 22.43)
    context.rotate(by: 405 * CGFloat.pi/180)
    context.translateBy(x: -8.5, y: -8.43)
    cancel2.usesEvenOddFillRule = true
    UIColor.white.setFill()
    cancel2.fill()
    context.restoreGState()
    
    context.restoreGState()
  }
  
  
  //MARK: - Canvas Images
  
  /// Page 1
  
  class func image(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 45, height: 45), resizing: ResizingBehavior = .aspectFit) -> UIImage {
    struct LocalCache {
      static var image: UIImage!
    }
    var image: UIImage
    
    UIGraphicsBeginImageContextWithOptions(CGSize(width: targetFrame.size.width, height: targetFrame.size.width), false, 0)
    Add.draw(frame: targetFrame, resizing: resizing)
    image = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    
    return image
  }
  
  
  //MARK: - Resizing Behavior
  
  enum ResizingBehavior {
    case aspectFit /// The content is proportionally resized to fit into the target rectangle.
    case aspectFill /// The content is proportionally resized to completely fill the target rectangle.
    case stretch /// The content is stretched to match the entire target rectangle.
    case center /// The content is centered in the target rectangle, but it is NOT resized.
    
    func apply(rect: CGRect, target: CGRect) -> CGRect {
      if rect == target || target == CGRect.zero {
        return rect
      }
      
      var scales = CGSize.zero
      scales.width = abs(target.width / rect.width)
      scales.height = abs(target.height / rect.height)
      
      switch self {
      case .aspectFit:
        scales.width = min(scales.width, scales.height)
        scales.height = scales.width
      case .aspectFill:
        scales.width = max(scales.width, scales.height)
        scales.height = scales.width
      case .stretch:
        break
      case .center:
        scales.width = 1
        scales.height = 1
      }
      
      var result = rect.standardized
      result.size.width *= scales.width
      result.size.height *= scales.height
      result.origin.x = target.minX + (target.width - result.width) / 2
      result.origin.y = target.minY + (target.height - result.height) / 2
      return result
    }
  }
  
  
}


//
//  Cancel.swift
//
//  Created on 1/8/17.
//
//  Generated by PaintCode Plugin for Sketch
//  http://www.paintcodeapp.com/sketch
//

import UIKit



class Cancel: NSObject {
  
  
  //MARK: - Canvas Drawings
  
  /// Page 1
  
  class func draw(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 45, height: 45), resizing: ResizingBehavior = .aspectFit) {
    
    /// General Declarations
    let context = UIGraphicsGetCurrentContext()!
    
    /// Resize to Target Frame
    context.saveGState()
    let resizedFrame = resizing.apply(rect: CGRect(x: 0, y: 0, width: 45, height: 45), target: targetFrame)
    context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
    context.scaleBy(x: resizedFrame.width / 45, y: resizedFrame.height / 45)
    
    /// Oval
    let oval = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45))
    context.saveGState()
    UIColor(hue: 0.009, saturation: 0.812, brightness: 1, alpha: 1).setFill()
    oval.fill()
    context.restoreGState()
    /// cancel
    let cancel2 = UIBezierPath()
    cancel2.move(to: CGPoint(x: 0.17, y: 3.42))
    cancel2.addLine(to: CGPoint(x: 6.72, y: 9.91))
    cancel2.addLine(to: CGPoint(x: 0.17, y: 16.41))
    cancel2.addCurve(to: CGPoint(x: 0.17, y: 17.21), controlPoint1: CGPoint(x: -0.05, y: 16.63), controlPoint2: CGPoint(x: -0.06, y: 16.99))
    cancel2.addLine(to: CGPoint(x: 2.64, y: 19.66))
    cancel2.addCurve(to: CGPoint(x: 3.45, y: 19.66), controlPoint1: CGPoint(x: 2.86, y: 19.88), controlPoint2: CGPoint(x: 3.22, y: 19.88))
    cancel2.addLine(to: CGPoint(x: 10, y: 13.16))
    cancel2.addLine(to: CGPoint(x: 16.55, y: 19.66))
    cancel2.addCurve(to: CGPoint(x: 17.36, y: 19.66), controlPoint1: CGPoint(x: 16.78, y: 19.88), controlPoint2: CGPoint(x: 17.14, y: 19.89))
    cancel2.addLine(to: CGPoint(x: 19.83, y: 17.21))
    cancel2.addCurve(to: CGPoint(x: 19.83, y: 16.41), controlPoint1: CGPoint(x: 20.06, y: 16.99), controlPoint2: CGPoint(x: 20.05, y: 16.63))
    cancel2.addLine(to: CGPoint(x: 13.28, y: 9.91))
    cancel2.addLine(to: CGPoint(x: 19.83, y: 3.42))
    cancel2.addCurve(to: CGPoint(x: 19.83, y: 2.62), controlPoint1: CGPoint(x: 20.05, y: 3.19), controlPoint2: CGPoint(x: 20.06, y: 2.84))
    cancel2.addLine(to: CGPoint(x: 17.36, y: 0.16))
    cancel2.addCurve(to: CGPoint(x: 16.55, y: 0.17), controlPoint1: CGPoint(x: 17.14, y: -0.06), controlPoint2: CGPoint(x: 16.78, y: -0.05))
    cancel2.addLine(to: CGPoint(x: 10, y: 6.67))
    cancel2.addLine(to: CGPoint(x: 3.45, y: 0.17))
    cancel2.addCurve(to: CGPoint(x: 2.64, y: 0.16), controlPoint1: CGPoint(x: 3.22, y: -0.05), controlPoint2: CGPoint(x: 2.86, y: -0.06))
    cancel2.addLine(to: CGPoint(x: 0.17, y: 2.62))
    cancel2.addCurve(to: CGPoint(x: 0.17, y: 3.42), controlPoint1: CGPoint(x: -0.06, y: 2.84), controlPoint2: CGPoint(x: -0.05, y: 3.19))
    cancel2.addLine(to: CGPoint(x: 0.17, y: 3.42))
    cancel2.close()
    cancel2.move(to: CGPoint(x: 0.17, y: 3.42))
    context.saveGState()
    context.translateBy(x: 13, y: 13)
    cancel2.usesEvenOddFillRule = true
    UIColor.white.setFill()
    cancel2.fill()
    context.restoreGState()
    
    context.restoreGState()
  }
  
  
  //MARK: - Canvas Images
  
  /// Page 1
  
  class func image(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 45, height: 45), resizing: ResizingBehavior = .aspectFit) -> UIImage {
    struct LocalCache {
      static var image: UIImage!
    }
    
    var image: UIImage
    
    UIGraphicsBeginImageContextWithOptions(CGSize(width: targetFrame.size.width, height: targetFrame.size.width), false, 0)
    Cancel.draw(frame: targetFrame, resizing: resizing)
    image = UIGraphicsGetImageFromCurrentImageContext()!
    
    return image
  }
  
  
  //MARK: - Resizing Behavior
  
  enum ResizingBehavior {
    case aspectFit /// The content is proportionally resized to fit into the target rectangle.
    case aspectFill /// The content is proportionally resized to completely fill the target rectangle.
    case stretch /// The content is stretched to match the entire target rectangle.
    case center /// The content is centered in the target rectangle, but it is NOT resized.
    
    func apply(rect: CGRect, target: CGRect) -> CGRect {
      if rect == target || target == CGRect.zero {
        return rect
      }
      
      var scales = CGSize.zero
      scales.width = abs(target.width / rect.width)
      scales.height = abs(target.height / rect.height)
      
      switch self {
      case .aspectFit:
        scales.width = min(scales.width, scales.height)
        scales.height = scales.width
      case .aspectFill:
        scales.width = max(scales.width, scales.height)
        scales.height = scales.width
      case .stretch:
        break
      case .center:
        scales.width = 1
        scales.height = 1
      }
      
      var result = rect.standardized
      result.size.width *= scales.width
      result.size.height *= scales.height
      result.origin.x = target.minX + (target.width - result.width) / 2
      result.origin.y = target.minY + (target.height - result.height) / 2
      return result
    }
  }
  
  
}

