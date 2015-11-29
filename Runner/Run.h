//
//  Run.h
//  Runner
//
//  Created by Yassir Jamal on 10/28/15.
//  Copyright © 2015 Group9. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Run : NSObject

@property float distance;
@property int duration;
@property NSDate* timestamp;
@property NSMutableArray* locations;
@property float calories;

@end
