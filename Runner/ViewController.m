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

- (void)viewDidLoad {
    [super viewDidLoad];
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
//    self.map.delegate = self;
    [self.map setUserTrackingMode:MKUserTrackingModeFollow animated: YES];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startRun:(id)sender {
    _startTime = [NSDate date];
    
//    if(_startTime) {
//        NSTimeInterval timeInterval = [_startTime timeIntervalSinceNow];
//        _timeLabel.text = stringFromTimeInterval(timeInterval);
//    }
    
    
    
    //add another button, make them toggle between the two buttons
    
    _startRun.backgroundColor = UIColor.redColor;
    [self.startRun setTitle:@"Stop Run" forState:UIControlStateNormal];
}

//- (NSString *)stringFromTimeInterval:(NSTimeInterval)interval {
//    NSInteger ti = (NSInteger)interval;
//    NSInteger seconds = ti % 60;
//    NSInteger minutes = (ti / 60) % 60;
//    NSInteger hours = (ti / 3600);
//    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)hours, (long)minutes, (long)seconds];
//}


@end
