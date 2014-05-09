//
//  DLAAccidentInputViewController.m
//  DriveLA
//
//  Created by Jack Okerman on 5/7/14.
//  Copyright (c) 2014 USC. All rights reserved.
//

#import "DLAAccidentInputViewController.h"

@interface DLAAccidentInputViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *driverPhoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *streetTextField;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property (weak, nonatomic) IBOutlet UITextField *stateTextField;
@property (weak, nonatomic) IBOutlet UITextField *zipcodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *insuranceCompanyTextField;
@property (weak, nonatomic) IBOutlet UITextField *policyNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *insurancePhoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *makeTextField;
@property (weak, nonatomic) IBOutlet UITextField *modelTextField;
@property (weak, nonatomic) IBOutlet UITextField *licensePlateTextField;

@end

@implementation DLAAccidentInputViewController

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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.nameTextField.delegate = self;
    self.driverPhoneTextField.delegate = self;
    self.streetTextField.delegate = self;
    self.cityTextField.delegate = self;
    self.stateTextField.delegate = self;
    self.zipcodeTextField.delegate = self;
    self.insuranceCompanyTextField.delegate = self;
    self.policyNumberTextField.delegate = self;
    self.insurancePhoneTextField.delegate = self;
    self.makeTextField.delegate = self;
    self.modelTextField.delegate = self;
    self.licensePlateTextField.delegate = self;
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == self.nameTextField)
        [self.driverPhoneTextField becomeFirstResponder];
    else if (textField == self.driverPhoneTextField)
        [self.streetTextField becomeFirstResponder];
    else if (textField == self.streetTextField)
        [self.cityTextField becomeFirstResponder];
    else if (textField == self.cityTextField)
        [self.stateTextField becomeFirstResponder];
    else if (textField == self.stateTextField)
        [self.zipcodeTextField becomeFirstResponder];
    else if (textField == self.zipcodeTextField)
        [self.insuranceCompanyTextField becomeFirstResponder];
    else if (textField == self.insuranceCompanyTextField)
        [self.policyNumberTextField becomeFirstResponder];
    else if (textField == self.policyNumberTextField)
        [self.insurancePhoneTextField becomeFirstResponder];
    else if (textField == self.insurancePhoneTextField)
        [self.makeTextField becomeFirstResponder];
    else if (textField == self.makeTextField)
        [self.modelTextField becomeFirstResponder];
    else if (textField == self.modelTextField)
        [self.licensePlateTextField becomeFirstResponder];
    else if (textField == self.licensePlateTextField)
        [self.nameTextField becomeFirstResponder];
    
    return YES;
}

- (IBAction)saveButtonPressed:(id)sender {
    
    if ([self shouldWarn]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"Looks like you're still missing some things you'll need later."
                                                       delegate:self
                                              cancelButtonTitle:@"Back"
                                              otherButtonTitles:@"That's OK", nil];
        [alert show];
    }
    else
        [self saveAccident];
    
}

- (void)saveAccident {
    
    Accident *accident = [[Accident alloc] init];
    
    accident.name = self.nameTextField.text;
    accident.streetAddress = self.streetTextField.text;
    accident.city = self.cityTextField.text;
    accident.state = self.stateTextField.text;
    accident.zipcode = self.zipcodeTextField.text;
    accident.driverPhone = self.driverPhoneTextField.text;
    accident.insuranceCompany = self.insuranceCompanyTextField.text;
    accident.policyNumber = self.policyNumberTextField.text;
    accident.insurancePhone = self.insurancePhoneTextField.text;
    accident.make = self.makeTextField.text;
    accident.model = self.modelTextField.text;
    accident.plateNumber = self.licensePlateTextField.text;
    
    Driver *driver = [[DLACoreDataStore sharedStore] fetchDriver];
    
    NSMutableArray *accidents;
    if (driver.accidents)
        accidents = [NSKeyedUnarchiver unarchiveObjectWithData: driver.accidents];
    else
        accidents = [[NSMutableArray alloc] init];
    
    [accidents addObject:accident];
    
    NSDictionary *driverDictionary = @{@"accidents": [NSKeyedArchiver archivedDataWithRootObject:accidents]};
    [[DLACoreDataStore sharedStore] updateDriverInfo:driverDictionary];
    
}

- (BOOL)shouldWarn {
    
    return [self.nameTextField.text isEqualToString:@""] ||
        [self.streetTextField.text isEqualToString:@""] ||
        [self.cityTextField.text isEqualToString:@""] ||
        [self.stateTextField.text isEqualToString:@""] ||
        [self.zipcodeTextField.text isEqualToString:@""] ||
        [self.driverPhoneTextField.text isEqualToString:@""] ||
        [self.insuranceCompanyTextField.text isEqualToString:@""] ||
        [self.policyNumberTextField.text isEqualToString:@""] ||
        [self.insurancePhoneTextField.text isEqualToString:@""] ||
        [self.makeTextField.text isEqualToString:@""] ||
        [self.modelTextField.text isEqualToString:@""] ||
        [self.licensePlateTextField.text isEqualToString:@""];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1)
        [self saveAccident];
    
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
    
    if (textField == self.driverPhoneTextField || textField == self.insurancePhoneTextField) {
        int length = [self getLength:textField.text];
        
        if(length == 10) {
            if(range.length == 0)
                return NO;
        }
        
        if(length == 3) {
            NSString *num = [self formatNumber:textField.text];
            textField.text = [NSString stringWithFormat:@"(%@) ",num];
            if(range.length > 0)
                textField.text = [NSString stringWithFormat:@"%@",[num substringToIndex:3]];
        }
        else if(length == 6) {
            NSString *num = [self formatNumber:textField.text];
            textField.text = [NSString stringWithFormat:@"(%@) %@-",[num  substringToIndex:3],[num substringFromIndex:3]];
            if(range.length > 0)
                textField.text = [NSString stringWithFormat:@"(%@) %@",[num substringToIndex:3],[num substringFromIndex:3]];
        }
    }
    
    return YES;
}

-(NSString*)formatNumber:(NSString*)mobileNumber
{
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    int length = [mobileNumber length];
    if(length > 10) {
        mobileNumber = [mobileNumber substringFromIndex: length-10];
    }
    return mobileNumber;
}


-(int)getLength:(NSString*)mobileNumber
{
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    int length = [mobileNumber length];
    return length;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0)
        return 4;
    else
        return 3;
}


@end
