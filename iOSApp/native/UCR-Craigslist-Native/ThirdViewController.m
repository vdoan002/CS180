//
//  ThirdViewController.m
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/1/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import "ThirdViewController.h"
#import "FirstViewController.h"
#import "users.h"
#import "dbArrays.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController
@synthesize catPicker, titleField, priceField, descView, categories, category, titleName, price, desc;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //keyboard dismiss: http://stackoverflow.com/a/5711504
    [self getUserName];
    self.view.backgroundColor = [UIColor colorWithRed:0.13 green:0.13 blue:0.13 alpha:1.0];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    //set UITextField and UITextView BG Color
    //[titleField setBackgroundColor:[UIColor blackColor]];
    //[priceField setBackgroundColor:[UIColor blackColor]];
    //[descView setBackgroundColor:[UIColor blackColor]];
    
    //set placeholder text color
    UIColor *color = [UIColor lightGrayColor];
    titleField.attributedPlaceholder =[[NSAttributedString alloc] initWithString:@"enter a title" attributes:@{NSForegroundColorAttributeName:color}];
    priceField.attributedPlaceholder =[[NSAttributedString alloc] initWithString:@"enter a price" attributes:@{NSForegroundColorAttributeName:color}];
    
    //set delegates
    titleField.delegate = self;
    priceField.delegate = self;
    descView.delegate = self;
    
    catPicker.delegate = self;
    catPicker.dataSource = self;
    
    categories = @[@"Books", @"Clothing", @"Electronics", @"Furniture", @"Household", @"Leases", @"Music", @"Pets", @"Services", @"Tickets", @"Vehicles", @"Other"];
    category = categories[0];
    
    //self.descView.layer.borderWidth = 5.0f;
    //self.descView.layer.borderColor = [[UIColor colorWithRed:0.13 green:0.13 blue:0.13 alpha:1.0] CGColor]
    self.descView.layer.cornerRadius = 5;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissKeyboard { //http://stackoverflow.com/a/5711504
    [titleField resignFirstResponder];
    [priceField resignFirstResponder];
    [descView resignFirstResponder];
}

-(void)getUserName{
    users * userObj;
    
    for(int i  = 0; i < [dbArrays sharedInstance].usersArray.count; i++){
        userObj = [[dbArrays sharedInstance].usersArray objectAtIndex:i];
        //NSLog(@"userObj.loggedIn: %@", userObj.loggedIn);
        if([userObj.loggedIn isEqualToString:@"true"]){
            [dbArrays sharedInstance].currentLoggedInUserName = userObj.username;
        }
    }
}

//UIPickerView setup http://stackoverflow.com/questions/13756591/how-would-i-set-up-a-uipickerview
// http://www.techotopia.com/index.php/An_iOS_7_UIPickerView_Example#UIPickerView_Delegate_and_DataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    return 12;
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
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    category = categories[row];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == titleField) {
        [textField resignFirstResponder];
        [priceField becomeFirstResponder];
    } else if (textField == priceField) {
        [textField resignFirstResponder];
        [descView becomeFirstResponder];
    }
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    NSLog(@"descView.text: %@", descView.text);
    if(textView == descView && [descView.text isEqualToString:@"enter a description"]){
        NSLog(@"descView.text: %@", descView.text);
        descView.text = @"";
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo
{
    //courtesy popup
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:[NSString stringWithFormat:@"Photo chosen!"]
                                message:@"Please continue with your submission."
                                preferredStyle:UIAlertControllerStyleAlert];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    //button creation and function (handler)
    UIAlertAction* actionOk = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {}];
    
    [alert addAction:actionOk];

    [picker dismissViewControllerAnimated:YES completion:nil];
    //UIImage *newImage = image;
}

// http://stackoverflow.com/a/11515771
// http://stackoverflow.com/a/15589721
-(void)writeToDB{
    // Create your request string with parameter name as defined in PHP file®
    NSString *myRequestString = [NSString stringWithFormat:@"user=%@&category=%@&title=%@&price=%@&description=%@", [dbArrays sharedInstance].currentLoggedInUserName, category, titleName, price, desc];
    NSLog(@"%@", myRequestString);
    
    // Create Data from request
    NSData *data = [NSData dataWithBytes: [myRequestString UTF8String] length: [myRequestString length]];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[data length]];
    /*NSDictionary *dictionary = @{@"content": composeField.text, @"sender": currentLoggedInUserName, @"receiver": message.message_sender};
     NSError *error = nil;
     NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary
     options:kNilOptions error:&error];*/
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: @"http://www.practicemakesperfect.co.nf/setPost.php"]];
    
    [request setHTTPMethod: @"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: data];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        NSLog(@"requestReply: %@", requestReply);
    }] resume];
    
    /*NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
     NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
     NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request fromData:data completionHandler:^(NSData *data,NSURLResponse *response, NSError *error) {
     NSLog(@"response: %@", response);
     }];
     [uploadTask resume];*/
    //NSData * returnData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil];
    // Log Response
    //NSString * response = [[NSString alloc] initWithBytes:[returnSession bytes] length:[returnData length] encoding:NSUTF8StringEncoding];
    //NSLog(@"response: %@",response);
}

-(void)refreshAll{
    
}

- (IBAction)chooseButton:(id)sender {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentModalViewController:imagePickerController animated:YES];
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
        
        [self presentViewController:alert animated:YES completion:nil];
        
        //button creation and function (handler)
        UIAlertAction* actionOk = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {}];
        
        [alert addAction:actionOk];
    }
    else{
        //courtesy popup
        UIAlertController *alert = [UIAlertController
                                    alertControllerWithTitle:[NSString stringWithFormat:@"Not submitted!"]
                                    message:@"Please enter a valid submission."
                                    preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        //button creation and function (handler)
        UIAlertAction* actionOk = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {}];
        
        [alert addAction:actionOk];
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    // store image here into blob data
    //image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    //[imageView setImage:image];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end
