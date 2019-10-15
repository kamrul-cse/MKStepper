# MKStepper

[![CI Status](https://img.shields.io/travis/mhgolap11@gmail.com/MKStepper.svg?style=flat)](https://travis-ci.org/mhgolap11@gmail.com/MKStepper)
[![Version](https://img.shields.io/cocoapods/v/MKStepper.svg?style=flat)](https://cocoapods.org/pods/MKStepper)
[![License](https://img.shields.io/cocoapods/l/MKStepper.svg?style=flat)](https://cocoapods.org/pods/MKStepper)
[![Platform](https://img.shields.io/cocoapods/p/MKStepper.svg?style=flat)](https://cocoapods.org/pods/MKStepper)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

Screenshots:

Simply Add `UIView` to your `Storyboard` and then change the class to `StepperView`.

<img src="https://github.com/kamrul-cse/MKStepper/blob/master/Example/Screenshots/screenshot_stepper_class.png" width="100%" > 

You can set `min` and `max` value. By default it set to `1...5`

<img src="https://github.com/kamrul-cse/MKStepper/blob/master/Example/Screenshots/screenshot_stepper_property.png" width="100%" > 


Now your stepper is ready! Run and check it. Cheers ✌️!

<img src="https://github.com/kamrul-cse/MKStepper/blob/master/Example/Screenshots/screenshot_stepper_output.png" width="200px" >

Sample Usage:

```swift
import UIKit
import MKStepper

class ViewController: UIViewController {

    @IBOutlet weak var stepperView: MKStepperView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stepperView.delegate = self
        stepperView.stepperValue = 2
        stepperView.minValue = 1
        stepperView.maxValue = 5
        stepperView.color = UIColor.red
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
```

## Installation

MKStepper is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MKStepper'
```

## Author
Md. Kamrul Hasan
mhgolap11@gmail.com

Copyright © mkhglab@gmail.com

## License

MKStepper is available under the MIT license. See the LICENSE file for more info.
