//
//  DLAHomeViewController.m
//  DriveLA
//
//  Created by Jack Okerman on 3/31/14.
//  Copyright (c) 2014 USC. All rights reserved.
//

#import "DLAHomeViewController.h"

@interface DLAHomeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *driverDocumentsLabel;
@property (weak, nonatomic) IBOutlet UILabel *driverDocumentsDetailsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *driverDocumentsImage;
@property (weak, nonatomic) IBOutlet UILabel *accidentDocumentsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *accidentDocumentsImage;
@end

NSInteger cellCount = 3;

@implementation DLAHomeViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    
    UIColor *navBarColor = [UIColor colorWithRed:45/255.0 green:49/255.0 blue:59/255.0 alpha:1.0];
    
    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    if ([[ver objectAtIndex:0] intValue] >= 7) {
        self.navigationController.navigationBar.barTintColor = navBarColor;
        self.navigationController.navigationBar.translucent = NO;
    }else {
        self.navigationController.navigationBar.tintColor = navBarColor;
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    Driver *driver = [[DLACoreDataStore sharedStore] fetchDriver];
    if (driver.allDocumentsAdded && !driver.accidents) {
        UITableViewCell *driverDocumentsCell = [super tableView:tableView cellForRowAtIndexPath:0];
        UIColor *green = [UIColor colorWithRed:80/255.0 green:154/255.0 blue:113/255.0 alpha:1.0];
        [driverDocumentsCell setBackgroundColor:green];
        [self.driverDocumentsImage setImage: [UIImage imageNamed:@"driver-documents.png"]];
        
        NSIndexPath *path = [NSIndexPath indexPathForRow:1 inSection:0];
        UITableViewCell *accidentDocumentsCell = [super tableView:tableView cellForRowAtIndexPath:path];
        accidentDocumentsCell.accessoryType = UITableViewCellAccessoryNone;
        
        CGRect frame = self.driverDocumentsLabel.frame;
        frame.origin.y=15;
        frame.origin.x= 105;
        self.driverDocumentsLabel.frame= frame;
        
        self.driverDocumentsLabel.numberOfLines = 3;
        [self.driverDocumentsLabel sizeToFit];
        self.driverDocumentsLabel.text = @"You’re prepared!\nWe have organized\nyour driver documents.";
        self.driverDocumentsDetailsLabel.text = @"Click to view or edit your documents";
        self.accidentDocumentsLabel.hidden = YES;
        self.accidentDocumentsImage.hidden = YES;
    }
    if (driver.accidents) {
        if (indexPath.row == 1  && indexPath.section == 0)
            return 78.0;
        if (indexPath.row == 0 && indexPath.section == 0)
            return 78.0;
        
        self.accidentDocumentsLabel.hidden = NO;
        self.accidentDocumentsImage.hidden = NO;
        
        NSIndexPath *path = [NSIndexPath indexPathForRow:1 inSection:0];
        UITableViewCell *accidentDocumentsCell = [super tableView:tableView cellForRowAtIndexPath:path];
        accidentDocumentsCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        CGRect frame = self.driverDocumentsLabel.frame;
        frame.origin.y=3;
        frame.origin.x= 105;
        self.driverDocumentsLabel.frame= frame;
        
        self.driverDocumentsLabel.text = @"My Driver Documents";
        [self.driverDocumentsImage setImage: [UIImage imageNamed:@"driver-documents.png"]];
        UITableViewCell *driverDocumentsCell = [super tableView:tableView cellForRowAtIndexPath:0];
        UIColor *lightBlue = [UIColor colorWithRed:112/255.0 green:180/255.0 blue:192/255.0 alpha:1.0];
        [driverDocumentsCell setBackgroundColor:lightBlue];
        self.driverDocumentsDetailsLabel.hidden = YES;
        
    }
    else {
        [self.driverDocumentsLabel sizeToFit];
        NSIndexPath *path = [NSIndexPath indexPathForRow:1 inSection:0];
        UITableViewCell *accidentDocumentsCell = [super tableView:tableView cellForRowAtIndexPath:path];
        accidentDocumentsCell.accessoryType = UITableViewCellAccessoryNone;
        self.accidentDocumentsLabel.hidden = YES;
        self.accidentDocumentsImage.hidden = YES;
        
        if (indexPath.row == 0 && indexPath.section == 0)
            return 156.0;
        else if (indexPath.row == 1 && indexPath.section == 0)
            return 0.0;
    }
    
    return 105.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    // Return the number of rows in the section.

     return 4;

}

- (void)addAccidentsCell
{
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
    [indexPaths addObject:path];
    cellCount= cellCount+1;
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationRight];
}

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
