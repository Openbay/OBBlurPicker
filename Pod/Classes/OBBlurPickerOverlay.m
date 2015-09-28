//
//  OBBlurPickerOverlay.m
//  OBBlurPicker
//
//  Created by Ryan Popa on 9/23/15.
//  Copyright (c) 2015 Openbay. All rights reserved.
//

#import "OBBlurPickerOverlay.h"

@interface OBBlurPickerOverlay()
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *doneButtonRightCenterConstraint;
@end

@implementation OBBlurPickerOverlay

- (void)setShouldShowCancelButton: (BOOL)shouldShowCancelButton {
  _shouldShowCancelButton = shouldShowCancelButton;
  if (shouldShowCancelButton) [self.pickerContainer addConstraint: self.doneButtonRightCenterConstraint];
  else [self.pickerContainer removeConstraint: self.doneButtonRightCenterConstraint];
}

@end
