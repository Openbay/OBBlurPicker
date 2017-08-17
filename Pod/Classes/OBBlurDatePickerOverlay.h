//
//  OBBlurPickerOverlay.h
//  OBBlurPicker
//
//  Created by Ryan Popa on 9/23/15.
//  Copyright (c) 2015 Openbay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OBBlurDatePickerOverlay : UIView

@property (nonatomic, weak) IBOutlet UIButton *cancelButton;
@property (nonatomic, weak) IBOutlet UILabel *messageLabel;
@property (nonatomic, weak) IBOutlet UIButton *doneButton;
@property (nonatomic, weak) IBOutlet UIDatePicker *picker;
@property (nonatomic, weak) IBOutlet UIView *pickerContainer;

@property (nonatomic) BOOL shouldShowCancelButton;

@end
