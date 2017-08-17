//
//  OBBlurDatePicker.m
//  Pods
//
//  Created by Ryan Popa on 8/17/17.
//
//

#import <UIImageEffects/UIImage+ImageEffects.h>
#import "OBBlurDatePicker.h"
#import "OBBlurDatePickerOverlay.h"

@interface OBBlurDatePicker()
@property (nonatomic, strong) OBBlurDatePickerOverlay *overlayView;
@end

@implementation OBBlurDatePicker

- (instancetype)init {
    _overlayView = [[[NSBundle bundleForClass: [self class]] loadNibNamed: @"OBBlurDatePickerOverlay" owner: nil options: nil] firstObject];
    [_overlayView.doneButton addTarget: self action: @selector(onDoneTapped:) forControlEvents: UIControlEventTouchUpInside];
    [_overlayView.cancelButton addTarget: self action: @selector(onCancelTapped:) forControlEvents: UIControlEventTouchUpInside];
    return self;
}

- (UIDatePicker *)pickerView {
  return self.overlayView.picker;
}

- (void)dealloc {
  [self.overlayView.doneButton removeTarget: self action: @selector(onDoneTapped:) forControlEvents: UIControlEventTouchUpInside];
  [self.overlayView.cancelButton removeTarget: self action: @selector(onCancelTapped:) forControlEvents: UIControlEventTouchUpInside];
}

#pragma mark - Static Show and Hide

+ (OBBlurDatePicker *)showWithParentView: (UIView *)parentView withMessage: (NSString *)message {
  return [self showWithParentView: parentView withMessage: message shouldShowCancelButton: YES];
}

+ (OBBlurDatePicker *)showWithParentView: (UIView *)parentView withMessage: (NSString *)message shouldShowCancelButton: (BOOL)shouldShow {
  OBBlurDatePicker *picker = [OBBlurDatePicker new];
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
  [UIView animateWithDuration: 0.2 animations: ^{
    self.overlayView.alpha = 0;
    self.overlayView.pickerContainer.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.5, 1.5);
  } completion: ^(BOOL finished) {
    [self.overlayView removeFromSuperview];
  }];
}

#pragma mark - Actions

- (IBAction)onDoneTapped: (id)sender {
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

@end
