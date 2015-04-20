//
//  FaceUIView.swift
//  SwiftCalculator
//
//  Created by Huan Wang on 4/20/15.
//  Copyright (c) 2015 Huan Wang. All rights reserved.
//

import UIKit

class FaceUIView: UIView {
    
    var faceLineWidth: CGFloat = 3 { didSet{ setNeedsDisplay() } }
    var color: UIColor = UIColor.blueColor() { didSet{ setNeedsDisplay() } }
    var scale: CGFloat = 0.90 { didSet{ setNeedsDisplay() } }
    
    var faceCenter: CGPoint {
        return convertPoint(center, fromView: superview)
    }
    
    var faceRadius: CGFloat {
        return min(bounds.size.width, bounds.size.height) / 4 * scale
    }

    override func drawRect(rect: CGRect) {
        
        let facePath = UIBezierPath(arcCenter: faceCenter, radius: faceRadius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
        facePath.lineWidth = faceLineWidth
        color.set()
        facePath.stroke()
        
    }

}
