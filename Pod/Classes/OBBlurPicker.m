//
//  OBBlurPicker.m
//  OBBlurPicker
//
//  Created by Ryan Popa on 9/23/15.
//  Copyright (c) 2015 Openbay. All rights reserved.
//

#import <UIImageEffects/UIImage+ImageEffects.h>
#import "OBBlurPicker.h"
#import "OBBlurPickerOverlay.h"

@interface OBBlurPicker()
@property (nonatomic, strong) OBBlurPickerOverlay *overlayView;
@end

@implementation OBBlurPicker

- (instancetype)init {
    _overlayView = [[[NSBundle mainBundle] loadNibNamed: @"OBBlurPickerOverlay" owner: nil options: nil] firstObject];
    [_overlayView.doneButton addTarget: self action: @selector(onDoneTapped:) forControlEvents: UIControlEventTouchUpInside];
    [_overlayView.cancelButton addTarget: self action: @selector(onCancelTapped:) forControlEvents: UIControlEventTouchUpInside];
    return self;
}

- (UIPickerView *)pickerView {
  return self.overlayView.picker;
}

- (void)dealloc {
  [self.overlayView.doneButton removeTarget: self action: @selector(onDoneTapped:) forControlEvents: UIControlEventTouchUpInside];
  [self.overlayView.cancelButton removeTarget: self action: @selector(onCancelTapped:) forControlEvents: UIControlEventTouchUpInside];
}

#pragma mark - Static Show and Hide

+ (OBBlurPicker *)showWithParentView: (UIView *)parentView withMessage: (NSString *)message {
  return [self showWithParentView: parentView withMessage: message shouldShowCancelButton: YES];
}

+ (OBBlurPicker *)showWithParentView: (UIView *)parentView withMessage: (NSString *)message shouldShowCancelButton: (BOOL)shouldShow {
  OBBlurPicker *picker = [OBBlurPicker new];
  [picker showWithParentView: parentView withMessage: message shouldShowCancelButton: shouldShow];
  return picker;
}

#pragma mark - Show and Hide

- (void)showWithParentView: (UIView *)parentView withMessage: (NSString *)message {
  [self showWithParentView: parentView withMessage: message shouldShowCancelButton: YES];
}

- (void)showWithParentView: (UIView *)parentView withMessage: (NSString *)message shouldShowCancelButton: (BOOL)shouldShow {

  //Set message
  self.overlayView.messageLabel.text = message;
  
  //Take screenshot of parent view and blur it
  UIImage *screenshot = [self getScreenshotOfView: parentView];
  UIImage *blurredScreenshot = [screenshot applyBlurWithRadius: 20.0 tintColor: [UIColor colorWithWhite: 1 alpha: 0.3] saturationDeltaFactor: 1.4 maskImage: nil];
  
  //Prepare the overlay
  self.overlayView.frame = parentView.bounds;
  self.overlayView.backgroundColor = [UIColor colorWithPatternImage: blurredScreenshot];
  self.overlayView.alpha = 0.0;
  self.overlayView.pickerContainer.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.5, 1.5);
  self.overlayView.shouldShowCancelButton = shouldShow;
  [parentView addSubview: self.overlayView];
  
  //Animate in
  [UIView animateWithDuration: 0.2 animations: ^{
    self.overlayView.alpha = 1.0;
    self.overlayView.pickerContainer.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
  }];
}

- (void)hide {
  self.pickerView.dataSource = nil;
  self.pickerView.delegate = nil;
  
  //Animate out
  [UIView animateWithDuration: 0.2 animations: ^{
    self.overlayView.alpha = 0;
    self.overlayView.pickerContainer.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.5, 1.5);
  } completion: ^(BOOL finished) {
    [self.overlayView removeFromSuperview];
  }];
}

#pragma mark - UIPickerView Datasource

- (void)reloadPickerWithDatasource: (id<UIPickerViewDataSource>)datasource andDelegate: (id<UIPickerViewDelegate>)delegate {
  
  //Prepare the picker
  self.pickerView.dataSource = datasource;
  self.pickerView.delegate = delegate;
  [self.overlayView.picker reloadAllComponents];
  
  //Reset the picker selection
  for (int i = 0; i < self.pickerView.numberOfComponents; i++) {
    NSInteger middleItemIndex = [self.pickerView numberOfRowsInComponent: i] / 2;
    [self.pickerView selectRow: middleItemIndex inComponent: i animated: NO];
    
    if ([self.pickerView.delegate respondsToSelector: @selector(pickerView:didSelectRow:inComponent:)])
      [self.pickerView.delegate pickerView: self.pickerView didSelectRow: middleItemIndex inComponent: i];
  }
}

#pragma mark - Actions

- (IBAction)onDoneTapped: (id)sender {
  [self lockInSelection];
  [self.delegate blurPickerDidDismiss: self];
  [self hide];
}

- (IBAction)onCancelTapped: (id)sender {
  [self hide];
}

#pragma mark - Helpers

/** Creates an image of the provided view hiearchy */
- (UIImage *)getScreenshotOfView: (UIView *)view {
  UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [[UIScreen mainScreen] scale]);
  
  //Capture screenshot
  [view drawViewHierarchyInRect: view.bounds afterScreenUpdates: NO];
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

  UIGraphicsEndImageContext();
  return image;
}

- (void)lockInSelection {
  
  for (int i = 0; i < self.pickerView.numberOfComponents; i++) {
    NSInteger rowIndex = [self.pickerView selectedRowInComponent: i];
    [self.pickerView selectRow: rowIndex inComponent: i animated: YES];
    
    if ([self.pickerView.delegate respondsToSelector: @selector(pickerView:didSelectRow:inComponent:)])
      [self.pickerView.delegate pickerView: self.pickerView didSelectRow: rowIndex inComponent: i];
  }
}

@end
