//
//  CreatePostViewController.m
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/1/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import "CreatePostViewController.h"
#import "PostsTableViewController.h"
#import "users.h"
#import "dbArrays.h"

@interface CreatePostViewController ()

@end

@implementation CreatePostViewController
@synthesize catPicker, titleField, priceField, descView, categories, category, titleName, price, desc;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupKeyboard];
    [self setupData];
    [self setupUI];
}

- (void)setupData{
    categories = @[@"Books", @"Clothing", @"Electronics", @"Furniture", @"Household", @"Leases", @"Music", @"Pets", @"Services", @"Tickets", @"Vehicles", @"Other"];
    category = categories[0];
    
    //set delegates
    titleField.delegate = self;
    priceField.delegate = self;
    descView.delegate = self;
    catPicker.delegate = self;
    catPicker.dataSource = self;
}

- (void)setupKeyboard{
    //keyboard dismiss: http://stackoverflow.com/a/5711504
    self.view.backgroundColor = [UIColor colorWithRed:0.13 green:0.13 blue:0.13 alpha:1.0];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

- (void)setupUI{
    //set placeholder text color
    UIColor *color = [UIColor lightGrayColor];
    titleField.attributedPlaceholder =[[NSAttributedString alloc] initWithString:@"enter a title" attributes:@{NSForegroundColorAttributeName:color}];
    priceField.attributedPlaceholder =[[NSAttributedString alloc] initWithString:@"enter a price" attributes:@{NSForegroundColorAttributeName:color}];
    
    //give textView a rounded border
    self.descView.layer.cornerRadius = 5;
    self.descView.tintColor = [UIColor colorWithRed:0.29 green:0.53 blue:0.91 alpha:1.0];
    
    //dynamically sized imageView
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)dismissKeyboard { //http://stackoverflow.com/a/5711504
    [titleField resignFirstResponder];
    [priceField resignFirstResponder];
    [descView resignFirstResponder];
}

//UIPickerView setup http://stackoverflow.com/questions/13756591/how-would-i-set-up-a-uipickerview
// http://www.techotopia.com/index.php/An_iOS_7_UIPickerView_Example#UIPickerView_Delegate_and_DataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    return categories.count;
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return categories[row];
}

// changing pickerView text color http://stackoverflow.com/q/20698547
- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title = categories[row];
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    return attString;
}

#pragma mark -
#pragma mark PickerView Delegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component{
    category = categories[row];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == titleField){
        [textField resignFirstResponder];
        [priceField becomeFirstResponder];
    }
    else if (textField == priceField){
        [textField resignFirstResponder];
        [descView becomeFirstResponder];
    }
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    //NSLog(@"descView.text: %@", descView.text);
    if(textView == descView && [descView.text isEqualToString:@"enter a description"]){
        //NSLog(@"descView.text: %@", descView.text);
        descView.text = @"";
    }
}

- (void)presentPopup:(NSString *)titleText message: (NSString *)message{
    //courtesy popup
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:titleText
                                message:message
                                preferredStyle:UIAlertControllerStyleAlert];
    
    //button creation and function (handler)
    UIAlertAction* actionOk = [UIAlertAction
                               actionWithTitle:@"Ok"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {}];
    
    [alert addAction:actionOk];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    [imageView setImage:image];
    imageView.frame = CGRectMake(67, 490, width, height);
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo{
    [self presentPopup:@"Photo chosen!" message:@"Please continue with your submission."];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

// http://stackoverflow.com/a/11515771
// http://stackoverflow.com/a/15589721
-(void)writeToDB{
    // Create your request string with parameter name as defined in PHP file
    NSString *myRequestString = [NSString stringWithFormat:@"user=%@&category=%@&title=%@&price=%@&description=%@", [dbArrays sharedInstance].user.username, category, titleName, price, desc];
    NSLog(@"%@", myRequestString);
    
    // Create Data from request
    NSData *data = [NSData dataWithBytes: [myRequestString UTF8String] length: [myRequestString length]];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[data length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: @"http://www.practicemakesperfect.co.nf/setPost.php"]];
    
    [request setHTTPMethod: @"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: data];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        NSLog(@"requestReply: %@", requestReply);
    }] resume];
}

- (IBAction)chooseButton:(id)sender {
    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (IBAction)takeButton:(id)sender {
    pickerCamera = [[UIImagePickerController alloc] init];
    pickerCamera.delegate = self;
    [pickerCamera setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self presentViewController:pickerCamera animated:YES completion:NULL];
}

- (IBAction)submitButton:(id)sender {
    // write to the db
    if(![titleField.text isEqualToString:@""] && ![priceField.text isEqualToString:@""] && ![descView.text isEqualToString:@""] && ![descView.text isEqualToString:@"enter a description"]){
        titleName = titleField.text;
        price = priceField.text;
        desc = descView.text;
        
        [self writeToDB];
        
        titleField.text = @"";
        priceField.text = @"";
        descView.text = @"enter a description";
        
        //courtesy popup
        UIAlertController *alert = [UIAlertController
                                    alertControllerWithTitle:[NSString stringWithFormat:@"Submitted!"]
                                    message:@"Thank you for your submission."
                                    preferredStyle:UIAlertControllerStyleAlert];
        
        //button creation and function (handler)
        UIAlertAction* actionOk = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       [self dismissViewControllerAnimated:YES completion:nil];
                                   }];
        
        [alert addAction:actionOk];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    else{
        [self presentPopup:@"Invalid submission!" message:@"Please enter a valid submission."];
    }
}

- (IBAction)cancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
