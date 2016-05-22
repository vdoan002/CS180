//
//  ThirdViewController.h
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/1/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdViewController : UIViewController<UITextFieldDelegate, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource>{
    IBOutlet UIImageView *imageView;
    UIImagePickerController * pickerCamera;
    UIImage * image;
}
@property (strong, nonatomic) IBOutlet UIPickerView *catPicker;
@property (strong, nonatomic) IBOutlet UITextField *titleField;
@property (strong, nonatomic) IBOutlet UITextField *priceField;
@property (strong, nonatomic) IBOutlet UITextView *descView;
@property (strong, nonatomic) NSString * category;
@property (strong, nonatomic) NSString * titleName;
@property (strong, nonatomic) NSString * price;
@property (strong, nonatomic) NSString * desc;
@property (strong, nonatomic) NSArray * categories;

- (IBAction)chooseButton:(id)sender;
- (IBAction)takeButton:(id)sender;
- (IBAction)submitButton:(id)sender;
- (void)writeToDB;

@end
