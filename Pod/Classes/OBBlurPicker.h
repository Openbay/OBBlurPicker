//
//  OBBlurPicker.h
//  OBBlurPicker
//
//  Created by Ryan Popa on 9/23/15.
//  Copyright (c) 2015 Openbay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class OBBlurPicker;

@protocol OBBlurPickerDelegate <NSObject>

/**
 Called when the picker has been closed by the user pressing 'Done'.
 This will not be called if the user presses 'Cancel'.
 */
- (void)blurPickerDidDismiss: (OBBlurPicker *)picker;

@end




@interface OBBlurPicker : NSObject

/** Delegate to notify of activity */
@property (nonatomic, weak) id <OBBlurPickerDelegate> delegate;

/** Tag, can be used to identify the picker */
@property (nonatomic) NSInteger tag;

/** The UIPickerView being shown */
@property (nonatomic, readonly) UIPickerView *pickerView;


#pragma mark - Show and Hide

/** Creates and shows an OBBlurPicker with a cancel button
 
 @param parentView A view to show the picker in.
 @param message The message to show at the top of the picker. Use to instruct the user what they are picking.
*/
+ (OBBlurPicker *)showWithParentView: (UIView *)parentView withMessage: (NSString *)message;

/** Creates and shows an OBBlurPicker
 
 @param parentView A view to show the picker in.
 @param message The message to show at the top of the picker. Use to instruct the user what they are picking.
 @param shouldShow YES if you would like to show a cancel button.
 */
+ (OBBlurPicker *)showWithParentView: (UIView *)parentView withMessage: (NSString *)message shouldShowCancelButton: (BOOL)shouldShow;

/** Shows the recieving OBBlurPicker with a cancel button
 
 @param parentView A view to show the picker in.
 @param message The message to show at the top of the picker. Use to instruct the user what they are picking.
 */
- (void)showWithParentView: (UIView *)parentView withMessage: (NSString *)message;

/** Shows the recieving OBBlurPicker
 
 @param parentView A view to show the picker in.
 @param message The message to show at the top of the picker. Use to instruct the user what they are picking.
 @param shouldShow YES if you would like to show a cancel button.
 */
- (void)showWithParentView: (UIView *)parentView withMessage: (NSString *)message shouldShowCancelButton: (BOOL)shouldShow;

/** Hide the recieving OBBlurPicker */
- (void)hide;

#pragma mark - Datasource

/** Reload the data shown in the picker
 
 @param datasource A new UIPickerViewDataSource.
 @param delegate A new UIPickerViewDelegate.
 */
- (void)reloadPickerWithDatasource: (id <UIPickerViewDataSource>)datasource andDelegate: (id <UIPickerViewDelegate>)delegate;

@end
