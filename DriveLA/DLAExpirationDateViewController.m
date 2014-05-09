//
//  DLAExpirationDateViewController.m
//  DriveLA
//
//  Created by Jack Okerman on 4/14/14.
//  Copyright (c) 2014 USC. All rights reserved.
//

#import "DLAExpirationDateViewController.h"

@interface DLAExpirationDateViewController ()
@property (weak, nonatomic) IBOutlet UITextField *expirationDateTextField;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) UIDatePicker *datePicker;

@end

@implementation DLAExpirationDateViewController

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
    
    self.expirationDateTextField.delegate = self;
    self.expirationDateTextField.tintColor = [UIColor clearColor];
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"MMM dd, yyyy"];
    
    self.datePicker = [[UIDatePicker alloc] init];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    [self.datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    Driver *driver = [[DLACoreDataStore sharedStore] fetchDriver];
    if (driver && driver.driversLicenseExpirationDate)
        [self.datePicker setDate:driver.driversLicenseExpirationDate];
    
    self.expirationDateTextField.inputView = self.datePicker;
    [self.expirationDateTextField becomeFirstResponder];
    
    self.expirationDateTextField.text = [self.dateFormatter stringFromDate: [[NSDate alloc] init]];
    
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    Driver *driver = [[DLACoreDataStore sharedStore] fetchDriver];
    
    if (driver) {
    
        if (driver.driversLicenseExpirationDate) {
            self.expirationDateTextField.text = [self.dateFormatter stringFromDate:driver.driversLicenseExpirationDate];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (IBAction)saveButtonPressed:(id)sender {
    
    // Save to data store
    NSDictionary *expirationDateDictionary = @{@"driversLicenseExpirationDate": [self.dateFormatter dateFromString:self.expirationDateTextField.text]};
    [[DLACoreDataStore sharedStore] updateDriverInfo:expirationDateDictionary];
    
    // Dismiss view controller
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)datePickerValueChanged:(id)sender {
    NSDate *pickerDate = [sender date];
    self.expirationDateTextField.text = [self.dateFormatter stringFromDate:pickerDate];
}

@end
