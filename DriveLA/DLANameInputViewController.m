//
//  DLANameInputViewController.m
//  DriveLA
//
//  Created by Jack Okerman on 4/9/14.
//  Copyright (c) 2014 USC. All rights reserved.
//

#import "DLANameInputViewController.h"

@interface DLANameInputViewController ()

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *middleInitialTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *suffixTextField;

@end

@implementation DLANameInputViewController

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
    
    // Set text field delegates
    self.firstNameTextField.delegate = self;
    self.middleInitialTextField.delegate = self;
    self.lastNameTextField.delegate = self;
    self.suffixTextField.delegate = self;
    
    [self.firstNameTextField becomeFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    Driver *driver = [[DLACoreDataStore sharedStore] fetchDriver];
    
    if (driver) {
        if (driver.firstName)
            self.firstNameTextField.text = driver.firstName;
        if (driver.middleInitial)
            self.middleInitialTextField.text = driver.middleInitial;
        if (driver.lastName)
            self.lastNameTextField.text = driver.lastName;
        if (driver.suffix)
            self.suffixTextField.text = driver.suffix;
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
    return 4;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (![textField.text isEqualToString:@""]) {
        if (textField == self.firstNameTextField)
            [self.middleInitialTextField becomeFirstResponder];
        else if (textField == self.middleInitialTextField)
            [self.lastNameTextField becomeFirstResponder];
        else if (textField == self.lastNameTextField)
            [self.suffixTextField becomeFirstResponder];
        else
            [self.firstNameTextField becomeFirstResponder];
    }

    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.middleInitialTextField) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return newLength > 1 ? NO : YES;
    }
    else if (textField == self.suffixTextField) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return newLength > 3 ? NO : YES;
    }
    
    return YES;
}

- (IBAction)saveButtonPressed:(id)sender {
    
    // Validate
    BOOL valid = YES;
    if ([self.firstNameTextField.text isEqualToString:@""]) {
        [CSNotificationView showInViewController:self
                                           style:CSNotificationViewStyleError
                                         message:@"Enter a first name"];
        valid = NO;
    }
    else if ([self.lastNameTextField.text isEqualToString:@""]) {
        [CSNotificationView showInViewController:self
                                           style:CSNotificationViewStyleError
                                         message:@"Enter a last name"];
        valid = NO;
    }
    
    
    
    if (valid) {
        // Save to data store
        NSMutableDictionary *nameInfo = [[NSMutableDictionary alloc] init];
        [nameInfo setObject:self.firstNameTextField.text forKey:@"firstName"];
        [nameInfo setObject:self.middleInitialTextField.text forKey:@"middleInitial"];
        [nameInfo setObject:self.lastNameTextField.text forKey:@"lastName"];
        [nameInfo setObject:self.suffixTextField.text forKey:@"suffix"];
        [[DLACoreDataStore sharedStore] updateDriverInfo:nameInfo];
        
        // Dismiss view controller
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
