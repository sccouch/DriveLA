//
//  DLADriversLicenseViewController.m
//  DriveLA
//
//  Created by Jack Okerman on 4/2/14.
//  Copyright (c) 2014 USC. All rights reserved.
//

#import "DLADriversLicenseViewController.h"

@interface DLADriversLicenseViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *licenseNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *expirationDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@end
@implementation DLADriversLicenseViewController

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
        [self.dateFormatter setDateFormat:@"MMM dd, yyyy"];
    }
//    [self initExpirationDateTextField];
//    [self.expirationDateTextField setDelegate:self];
//    self.expirationDateTextField.tintColor = [UIColor clearColor];
    
//    Driver *driver = [[DLACoreDataStore sharedStore] fetchDriver];
//    if (driver.name) {
//        self.nameTextField.text = driver.name;
//    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    Driver *driver = [[DLACoreDataStore sharedStore] fetchDriver];
    if (driver) {
        self.nameLabel.text = [driver getFullName];
        
        
        self.addressLabel.text = [driver getAddress];
        
        NSDictionary *attributes = @{NSFontAttributeName: self.addressLabel.font};
        CGRect rect = [[driver getAddress] boundingRectWithSize:CGSizeMake(206, 48) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        
        [self.addressLabel setFrame:CGRectMake(self.tableView.bounds.size.width - 33 - rect.size.width, 65.0/2 - rect.size.height/2, rect.size.width, rect.size.height)];
        
        if (driver.phone)
            self.phoneLabel.text = driver.phone;
        if (driver.email)
            self.emailLabel.text = driver.email;
        if (driver.driversLicenseNumber)
            self.licenseNumberLabel.text = driver.driversLicenseNumber;
        if (driver.driversLicenseExpirationDate) {
            self.expirationDateLabel.text = [self.dateFormatter stringFromDate:driver.driversLicenseExpirationDate];
        }
            
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0)
        return 4;
    else if (section == 1)
        return 2;
    else
        return -1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    if (indexPath.section == 0 && indexPath.row == 1)
//        return 200;
//    else
//        return self.tableView.rowHeight;
//    
//}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
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
