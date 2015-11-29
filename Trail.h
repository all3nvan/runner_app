//
//  Trail.h
//  Runner
//
//  Created by Stuart Millner on 11/28/15.
//  Copyright © 2015 Group9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "Run.h"
@interface Trail : NSObject

@property  NSString* trailName;
@property double distance;
@property CLLocationCoordinate2D location;
@property NSMutableArray* locations;

-(BOOL) doesRunMatchThisTrail:(Run*) runToCheck;

@end
