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

/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:; forIndexPath:indexPath];
 
 // Configure the cell...
 
 return cell;
 }
 */

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
