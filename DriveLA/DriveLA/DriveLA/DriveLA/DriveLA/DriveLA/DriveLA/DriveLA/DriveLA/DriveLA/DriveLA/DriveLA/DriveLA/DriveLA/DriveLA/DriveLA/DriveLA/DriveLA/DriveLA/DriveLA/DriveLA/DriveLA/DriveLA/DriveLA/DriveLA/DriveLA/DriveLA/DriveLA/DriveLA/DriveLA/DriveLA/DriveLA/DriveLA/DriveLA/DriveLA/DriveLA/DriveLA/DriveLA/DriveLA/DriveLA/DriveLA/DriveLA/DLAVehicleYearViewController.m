//
//  DLAVehicleYearViewController.m
//  DriveLA
//
//  Created by Jack Okerman on 4/15/14.
//  Copyright (c) 2014 USC. All rights reserved.
//

#import "DLAVehicleYearViewController.h"

@interface DLAVehicleYearViewController ()
@property (weak, nonatomic) IBOutlet UITextField *yearTextField;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) NSMutableArray *years;
@property (strong, nonatomic) UIPickerView *yearPicker;

@end

@implementation DLAVehicleYearViewController

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
    
    self.yearTextField.delegate = self;
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"yyyy"];
    
    self.years = [[NSMutableArray alloc] init];
    int nextYear = [[self.dateFormatter stringFromDate:[NSDate date]] intValue] + 1;
    for (int i = nextYear; i >= 1960; i--) {
        [self.years addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    self.yearPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 50, 100, 150)];
    self.yearPicker.delegate = self;
    self.yearPicker.delegate = self;
    self.yearPicker.showsSelectionIndicator = YES;
    self.yearTextField.inputView = self.yearPicker;
    
    [self.yearTextField becomeFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    Driver *driver = [[DLACoreDataStore sharedStore] fetchDriver];
    
    if (driver) {
        if (driver.vehicleYear) {
            NSString *yearString = [self.dateFormatter stringFromDate:driver.vehicleYear];
            self.yearTextField.text = yearString;
            [self.yearPicker selectRow:[self.years indexOfObject:yearString] inComponent:0 animated:NO];
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
    
    // Save to data store
    NSDictionary *myDictionary = @{@"vehicleYear": [self.dateFormatter dateFromString:self.yearTextField.text]};
    [[DLACoreDataStore sharedStore] updateDriverInfo:myDictionary];
    
    // Dismiss view controller
    [self.navigationController popViewControllerAnimated:YES];
}

//- (void) textFieldDidBeginEditing:(UITextField *)textField {
//    if (textField == self.yearTextField) {
//        
//    }
//}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.years.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.years[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    self.yearTextField.text = self.years[row];
}

@end
