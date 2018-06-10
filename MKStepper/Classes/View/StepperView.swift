//
//  StepperView.swift
//  Stepper
//
//  Created by Md. Kamrul Hasan on 6/3/18.
//  Copyright © 2018 Md. Kamrul Hasan. All rights reserved.
//

import UIKit

@objc public protocol StepperViewDelegate: class {
    func valueDidChange(value: Int)
}

@IBDesignable
open class StepperView: UIView {
    
    @IBInspectable var minValue:Int = 1
    @IBInspectable var maxValue:Int = 5
    
    var plusButton: UIButton!
    var minusButton: UIButton!
    var valueLabel: UILabel!
    
    @IBOutlet var delegate:StepperViewDelegate?
    
    var stepperValue: Int = 0 {
        didSet {
            valueLabel.text = String(format: "%d", stepperValue)
            layoutIfNeeded()
        }
    }
    
    func commonInit() {
        let buttonPadding = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        let cornerRadius: CGFloat = 2
        
        func buttonView(title: String, corners: CACornerMask) -> (UIView, UIButton) {
            let container = UIView(frame: CGRect.zero)
            container.widthAnchor == container.heightAnchor
            
            let button = UIButton(type: .custom)
            button.setTitle(title, for: .normal)
            
            let bg = UIView(frame: CGRect.zero)
            bg.backgroundColor = #colorLiteral(red: 0.2470588235, green: 0.6352941176, blue: 0.2470588235, alpha: 1)
            bg.clipsToBounds = true
            bg.layer.cornerRadius = cornerRadius
            if #available(iOS 11.0, *) {
                bg.layer.maskedCorners = corners
            } else {
                // Fallback on earlier versions
            }
            
            container.addSubview(bg)
            container.addSubview(button)
            
            button.edgeAnchors == container.edgeAnchors
            bg.edgeAnchors == container.edgeAnchors + buttonPadding
            
            return (container, button)
        }
        
        let containerBg = UIView(frame: CGRect.zero)
        addSubview(containerBg)
        containerBg.edgeAnchors == edgeAnchors + buttonPadding
        
        let (plusView, _plusButton) = buttonView(title: "+", corners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner])
        plusButton = _plusButton
        plusButton.addTarget(self, action: #selector(up(_:)), for: .touchUpInside)
        
        let (minusView, _minusButton) = buttonView(title: "-", corners: [.layerMinXMaxYCorner, .layerMinXMinYCorner])
        minusButton = _minusButton
        minusButton.addTarget(self, action: #selector(down(_:)), for: .touchUpInside)
        
        valueLabel = UILabel(frame: CGRect.zero)
        valueLabel.textAlignment = .center
        valueLabel.text = String(format: "%d", minValue)
        
        let stack = UIStackView(arrangedSubviews: [minusView, valueLabel, plusView])
        stack.alignment = .center
        stack.axis = .horizontal
        
        addSubview(stack)
        stack.edgeAnchors == edgeAnchors
        
        containerBg.layer.cornerRadius = cornerRadius
        containerBg.layer.borderWidth = 1
        containerBg.layer.borderColor = #colorLiteral(red: 0.2470588235, green: 0.6352941176, blue: 0.2470588235, alpha: 1)
        containerBg.clipsToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    @objc func up(_ sender: Any) {
        stepperValue = min((stepperValue + 1), maxValue)
        delegate?.valueDidChange(value: stepperValue)
    }
    
    @objc func down(_ sender: Any) {
        stepperValue = max((stepperValue - 1), minValue)
        delegate?.valueDidChange(value: stepperValue)
    }
}
