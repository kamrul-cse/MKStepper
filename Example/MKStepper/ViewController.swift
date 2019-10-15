//
//  ViewController.swift
//  MKStepper
//
//  Created by mhgolap11@gmail.com on 06/10/2018.
//  Copyright (c) 2018 mhgolap11@gmail.com. All rights reserved.
//

import UIKit
import MKStepper

class ViewController: UIViewController {

    @IBOutlet weak var stepperView: MKStepperView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        stepperView.delegate = self
        stepperView.stepperValue = 2
        stepperView.minValue = 1
        stepperView.maxValue = 5
        stepperView.color = UIColor.red
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: StepperViewDelegate {
    func valueDidChange(value: Int) {
        print(value)
    }
    func reachedAtMin(value: Int) {
        print("Reached at min")
    }
    func reachedAtMax(value: Int) {
        print("Reached at max")
    }
}

