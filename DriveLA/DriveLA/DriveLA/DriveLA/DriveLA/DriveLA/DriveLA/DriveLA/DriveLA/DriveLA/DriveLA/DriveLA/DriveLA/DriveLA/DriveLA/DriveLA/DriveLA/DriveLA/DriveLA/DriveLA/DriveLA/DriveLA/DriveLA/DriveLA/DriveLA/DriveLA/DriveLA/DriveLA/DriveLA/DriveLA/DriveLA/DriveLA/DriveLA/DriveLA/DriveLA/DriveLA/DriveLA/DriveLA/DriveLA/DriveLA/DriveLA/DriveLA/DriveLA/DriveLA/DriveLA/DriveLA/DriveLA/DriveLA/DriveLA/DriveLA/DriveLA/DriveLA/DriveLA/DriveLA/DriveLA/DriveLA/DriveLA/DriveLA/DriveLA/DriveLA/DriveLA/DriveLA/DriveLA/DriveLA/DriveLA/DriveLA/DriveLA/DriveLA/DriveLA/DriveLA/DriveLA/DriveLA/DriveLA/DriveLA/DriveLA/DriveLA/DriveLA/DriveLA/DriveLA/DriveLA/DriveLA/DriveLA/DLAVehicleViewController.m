//
//  DLAVehicleViewController.m
//  DriveLA
//
//  Created by Jack Okerman on 4/15/14.
//  Copyright (c) 2014 USC. All rights reserved.
//

#import "DLAVehicleViewController.h"

@interface DLAVehicleViewController ()
@property (weak, nonatomic) IBOutlet UILabel *makeTextField;
@property (weak, nonatomic) IBOutlet UILabel *modelTextField;
@property (weak, nonatomic) IBOutlet UILabel *yearTextField;
@property (weak, nonatomic) IBOutlet UILabel *colorTextField;
@property (weak, nonatomic) IBOutlet UILabel *licencePlateTextField;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@end

@implementation DLAVehicleViewController

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
    
    if (!self.dateFormatter) {
        self.dateFormatter = [[NSDateFormatter alloc] init];
        [self.dateFormatter setDateFormat:@"yyyy"];
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    Driver *driver = [[DLACoreDataStore sharedStore] fetchDriver];
    if (driver) {
        if (driver.vehicleMake)
            self.makeTextField.text = driver.vehicleMake;
        if (driver.vehicleModel)
            self.modelTextField.text = driver.vehicleModel;
        if (driver.vehicleYear) {
            self.yearTextField.text = [self.dateFormatter stringFromDate:driver.vehicleYear];
        }
        if (driver.vehicleColor)
            self.colorTextField.text = driver.vehicleColor;
        if (driver.licensePlateNumber)
            self.licencePlateTextField.text = driver.licensePlateNumber;
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
    return 5;
}

@end
