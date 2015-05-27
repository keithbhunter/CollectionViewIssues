//
//  VOLBarSliderCell.swift
//  Volum
//
//  Created by Keith Hunter on 5/2/15.
//  Copyright (c) 2015 Keith Hunter. All rights reserved.
//

import UIKit


protocol VOLBarSliderCellDelegate {
    
    func barSliderCellValueDidChange(cell: VOLBarSliderCell)
    func barSliderCellTappedInEditMode(cell: VOLBarSliderCell)
    
}


class VOLBarSliderCell: UICollectionViewCell, UIGestureRecognizerDelegate {

    @IBOutlet weak var barSlider: KBHBarSlider!
    @IBOutlet weak var circleView: VOLCircleView!
    var delegate: VOLBarSliderCellDelegate?
    var panGesture: UIPanGestureRecognizer!
    var editing: Bool = false {
        didSet {
//            self.barSlider.slidingEnabled = !self.editing
            
            if !self.editing {
                self.barSlider.barColor = self.tintColor
                self.circleView.color = self.tintColor
                self.circleView.label.text = "\(Int(self.barSlider.value))"
                self.circleView.label.textColor = .whiteColor()
                
                if self.circleView.gestureRecognizers?.count > 0 {
                    for gesture in self.circleView.gestureRecognizers! {
                        if let tap = gesture as? UITapGestureRecognizer {
                            self.circleView.removeGestureRecognizer(tap)
                        }
                    }
                }
            } else {
                self.barSlider.barColor = .darkGrayColor()
                self.circleView.color = .darkGrayColor()
                self.circleView.label.text = "-"
                self.circleView.label.textColor = .redColor()
                
                let tap = UITapGestureRecognizer(target: self, action: "cellTappedInEditMode")
                self.circleView.addGestureRecognizer(tap)
            }
        }
    }
    
    
    // MARK: - Init
    
    class func reuseIdentifier() -> String {
        return "BarSliderCell"
    }
    
    class func nibName() -> String {
        return "VOLBarSliderCell"
    }
    
    class func nib() -> UINib {
        return UINib(nibName: VOLBarSliderCell.nibName(), bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.barSlider.addTarget(self, action: "valueChanged", forControlEvents: .ValueChanged)
        self.circleView.backgroundColor = .clearColor()
        
        self.panGesture = self.barSlider.gestureRecognizers!.first! as! UIPanGestureRecognizer
        self.panGesture.delegate = self
    }
    
    
    // MARK: - Actions
    
    func valueChanged() {
        self.circleView.label.text = "\(Int(self.barSlider.value))"
        self.delegate?.barSliderCellValueDidChange(self)
    }
    
    func cellTappedInEditMode() {
        self.delegate?.barSliderCellTappedInEditMode(self)
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        if self.editing && gestureRecognizer == self.panGesture {
            return false
        }
        
        return true
    }

}
