//
//  Trail.m
//  Runner
//
//  Created by Stuart Millner on 11/28/15.
//  Copyright © 2015 Group9. All rights reserved.
//

#import "Trail.h"

@implementation Trail


-(id) init
{
    self.locations = [[NSMutableArray alloc] init];
    return self;
}

-(id) initWithName:(NSString*) name andDistance:(double) distance andLocations:(NSMutableArray*) locations
{
    self.trailName = name;
    self.distance = distance;
    self.locations = locations;
    
    return self;
}

-(BOOL) doesRunMatchThisTrail:(Run*) runToCheck
{

    
    NSArray* sortedTrailLocations = [self.locations sortedArrayUsingComparator:^NSComparisonResult(id a, id b)
                                {
                                    double firstLatitude = [(CLLocation*) a coordinate].latitude;
                                    double firstLongitude =[(CLLocation*) a coordinate].longitude;
                                    double secondLatutde = [(CLLocation*) b coordinate].latitude;
                                    double secondLongitude = [(CLLocation*) b coordinate].longitude;
                                    
                                    if (firstLatitude > secondLatutde || (firstLatitude == secondLatutde && firstLongitude > secondLongitude))
                                    {
                                        return NSOrderedDescending;
                                    }
                                    else
                                    {
                                        return NSOrderedAscending;
                                    }
                                }];
 
    for (CLLocation* runLocation in runToCheck.locations)
    {
        NSRange searchRange = NSMakeRange(0, sortedTrailLocations.count);
        NSUInteger findIndex = [sortedTrailLocations indexOfObject:runLocation inSortedRange:searchRange options:NSBinarySearchingFirstEqual usingComparator:^(id object1, id object2)
        {
            CLLocation* firstLocation = (CLLocation*) object1;
            CLLocation* secondLocation = (CLLocation*) object2;
            if ([firstLocation distanceFromLocation:secondLocation] < 1)
            {
                return NSOrderedSame;
            }else
            {
                if ([firstLocation coordinate].latitude > [secondLocation coordinate].latitude || ([firstLocation coordinate].latitude == [secondLocation coordinate].latitude && [firstLocation coordinate].longitude > [secondLocation coordinate].longitude))
                {
                    return NSOrderedDescending;
                }
                else
                {
                    return NSOrderedAscending;
                }

            }
        }];
        
        if (findIndex >= sortedTrailLocations.count)
        {
            return false;
        }
    }
            return true;
    }



@end
