//
//  CoreLocationController.m
//  Runner
//
//  Created by William Souraphath on 10/27/15.
//  Copyright © 2015 Group9. All rights reserved.
//

#import "CoreLocationController.h"

@implementation CoreLocationController

@synthesize speedManager, speedDelegate;

-(id) init{
    self = [super init];
    if(self != nil){
        self.speedManager = [[CLLocationManager alloc] init];
        self.speedManager.delegate = self;
        self.speedManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    }
    return self;
}

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    if([self.speedDelegate conformsToProtocol:@protocol(CoreLocationControllerDelegate)]) {
        CLLocation *loc = [locations lastObject];
//        NSLog(@"%@", loc);
        [self.speedDelegate locationUpdate:loc];
    }
}

-(void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    if([self.speedDelegate conformsToProtocol:@protocol(CoreLocationControllerDelegate)]){
        [self.speedDelegate locationError:error];
    }
}

@end
