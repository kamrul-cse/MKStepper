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
    func reachedAtMin(value: Int)
    func reachedAtMax(value: Int)
}

@IBDesignable
open class MKStepperView: UIView {
    
    @IBInspectable open var minValue:Int = 1 {
        didSet {
            stepperValue = minValue
        }
    }
    @IBInspectable open var maxValue:Int = 5
    
    @IBInspectable open var color: UIColor = #colorLiteral(red: 0.2470588235, green: 0.6352941176, blue: 0.2470588235, alpha: 1) {
        didSet {
            containerBg.backgroundColor = color
            layer.borderWidth = 1
            layer.borderColor = color.cgColor
        }
    }
    
    var plusButton: UIButton!
    var minusButton: UIButton!
    var valueLabel: UILabel!
    var containerBg: UIView!
    var bg: UIView!
    
    open var delegate: StepperViewDelegate?
    
    open var stepperValue: Int = 0 {
        didSet {
            valueLabel.text = String(format: "%d", stepperValue)
            layoutIfNeeded()
        }
    }
    
    func commonInit() {
        let buttonPadding = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        let cornerRadius: CGFloat = 2
        
        func buttonView(title: String, corners: CACornerMask) -> (UIView, UIButton) {
            let container = UIView(frame: CGRect.zero)
            container.widthAnchor == container.heightAnchor
            
            let button = UIButton(type: .custom)
            button.setTitle(title, for: .normal)
            
            let bg = UIView(frame: CGRect.zero)
            bg.backgroundColor = .clear
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
            
            container.clipsToBounds = true
            return (container, button)
        }
        
        containerBg = UIView(frame: CGRect.zero)
        addSubview(containerBg)
        containerBg.edgeAnchors == edgeAnchors + buttonPadding
        
        let (plusView, _plusButton) = buttonView(title: "+", corners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner])
        plusButton = _plusButton
        plusButton.addTarget(self, action: #selector(up(_:)), for: .touchUpInside)
        
        let (minusView, _minusButton) = buttonView(title: "−", corners: [.layerMinXMaxYCorner, .layerMinXMinYCorner])
        minusButton = _minusButton
        minusButton.addTarget(self, action: #selector(down(_:)), for: .touchUpInside)
        
        valueLabel = UILabel(frame: CGRect.zero)
        valueLabel.textAlignment = .center
        valueLabel.text = String(format: "%d", minValue)
        valueLabel.backgroundColor = .white
        
        let stack = UIStackView(arrangedSubviews: [minusView, valueLabel, plusView])
        stack.alignment = .fill
        stack.axis = .horizontal
        
        stack.heightAnchor.constraint(equalTo: stack.widthAnchor, multiplier: 1/3).isActive = true
        
        addSubview(stack)
        stack.edgeAnchors == edgeAnchors + buttonPadding
        
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        
        containerBg.backgroundColor = color
        layer.borderWidth = 1
        layer.borderColor = color.cgColor
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
        let newValue = min((stepperValue + 1), maxValue)
        
        if newValue == stepperValue {
            delegate?.reachedAtMax(value: stepperValue)
        } else {
            delegate?.valueDidChange(value: newValue)
        }
        stepperValue = newValue
    }
    
    @objc func down(_ sender: Any) {
        let newValue = max((stepperValue - 1), minValue)
        
        if newValue == stepperValue {
            delegate?.reachedAtMin(value: stepperValue)
        } else {
            delegate?.valueDidChange(value: newValue)
        }
        stepperValue = newValue
    }
}
