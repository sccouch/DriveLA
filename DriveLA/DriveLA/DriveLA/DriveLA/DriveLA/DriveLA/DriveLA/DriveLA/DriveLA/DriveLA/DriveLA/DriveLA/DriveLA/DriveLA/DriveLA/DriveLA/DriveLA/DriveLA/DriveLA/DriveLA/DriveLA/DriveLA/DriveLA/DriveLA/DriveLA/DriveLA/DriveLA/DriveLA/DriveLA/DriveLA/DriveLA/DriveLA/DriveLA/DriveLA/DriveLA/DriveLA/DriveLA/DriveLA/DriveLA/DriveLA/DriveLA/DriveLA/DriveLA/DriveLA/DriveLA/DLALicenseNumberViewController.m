//
//  DLALicenseNumberViewController.m
//  DriveLA
//
//  Created by Jack Okerman on 4/14/14.
//  Copyright (c) 2014 USC. All rights reserved.
//

#import "DLALicenseNumberViewController.h"

@interface DLALicenseNumberViewController ()
@property (weak, nonatomic) IBOutlet UITextField *licenseNumberTextField;

@end

@implementation DLALicenseNumberViewController

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
    
    [self.licenseNumberTextField becomeFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    Driver *driver = [[DLACoreDataStore sharedStore] fetchDriver];
    
    if (driver) {
        if (driver.driversLicenseNumber) {
            self.licenseNumberTextField.text = driver.driversLicenseNumber;
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
    
    // Validate data
    BOOL valid = YES;
    if ([self.licenseNumberTextField.text isEqualToString:@""]) {
        [CSNotificationView showInViewController:self
                                           style:CSNotificationViewStyleError
                                         message:@"Enter a license number"];
        valid = NO;
    }
    
    if (valid) {
        // Save to data store
        NSDictionary *licenceNumberDictionary = @{@"driversLicenseNumber": self.licenseNumberTextField.text};
        [[DLACoreDataStore sharedStore] updateDriverInfo:licenceNumberDictionary];
        
        // Dismiss view controller
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}

@end
