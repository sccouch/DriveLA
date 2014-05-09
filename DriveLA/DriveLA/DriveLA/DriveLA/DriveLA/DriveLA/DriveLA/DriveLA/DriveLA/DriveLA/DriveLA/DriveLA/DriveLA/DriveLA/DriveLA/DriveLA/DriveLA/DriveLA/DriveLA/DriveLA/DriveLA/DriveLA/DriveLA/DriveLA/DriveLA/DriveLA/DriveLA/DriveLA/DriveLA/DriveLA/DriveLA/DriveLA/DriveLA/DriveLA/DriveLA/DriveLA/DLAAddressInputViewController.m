//
//  DLAAddressInputViewController.m
//  DriveLA
//
//  Created by Jack Okerman on 4/10/14.
//  Copyright (c) 2014 USC. All rights reserved.
//

#import "DLAAddressInputViewController.h"

@interface DLAAddressInputViewController ()
@property (weak, nonatomic) IBOutlet UITextField *streetTextField;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property (weak, nonatomic) IBOutlet UITextField *stateTextField;
@property (weak, nonatomic) IBOutlet UITextField *zipcodeTextField;

@end

@implementation DLAAddressInputViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.streetTextField.delegate = self;
    self.cityTextField.delegate = self;
    self.stateTextField.delegate = self;
    self.zipcodeTextField.delegate = self;
    
    [self.streetTextField becomeFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    Driver *driver = [[DLACoreDataStore sharedStore] fetchDriver];
    
    if (driver) {
        if (driver.addressStreet)
            self.streetTextField.text = driver.addressStreet;
        if (driver.addressCity)
            self.cityTextField.text = driver.addressCity;
        if (driver.addressState)
            self.stateTextField.text = driver.addressState;
        if (driver.addressZipcode)
            self.zipcodeTextField.text = driver.addressZipcode;
    }

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 2;
}

- (IBAction)saveButtonPressed:(id)sender {
    // Validate data
    BOOL valid = YES;
    if ([self.streetTextField.text isEqualToString:@""]) {
        [CSNotificationView showInViewController:self
                                           style:CSNotificationViewStyleError
                                         message:@"Enter a street address"];
        valid = NO;
    }
    else if ([self.cityTextField.text isEqualToString:@""]) {
        [CSNotificationView showInViewController:self
                                           style:CSNotificationViewStyleError
                                         message:@"Enter a city"];
        valid = NO;
    }
    
    else if ([self.stateTextField.text isEqualToString:@""]) {
        [CSNotificationView showInViewController:self
                                           style:CSNotificationViewStyleError
                                         message:@"Enter a state"];
        valid = NO;
    }
    else if ([self.zipcodeTextField.text isEqualToString:@""]) {
        [CSNotificationView showInViewController:self
                                           style:CSNotificationViewStyleError
                                         message:@"Enter a zipcode"];
        valid = NO;
    }
    
    if (valid) {
        // Save to data store
        NSDictionary *addressDictionary = @{@"addressStreet": self.streetTextField.text,
                                            @"addressCity": self.cityTextField.text,
                                            @"addressState": self.stateTextField.text,
                                            @"addressZipcode": self.zipcodeTextField.text};
        [[DLACoreDataStore sharedStore] updateDriverInfo:addressDictionary];
        
        // Dismiss view controller
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    
    if (textField == self.streetTextField) {
        
        NSString *lastCharacter = [string length] > 0 ? [string substringFromIndex:[string length] - 1] : @"";
        
        if ([lastCharacter isEqualToString:@" "] && newLength > 1) {
            [textField setKeyboardType:UIKeyboardTypeASCIICapable];
            [textField reloadInputViews];
        }
        else if (newLength == 0) {
            [textField setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
            [textField reloadInputViews];
        }
        
        return YES;
    }
    if (textField == self.stateTextField) {
        return newLength > 2 ? NO : YES;
    }
    else if (textField == self.zipcodeTextField) {
        return newLength > 5 ? NO : YES;
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (![textField.text isEqualToString:@""]) {
        if (textField == self.streetTextField)
            [self.cityTextField becomeFirstResponder];
        else if (textField == self.cityTextField)
            [self.stateTextField becomeFirstResponder];
        else if (textField == self.stateTextField)
            [self.zipcodeTextField becomeFirstResponder];
    }
    
    return YES;
}

@end
