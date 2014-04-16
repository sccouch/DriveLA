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
    
    // Save to data store
    NSDictionary *addressDictionary = @{@"addressStreet": self.streetTextField.text,
                                        @"addressCity": self.cityTextField.text,
                                        @"addressState": self.stateTextField.text,
                                        @"addressZipcode": self.zipcodeTextField.text};
    [[DLACoreDataStore sharedStore] updateDriverInfo:addressDictionary];
    
    // Dismiss view controller
    [self.navigationController popViewControllerAnimated:YES];
}

@end
