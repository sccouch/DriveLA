//
//  DLAEmailInputViewController.m
//  DriveLA
//
//  Created by Jack Okerman on 4/10/14.
//  Copyright (c) 2014 USC. All rights reserved.
//

#import "DLAEmailInputViewController.h"

@interface DLAEmailInputViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@end

@implementation DLAEmailInputViewController

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
    
    [self.emailTextField becomeFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    Driver *driver = [[DLACoreDataStore sharedStore] fetchDriver];
    
    if (driver) {
        if (driver.email) {
            self.emailTextField.text = driver.email;
        }
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
    return 1;
}

- (IBAction)saveButtonPressed:(id)sender {
    // Validate input
    BOOL valid = YES;
    if ([self.emailTextField.text isEqualToString:@""]) {
        [CSNotificationView showInViewController:self
                                           style:CSNotificationViewStyleError
                                         message:@"Enter an email address"];
        valid = NO;
    }

    else if (![self validateEmail:self.emailTextField.text]) {
        [CSNotificationView showInViewController:self
                                           style:CSNotificationViewStyleError
                                         message:@"Enter a valid email address"];
        valid = NO;
    }
    
    if (valid) {
        // Save to data store
        NSDictionary *emailDictionary = @{@"email": self.emailTextField.text};
        [[DLACoreDataStore sharedStore] updateDriverInfo:emailDictionary];
        
        // Dismis view controller
        [self.navigationController popViewControllerAnimated:YES];
    }

}

- (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}

@end
