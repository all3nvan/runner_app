//
//  CalorieCounterTests.m
//  Runner
//
//  Created by Stuart Millner on 11/28/15.
//  Copyright © 2015 Group9. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CalorieCalculator.h"
@interface CalorieCounterTests : XCTestCase

@end

@implementation CalorieCounterTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

-(void) testInitWithCalories_ShouldEqualCalories
{
    CalorieCalculator* calculator = [[CalorieCalculator alloc] initWithCaloriesBurned:200];
    XCTAssertEqual(calculator.caloriesBurned, 200);
}

-(void) testInitWithRunDetailsImperial_ShouldCalculateInImperial
{
    CalorieCalculator* calculator = [[CalorieCalculator alloc] initWithRunDetailsOfWeight:1 andDistance:1 andAverageSpeed:1 isImperial:true];
    XCTAssertEqual(calculator.caloriesBurned, .3);
}

-(void)testInitWithRunDetailsMetric_ShouldCalculateInMetric
{
    CalorieCalculator* calculator = [[CalorieCalculator alloc] initWithRunDetailsOfWeight:0.453592 andDistance:1.60934 andAverageSpeed:0.44704 isImperial:false];
    XCTAssertEqual(calculator.caloriesBurned, .3);
}

-(void) testSpeedGreaterThan4MPHShouldUseRunningCalculations
{
    CalorieCalculator* calculator = [[CalorieCalculator alloc] initWithRunDetailsOfWeight:1 andDistance:1 andAverageSpeed:5 isImperial:true];
    XCTAssertEqual(calculator.caloriesBurned, .63);
}

-(void) testSpeedLessThan4MPHShouldUseWalkingCalculations
{
    CalorieCalculator* calculator = [[CalorieCalculator alloc] initWithRunDetailsOfWeight:1 andDistance:1 andAverageSpeed:3 isImperial:true];
    XCTAssertEqual(calculator.caloriesBurned, .3);
}

-(void) testCaloriesBurnedComparisonSingleComparison
{
    CalorieCalculator* calculator = [[CalorieCalculator alloc] initWithCaloriesBurned:500];
    
    XCTAssert([[calculator comparisonForCaloriesBurned] isEqualToString:@"You burned the Equivalent of (1) Plain Bagel w/ Cream Cheese"]);
}

-(void) testCaloriesBurnedComparisonTwoOfOneComparison
{
    CalorieCalculator* calculator = [[CalorieCalculator alloc] initWithCaloriesBurned:1000];
    
    XCTAssert([[calculator comparisonForCaloriesBurned] isEqualToString:@"You burned the Equivalent of (2) Plain Bagel w/ Cream Cheese"]);

}

-(void) testCaloriesBurnedComparisonTwoDifferentComparisons
{
    CalorieCalculator* calculator = [[CalorieCalculator alloc] initWithCaloriesBurned:550];
    
    XCTAssert([[calculator comparisonForCaloriesBurned] isEqualToString:@"You burned the Equivalent of (1) Plain Bagel w/ Cream Cheese, (1) Chicken McNugget"]);

}

@end
