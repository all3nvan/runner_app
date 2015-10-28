//
//  ViewController.m
//  Runner
//
//  Created by Allen Van on 10/19/15.
//  Copyright © 2015 Group9. All rights reserved.
//

#import "ViewController.h"
#import "SWRevealViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize CLController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CLController = [[CoreLocationController alloc] init];
    CLController.speedDelegate = self;
    [CLController.speedManager startUpdatingLocation];
    
    _startRun.layer.cornerRadius = _startRun.bounds.size.width/2;
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if (revealViewController)
    {
        [self.menuButton setTarget: self.revealViewController];
        [self.menuButton setAction: @selector( revealToggle:)];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    [self.locationManager requestWhenInUseAuthorization];
    self.map.showsUserLocation = YES;
    [self.map setUserTrackingMode:MKUserTrackingModeFollow animated: YES];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startRun:(id)sender {
    UIButton *button = (UIButton *) sender;
    if(button.isSelected == NO){
        button.selected = YES;
        _startTime = [NSDate date];
        
        //    if(_startTime) {
        //        NSTimeInterval timeInterval = [_startTime timeIntervalSinceNow];
        //        _timeLabel.text = stringFromTimeInterval(timeInterval);
        //    }
        
        
        
        _startRun.backgroundColor = UIColor.redColor;
        [self.startRun setTitle:@"Stop Run" forState:UIControlStateNormal];
    }
    else{
        button.selected = NO;
        _startRun.backgroundColor = [UIColor colorWithRed: 0.0f green: 0.666667f blue: 0.0428568f alpha:1.0];
        [self.startRun setTitle:@"Start Run" forState:UIControlStateNormal];
    }
}

//- (NSString *)stringFromTimeInterval:(NSTimeInterval)interval {
//    NSInteger ti = (NSInteger)interval;
//    NSInteger seconds = ti % 60;
//    NSInteger minutes = (ti / 60) % 60;
//    NSInteger hours = (ti / 3600);
//    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)hours, (long)minutes, (long)seconds];
//}

//******Sets label in storyboard to device location******//
-(void) locationUpdate:(CLLocation*) location {
    locationLabel.text = @(location.speed).stringValue;
}
//******Sets label to error if an error occurs******//
-(void) locationError:(NSError *)error{
    locationLabel.text = @"Speed Unavailable";
}

@end
