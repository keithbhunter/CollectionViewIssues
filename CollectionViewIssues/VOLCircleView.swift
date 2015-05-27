//
//  VOLCircleView.swift
//  Volum
//
//  Created by Keith Hunter on 5/25/15.
//  Copyright (c) 2015 Keith Hunter. All rights reserved.
//

import UIKit

class VOLCircleView: UIView {

    @IBOutlet weak var label: UILabel!
    var color: UIColor = .blueColor() {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        self.color.setFill()
        CGContextAddEllipseInRect(context, self.bounds)
        CGContextFillPath(context)
    }

}
