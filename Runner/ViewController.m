//
//  ViewController.m
//  Runner
//
//  Created by Allen Van on 10/19/15.
//  Copyright © 2015 Group9. All rights reserved.
//

#import "ViewController.h"
#import "SWRevealViewController.h"
#import "Location.h"
#import "MulticolorPolylineSegment.h"
#import "PopUpViewController.h"

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
    self.map.delegate = self;
    // Do any additional setup after loading the view, typically from a nib.
}


//shows login view
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (![PFUser currentUser])
    {
        LoginViewController* loginView = [[LoginViewController alloc]init];
        loginView.delegate = self;
        loginView.signUpController.delegate = self;
        [self presentViewController:loginView animated:YES completion:nil];
    }
    
}

-(void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
        [self.map setUserTrackingMode:MKUserTrackingModeFollow animated: YES]; //Zooms back to map and follows user again
        [self.map removeOverlays:self.map.overlays]; //Removes polylines from map
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
        _run.locations = self.locations;
        
        PFObject *pfRun = [PFObject objectWithClassName:@"Run"];
        pfRun[@"user"] = [PFUser currentUser];
        pfRun[@"distance"] = [NSNumber numberWithFloat:_run.distance];
        pfRun[@"duration"] = [NSNumber numberWithInt:_run.duration];
        // TODO: set up run to location association in Parse
        //        pfRun[@"locations"] = _run.locations;
        [pfRun saveInBackground];
        
        //Displays polyline map of route that was run
        [self loadMap];
        
        //Displays popup window
        _popViewController = [[PopUpViewController alloc] initWithNibName:@"PopUpViewController" bundle:nil];
        [_popViewController setTitle:@"This is a popup view"];
        [_popViewController showInView:self.view withImage:[UIImage imageNamed:@"settings.png"] withMessage:@"Hello" animated:YES];
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
    self.paceLabel.text = [NSString stringWithFormat:@"%@", [self stringifyAvgPaceFromDist:self.distance overTime:self.seconds]];
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

//******Renders the path the user has run******//
-(MKCoordinateRegion) mapRegion{
    MKCoordinateRegion region;
    //    Location* initalLoc = self.locations.firstObject;
    //NSLog(@"%@", self.locations.firstObject);
    CLLocation* temp = self.locations.firstObject;
    CLLocationCoordinate2D tempCoordinate = temp.coordinate;
    //NSLog(@"%f", tempCoordinate.latitude);
    
    float minLat = tempCoordinate.latitude;
    float minLng = tempCoordinate.longitude;
    float maxLat = tempCoordinate.latitude;
    float maxLng = tempCoordinate.longitude;
    
    for(temp in self.locations){
        tempCoordinate = temp.coordinate;
        if(tempCoordinate.latitude < minLat){
            minLat = tempCoordinate.latitude;
        }
        if(tempCoordinate.longitude < minLng){
            minLng = tempCoordinate.longitude;
        }
        if(tempCoordinate.latitude > maxLat){
            maxLat = tempCoordinate.latitude;
        }
        if(tempCoordinate.longitude > maxLng){
            maxLng = tempCoordinate.longitude;
        }
    }
    
    region.center.latitude = (minLat + maxLat) / 2.0f;
    region.center.longitude = (minLng + maxLng) / 2.0f;
    
    region.span.latitudeDelta = (maxLat - minLat) * 1.1f;
    region.span.longitudeDelta = (maxLng - minLng) * 1.1f;
    
    return region;
}

//******Defines color and width of the line renderer******//
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay
{
    if ([overlay isKindOfClass:[MulticolorPolylineSegment class]]) {
        MulticolorPolylineSegment *polyLine = (MulticolorPolylineSegment *)overlay;
        MKPolylineRenderer *aRenderer = [[MKPolylineRenderer alloc] initWithPolyline:polyLine];
        aRenderer.strokeColor = polyLine.color;
        aRenderer.lineWidth = 3;
        return aRenderer;
    }
    
    return nil;
}

//******Defines the coordinates for the line renderer******//
-(MKPolyline*) polyLine{
    CLLocationCoordinate2D coords[self.locations.count];
    CLLocation* location;
    CLLocationCoordinate2D tempCoordinate;
    for(int i = 0; i < self.locations.count; i++){
        location = [self.locations objectAtIndex:i];
        tempCoordinate = location.coordinate;
        coords[i] = CLLocationCoordinate2DMake(tempCoordinate.latitude, tempCoordinate.longitude);
    }
    return [MKPolyline polylineWithCoordinates:coords count:self.locations.count];
}

//******Combines the polyLine, mapView, and mapRegion functions******//
-(void) loadMap{
    if(self.locations.count > 1){
        self.map.hidden = NO;
        [self.map setRegion:[self mapRegion]];
        NSArray *colorSegmentArray = [self colorSegmentsForLocations:self.locations];
        [self.map addOverlays:colorSegmentArray];
    }
    else{
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"No locations to display." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        //Display error saying no locations were recorded
    }
}

//******Changes color of the map polylines******//
- (NSArray *)colorSegmentsForLocations:(NSArray *)locations
{
    // make array of all speeds, find slowest+fastest
    NSMutableArray *speeds = [NSMutableArray array];
    double slowestSpeed = DBL_MAX;
    double fastestSpeed = 0.0;
    
    for (int i = 1; i < locations.count; i++) {
//        Location *firstLoc = [locations objectAtIndex:(i-1)];
        CLLocation *firstTemp = [locations objectAtIndex:(i - 1)];
//        Location *secondLoc = [locations objectAtIndex:i];
        CLLocation *secondTemp = [locations objectAtIndex:i];
        
        CLLocationCoordinate2D firstTempCoordinate = firstTemp.coordinate;
        CLLocationCoordinate2D secondTempCoordinate = secondTemp.coordinate;
        
        CLLocation *firstLocCL = [[CLLocation alloc] initWithLatitude:firstTempCoordinate.latitude longitude:firstTempCoordinate.longitude];
        CLLocation *secondLocCL = [[CLLocation alloc] initWithLatitude:secondTempCoordinate.latitude longitude:secondTempCoordinate.longitude];
        
        double distance = [secondLocCL distanceFromLocation:firstLocCL];
        double time = [secondTemp.timestamp timeIntervalSinceDate:firstTemp.timestamp];
        double speed = distance/time;
        
        slowestSpeed = speed < slowestSpeed ? speed : slowestSpeed;
        fastestSpeed = speed > fastestSpeed ? speed : fastestSpeed;
        
        [speeds addObject:@(speed)];
    }
    
    // now knowing the slowest+fastest, we can get mean too
    double meanSpeed = (slowestSpeed + fastestSpeed)/2;
    
    // RGB for red (slowest)
    CGFloat r_red = 1.0f;
    CGFloat r_green = 20/255.0f;
    CGFloat r_blue = 44/255.0f;
    
    // RGB for yellow (middle)
    CGFloat y_red = 1.0f;
    CGFloat y_green = 215/255.0f;
    CGFloat y_blue = 0.0f;
    
    // RGB for green (fastest)
    CGFloat g_red = 0.0f;
    CGFloat g_green = 146/255.0f;
    CGFloat g_blue = 78/255.0f;
    
    NSMutableArray *colorSegments = [NSMutableArray array];
    
    for (int i = 1; i < locations.count; i++) {
//        Location *firstLoc = [locations objectAtIndex:(i-1)];
//        Location *secondLoc = [locations objectAtIndex:i];
        CLLocation *firstTemp = [locations objectAtIndex:(i - 1)];
        CLLocation *secondTemp = [locations objectAtIndex:i];
        
        CLLocationCoordinate2D firstTempCoord = firstTemp.coordinate;
        CLLocationCoordinate2D secondTempCoord = secondTemp.coordinate;
        
        CLLocationCoordinate2D coords[2];
        coords[0].latitude = firstTempCoord.latitude;
        coords[0].longitude = firstTempCoord.longitude;
        
        coords[1].latitude = secondTempCoord.latitude;
        coords[1].longitude = secondTempCoord.longitude;
        
        NSNumber *speed = [speeds objectAtIndex:(i-1)];
        UIColor *color = [UIColor blackColor];
        
        // between red and yellow
        if (speed.doubleValue < meanSpeed) {
            double ratio = (speed.doubleValue - slowestSpeed) / (meanSpeed - slowestSpeed);
            CGFloat red = r_red + ratio * (y_red - r_red);
            CGFloat green = r_green + ratio * (y_green - r_green);
            CGFloat blue = r_blue + ratio * (y_blue - r_blue);
            color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
            
            // between yellow and green
        } else {
            double ratio = (speed.doubleValue - meanSpeed) / (fastestSpeed - meanSpeed);
            CGFloat red = y_red + ratio * (g_red - y_red);
            CGFloat green = y_green + ratio * (g_green - y_green);
            CGFloat blue = y_blue + ratio * (g_blue - y_blue);
            color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
        }
        
        MulticolorPolylineSegment *segment = [MulticolorPolylineSegment polylineWithCoordinates:coords count:2];
        segment.color = color;
        
        [colorSegments addObject:segment];
    }
    
    return colorSegments;
}

@end
