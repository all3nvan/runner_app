//
//  CalorieCalculator.m
//  Runner
//
//  Created by Stuart Millner on 11/12/15.
//  Copyright © 2015 Group9. All rights reserved.
//

#import "CalorieCalculator.h"

@implementation CalorieCalculator

/// weight in lbs or kg, distance in  miles or kilometers, speed in mph or meters/second
-(id) initWithRunDetailsOfWeight: (float)weight andDistance:(float)distance andAverageSpeed:(float)avgspeed isImperial:(BOOL) isImperial
{
    float weightToImperial = weight;
    float speedToImperial = avgspeed;
    float distanceToImperial = distance;
    if (isImperial == false)
    {
        weightToImperial = weightToImperial * 2.20462;
        speedToImperial = avgspeed * 2.23694;
        distanceToImperial = distance * 0.621371;
    }
    if (speedToImperial > 4)
        self.caloriesBurned = round((weightToImperial) * (.63) * distanceToImperial * 100) / 100;
    else
        self.caloriesBurned = round((weightToImperial) * (.30) * distanceToImperial * 100) / 100;
    return self;
}

-(id) initWithCaloriesBurned:(double)caloriesBurned
{
    self.caloriesBurned = caloriesBurned;
    return self;
}



-(NSString*) comparisonForCaloriesBurned
{
    NSString* comparison = @"You burned the Equivalent of ";
    NSDictionary* foodComparisonStrings = [CalorieCalculator foodComparisons];
    double caloriesleft = self.caloriesBurned;
   
    NSArray *sortedKeys = [[foodComparisonStrings allKeys] sortedArrayUsingSelector: @selector(compare:)];
    NSMutableArray *sortedValues = [NSMutableArray array];
    for (NSString *key in sortedKeys)
        [sortedValues addObject: [foodComparisonStrings objectForKey: key]];
    
    for (id key in [sortedKeys reverseObjectEnumerator])
    {
        int comparisonNumber = 0;
        while (caloriesleft >= [key integerValue])
        {
            comparisonNumber ++;
            caloriesleft = caloriesleft - [key integerValue];
            
        }
        if (comparisonNumber > 0)
        {
            NSString* stringcomparison = [[foodComparisonStrings objectForKey:key]objectAtIndex:0];
            comparison = [comparison stringByAppendingString:[NSString stringWithFormat:@"(%D) ", comparisonNumber]];
            comparison = [comparison stringByAppendingString:stringcomparison];
            comparison = [comparison stringByAppendingString:@", "];
        }
        
    }
    comparison = [comparison substringToIndex:(comparison.length - 2)];
    return comparison;
}

+(NSDictionary*) foodComparisons;
{
    NSDictionary* comparisonList = @{@500: @[@"Plain Bagel w/ Cream Cheese"],
                                     @400: @[@"1/2 of an Applebee's Grilled Chicken Caesar Salad"],
                                     @300: @[@"6 inch Subway Club"],
                                     @200: @[@"Spicy Tostada"],
                                     @100: @[@"8oz Can of Dr. Pepper"],
                                     @50: @[@"Chicken McNugget"]};
                                
    return comparisonList;
}

@end
