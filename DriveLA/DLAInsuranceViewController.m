//
//  DLAInsuranceViewController.m
//  DriveLA
//
//  Created by Jack Okerman on 4/15/14.
//  Copyright (c) 2014 USC. All rights reserved.
//

#import "DLAInsuranceViewController.h"

@interface DLAInsuranceViewController ()
@property (weak, nonatomic) IBOutlet UILabel *companyTextField;
@property (weak, nonatomic) IBOutlet UILabel *policyNumberTextField;
@property (weak, nonatomic) IBOutlet UILabel *phoneTextField;

@end

@implementation DLAInsuranceViewController

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
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    Driver *driver = [[DLACoreDataStore sharedStore] fetchDriver];
    if (driver) {
        if (driver.insuranceCompany)
            self.companyTextField.text = driver.insuranceCompany;
        if (driver.insurancePolicyNumber)
            self.policyNumberTextField.text = driver.insurancePolicyNumber;
        if (driver.insurancePhone)
            self.phoneTextField.text = driver.insurancePhone;
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
    return 3;
}

@end
