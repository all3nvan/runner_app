//
//  ViewController.m
//  Runner
//
//  Created by Allen Van on 10/19/15.
//  Copyright © 2015 Group9. All rights reserved.
//

#import "ViewController.h"
#import "SWRevealViewController.h"

static bool const isMetric = YES;
static float const metersInKM = 1000;
static float const metersInMile = 1609.344;

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

//******Handles when a user selects Start/Stop Run******//
- (IBAction)startRun:(id)sender {
    if(self.timer){
        [self.timer invalidate];
        self.timer = nil;
    }
    UIButton *button = (UIButton *) sender;
    if(button.isSelected == NO){ //If user starts a run
        button.selected = YES;
        self.seconds = 0;
        self.distance = 0;
        self.locations = [NSMutableArray array];
        _startRun.backgroundColor = UIColor.redColor;
        [self.startRun setTitle:@"Stop Run" forState:UIControlStateNormal];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:(1.0) target:self selector:@selector(eachSecond) userInfo:nil repeats:YES];
        [self startLocationUpdates];
        
        // Initialize run
        _run = [[Run alloc] init];
        _run.timestamp = [NSDate dateWithTimeIntervalSinceNow:0];
    }
    else{ //User stops a run
        self.timer = nil;
        [self.locationManager stopUpdatingLocation];
        button.selected = NO;
        _startRun.backgroundColor = [UIColor colorWithRed: 0.0f green: 0.666667f blue: 0.0428568f alpha:1.0];
        [self.startRun setTitle:@"Start Run" forState:UIControlStateNormal];
        
        // Saves run
        _run.distance = self.distance;
        _run.duration = self.seconds;
//        NSLog(@"%@", self.locations);
//        for(CLLocation* location in self.locations){
//            NSLog(@"%@", location);
//        }
    }
}

//******Sets label in storyboard to device speed******//
-(void) locationUpdate:(CLLocation*) location {
    NSString* speedText = @(location.speed).stringValue;
    [locationLabel setText:[NSString stringWithFormat:@"%@ mps", speedText]];
}
//******Sets label to error if an error occurs******//
-(void) locationError:(NSError *)error{
    locationLabel.text = @"Speed Unavailable";
}

//******Starts location updates******//
-(void) startLocationUpdates{
    if(self.locationManager == nil){
        self.locationManager = [[CLLocationManager alloc] init];
    }
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.activityType = CLActivityTypeFitness;
    self.locationManager.distanceFilter = 10;
    [self.locationManager startUpdatingLocation];
}

//******Used in timer to calculate seconds/minutes and distance/pace******//
-(void) eachSecond{
    self.seconds++;
    self.timeLabel.text = [NSString stringWithFormat:@"%@", [self stringifySecondCount:self.seconds usingLongFormat:NO]];
    self.distLabel.text = [NSString stringWithFormat:@"%@", [self stringifyDistance:self.distance]];
    //self.paceLabel.text = [NSString stringWithFormat:@"Pace: %@", [self stringifyAvgPaceFromDist:self.distance]];
}

//******Formats the timer according to how long the run is******//
-(NSString*) stringifySecondCount:(int)seconds usingLongFormat:(BOOL)longFormat{
    int remainingSeconds = seconds;
    int hours = remainingSeconds/3600;
    remainingSeconds = remainingSeconds - hours * 3600;
    int minutes = remainingSeconds/60;
    remainingSeconds = remainingSeconds - minutes * 60;
    
    if(longFormat){
        if(hours > 0){
            return [NSString stringWithFormat:@"%ihr %imin %isec", hours, minutes, remainingSeconds];
        }
        else if(minutes > 0){
            return [NSString stringWithFormat:@"%imin %isec", minutes, remainingSeconds];
        }
        else{
            return [NSString stringWithFormat:@"%isec", remainingSeconds];
        }
    }
    else{
        if(hours > 0){
            return [NSString stringWithFormat:@"%02i:%02i:%02i", hours, minutes, remainingSeconds];
        }
        else if (minutes > 0){
            return [NSString stringWithFormat:@"%02i:%02i", minutes, remainingSeconds];
        }
        else{
            return [NSString stringWithFormat:@"00:%02i", remainingSeconds];
        }
    }
}

//******Stringifies the distance run******//
-(NSString*) stringifyDistance:(float)meters{
    float unitDivider;
    NSString* unitName;
    
    if(isMetric){
        unitName = @"km";
        unitDivider = metersInKM;
    }
    else{
        unitName = @"mi";
        unitDivider = metersInMile;
    }
    return [NSString stringWithFormat:@"%.2f %@", (meters / unitDivider), unitName];
}

//******Stringifies the average pace******//
-(NSString*) stringifyAvgPaceFromDist:(float)meters overTime:(int) seconds{
    if(seconds == 0 || meters == 0){
        return @"0";
    }
    float avgPaceSecMeters = seconds / meters;
    float unitMultiplier;
    NSString* unitName;
    
    if(isMetric){
        unitName = @"min/km";
        unitMultiplier = metersInKM;
    }
    else{
        unitName = @"min/mi";
        unitMultiplier = metersInMile;
    }
    
    int paceMin = (int) ((avgPaceSecMeters * unitMultiplier) / 60);
    int paceSec = (int) (avgPaceSecMeters * unitMultiplier - (paceMin * 60));
    
    return [NSString stringWithFormat:@"%i:%02i %@", paceMin, paceSec, unitName];
}

//******Calculates the distance of the run and speed of the device******//
-(void) locationManager:(CLLocationManager*) manager didUpdateLocations:(NSArray*) locations{
    CLLocation *loc = [locations lastObject];
    [self locationUpdate:loc];
    
    for(CLLocation* newLocation in locations){
        if(newLocation.horizontalAccuracy<20){
            
            if(self.locations.count > 0){
                self.distance += [newLocation distanceFromLocation:self.locations.lastObject];
            }
            
            [self.locations addObject:newLocation];
        }
    }
}

@end
