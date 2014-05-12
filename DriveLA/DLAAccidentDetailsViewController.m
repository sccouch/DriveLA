//
//  DLAAccidentDetailsViewController.m
//  DriveLA
//
//  Created by Kalyn Nakano on 5/8/14.
//  Copyright (c) 2014 USC. All rights reserved.
//

#import "DLAAccidentDetailsViewController.h"

@interface DLAAccidentDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *driverInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *myInfoLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *accidentDetailsLabel;

@end

@implementation DLAAccidentDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.scrollView.contentSize = CGSizeMake(320, 1000);
    
    Driver *driver = [[DLACoreDataStore sharedStore] fetchDriver];
    NSMutableArray *accidents = [NSKeyedUnarchiver unarchiveObjectWithData: driver.accidents];
    NSIndexPath *indexPath = self.index;
    Accident *accident = [accidents objectAtIndex:indexPath.row];
    self.accident = accident;
    
    NSString *myInformation = [[NSString alloc] init];
    myInformation = [NSString stringWithFormat:@"My Information\nName: %@\nAddress: %@\nPhone: %@\n\nInsurance Company: %@\nInsurance Policy Number: %@\nInsurance Company Phone Number: %@\n\nVehicle Make: %@\nVehicle Model: %@\nLicense Plate Number: %@\n", [driver getFullName], [driver getAddress], driver.phone, driver.insuranceCompany, driver.insurancePolicyNumber, driver.insurancePhone, driver.vehicleMake, driver.vehicleModel, driver.licensePlateNumber];
    
    NSString *otherDriverInformation = [[NSString alloc] init];
    otherDriverInformation = [NSString stringWithFormat:@"Other Driver's Information\nName: %@\nAddress: %@\nPhone: %@\n\nInsurance Company: %@\nInsurance Policy Number: %@\nInsurance Company Phone Number: %@\n\nVehicle Make: %@\nVehicle Model: %@\nLicense Plate Number: %@\n", accident.name, accident.streetAddress, accident.driverPhone, accident.insuranceCompany, accident.policyNumber, accident.insurancePhone, accident.make, accident.model, accident.plateNumber];
    
    NSString *accidentDetails = [[NSString alloc] init];
    accidentDetails = [NSString stringWithFormat:@"Accident Details\nCross Streets: %@\nDetails: %@\n", accident.crossStreets, accident.accidentDetails];
    
    
    self.driverInfoLabel.text = otherDriverInformation;
    [self.driverInfoLabel sizeToFit];
    
    self.myInfoLabel.text = myInformation;
    [self.myInfoLabel sizeToFit];
    
    self.accidentDetailsLabel.text = accidentDetails;
    [self.accidentDetailsLabel sizeToFit];
}

- (IBAction)emailButtonPressed:(id)sender {
    
    [self sendEmail];
}

-(void) sendEmail{
    Driver *driver = [[DLACoreDataStore sharedStore] fetchDriver];
    NSMutableArray *accidents = [NSKeyedUnarchiver unarchiveObjectWithData: driver.accidents];
    NSIndexPath *indexPath = self.index;
    Accident *accident = [accidents objectAtIndex:indexPath.row];
    
    NSString *myInformation = [[NSString alloc] init];
    myInformation = [NSString stringWithFormat:@"My Information\nName: %@\nAddress: %@\nPhone: %@\n\nInsurance Company: %@\nInsurance Policy Number: %@\nInsurance Company Phone Number: %@\n\nVehicle Make: %@\nVehicle Model: %@\nLicense Plate Number: %@\n", [driver getFullName], [driver getAddress], driver.phone, driver.insuranceCompany, driver.insurancePolicyNumber, driver.insurancePhone, driver.vehicleMake, driver.vehicleModel, driver.licensePlateNumber];
    
    NSString *otherDriverInformation = [[NSString alloc] init];
    otherDriverInformation = [NSString stringWithFormat:@"Other Driver's Information\nName: %@\nAddress: %@\nPhone: %@\n\nInsurance Company: %@\nInsurance Policy Number: %@\nInsurance Company Phone Number: %@\n\nVehicle Make: %@\nVehicle Model: %@\nLicense Plate Number: %@\n", accident.name, accident.streetAddress, accident.driverPhone, accident.insuranceCompany, accident.policyNumber, accident.insurancePhone, accident.make, accident.model, accident.plateNumber];
    
    NSString *accidentDetails = [[NSString alloc] init];
    accidentDetails = [NSString stringWithFormat:@"Accident Details\nCross Streets: %@\nDetails: %@\n", accident.crossStreets, accident.accidentDetails];
    
    NSString *message = [[NSString alloc] init];
    message = [NSString stringWithFormat:@"Accident On: %@\n\n%@\n----------------------------\n\n%@\n----------------------------\n\n%@", accident.date,myInformation, otherDriverInformation, accidentDetails];
    
    if([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailCont = [[MFMailComposeViewController alloc] init];
        mailCont.mailComposeDelegate = self;
        
        [mailCont setSubject:@"DriveLA: Your Recent Accident"];
        [mailCont setToRecipients:[NSArray arrayWithObjects:driver.email, accident.email, nil]];
        [mailCont setMessageBody:message isHTML:NO];
        
        [self presentViewController:mailCont animated:YES completion:nil];
    }
    
}


// Then implement the delegate method
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
