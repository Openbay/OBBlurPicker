
<p align="center"><img src="OBBlurPickerDemo.gif"/></p>

## OBBlurPicker

OBBlurPicker was written because most attempts to integrate a UIPickerView into a UI look wonky
and out of place. This was designed to be a drop in solution to that problem.

## Installation

OBBlurPicker is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'OBBlurPicker', :git => 'https://github.com/Openbay/OBBlurPicker', :tag => '1.0.0'
```

## Usage

Objective-C
```objc
#import <OBBlurPicker/OBBlurPicker.h>

// ...

OBBlurPicker *picker = [OBBlurPicker showWithParentView: self.navigationController.view withMessage: @"Select State"];
[picker reloadPickerWithDatasource: self.pickerDatasource andDelegate: self.pickerDelegate];
[picker setDelegate: self];

// ...

[picker hide];
```

Swift
```swift
import OBBlurPicker

// ...

let picker = OBBlurPicker.showWithParentView(self.navigationController.view, withMessage: "Select State")
picker.reloadPickerWithDatasource(self.pickerDatasource, andDelegate: self.pickerDelegate)
picker.delegate = self;

// ...

picker.hide()
```

## Author

Ryan Popa, rp@openbay.com

## License

OBBlurPicker is available under the MIT license. See the LICENSE file for more info.
