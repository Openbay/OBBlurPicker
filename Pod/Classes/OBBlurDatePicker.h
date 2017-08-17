//
//  OBBlurDatePicker.h
//  Pods
//
//  Created by Ryan Popa on 8/17/17.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class OBBlurDatePicker;

@protocol OBBlurDatePickerDelegate <NSObject>

/**
 Called when the picker has been closed by the user pressing 'Done'.
 This will not be called if the user presses 'Cancel'.
 */
- (void)blurPickerDidDismiss: (OBBlurDatePicker *)picker;

@end




@interface OBBlurDatePicker : NSObject

/** Delegate to notify of activity */
@property (nonatomic, weak) id <OBBlurDatePickerDelegate> delegate;

/** Tag, can be used to identify the picker */
@property (nonatomic) NSInteger tag;

/** The UIPickerView being shown */
@property (nonatomic, readonly) UIDatePicker *pickerView;


#pragma mark - Show and Hide

/** Creates and shows an OBBlurDatePicker with a cancel button
 
 @param parentView A view to show the picker in.
 @param message The message to show at the top of the picker. Use to instruct the user what they are picking.
*/
+ (OBBlurDatePicker *)showWithParentView: (UIView *)parentView withMessage: (NSString *)message;

/** Creates and shows an OBBlurDatePicker
 
 @param parentView A view to show the picker in.
 @param message The message to show at the top of the picker. Use to instruct the user what they are picking.
 @param shouldShow YES if you would like to show a cancel button.
 */
+ (OBBlurDatePicker *)showWithParentView: (UIView *)parentView withMessage: (NSString *)message shouldShowCancelButton: (BOOL)shouldShow;

/** Shows the recieving OBBlurDatePicker with a cancel button
 
 @param parentView A view to show the picker in.
 @param message The message to show at the top of the picker. Use to instruct the user what they are picking.
 */
- (void)showWithParentView: (UIView *)parentView withMessage: (NSString *)message;

/** Shows the recieving OBBlurDatePicker
 
 @param parentView A view to show the picker in.
 @param message The message to show at the top of the picker. Use to instruct the user what they are picking.
 @param shouldShow YES if you would like to show a cancel button.
 */
- (void)showWithParentView: (UIView *)parentView withMessage: (NSString *)message shouldShowCancelButton: (BOOL)shouldShow;

/** Hide the recieving OBBlurDatePicker */
- (void)hide;

@end
