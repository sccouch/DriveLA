//
//  DLAInsurancePolicyViewController.m
//  DriveLA
//
//  Created by Jack Okerman on 4/15/14.
//  Copyright (c) 2014 USC. All rights reserved.
//

#import "DLAInsurancePolicyViewController.h"

@interface DLAInsurancePolicyViewController ()
@property (weak, nonatomic) IBOutlet UITextField *policyNumberTextField;

@end

@implementation DLAInsurancePolicyViewController

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
    
    [self.policyNumberTextField becomeFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    Driver *driver = [[DLACoreDataStore sharedStore] fetchDriver];
    
    if (driver) {
        if (driver.insurancePolicyNumber)
            self.policyNumberTextField.text = driver.insurancePolicyNumber;
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
    // Validate data
    BOOL valid = YES;
    if ([self.policyNumberTextField.text isEqualToString:@""]) {
        [CSNotificationView showInViewController:self
                                           style:CSNotificationViewStyleError
                                         message:@"Enter a policy number"];
        valid = NO;
    }
    
    if (valid) {
        // Save to data store
        NSDictionary *myDictionary = @{@"insurancePolicyNumber": self.policyNumberTextField.text};
        [[DLACoreDataStore sharedStore] updateDriverInfo:myDictionary];
    
        // Dismiss view controller
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
