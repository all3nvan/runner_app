//
//  TrailTests.m
//  Runner
//
//  Created by Stuart Millner on 11/28/15.
//  Copyright © 2015 Group9. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Trail.h"
@interface TrailTests : XCTestCase

@end

@implementation TrailTests
{
    Trail* trailTester;
}
- (void)setUp {
    [super setUp];
    trailTester = [[Trail alloc]init];
    [trailTester.locations addObject:[[CLLocation alloc] initWithLatitude:-56.6462520 longitude:-36.6462520]];
    [trailTester.locations addObject:[[CLLocation alloc] initWithLatitude:-56.6462520 longitude:-31.6462520]];
    [trailTester.locations addObject:[[CLLocation alloc] initWithLatitude:-59.6462520 longitude:-37.6462520]];
    [trailTester.locations addObject:[[CLLocation alloc] initWithLatitude:-60.6462520 longitude:-38.6462520]];
    [trailTester.locations addObject:[[CLLocation alloc] initWithLatitude:-60.6462520 longitude:-39.6462520]];
    [trailTester.locations addObject:[[CLLocation alloc] initWithLatitude:-70.6462520 longitude:-30.6462520]];
    [trailTester.locations addObject:[[CLLocation alloc] initWithLatitude:-70.6462520 longitude:-50.6462520]];
    [trailTester.locations addObject:[[CLLocation alloc] initWithLatitude:-70.6462520 longitude:-40.6462520]];
    
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

-(void) testdoesRunMatchThisTrail_RunMatchesTrail_ReturnTrue
{
    Run* newrun = [[Run alloc] init];
    newrun.locations = [[NSMutableArray alloc] init];
    [newrun.locations addObject:[[CLLocation alloc] initWithLatitude:-56.6462520 longitude:-36.6462520]];
    [newrun.locations addObject:[[CLLocation alloc] initWithLatitude:-56.6462520 longitude:-31.6462520]];
    [newrun.locations addObject:[[CLLocation alloc] initWithLatitude:-59.6462520 longitude:-37.6462520]];
    [newrun.locations addObject:[[CLLocation alloc] initWithLatitude:-60.6462520 longitude:-38.6462520]];
    [newrun.locations addObject:[[CLLocation alloc] initWithLatitude:-60.6462520 longitude:-39.6462520]];
    [newrun.locations addObject:[[CLLocation alloc] initWithLatitude:-70.6462520 longitude:-30.6462520]];
    [newrun.locations addObject:[[CLLocation alloc] initWithLatitude:-70.6462520 longitude:-50.6462520]];
    [newrun.locations addObject:[[CLLocation alloc] initWithLatitude:-70.6462520 longitude:-40.6462520]];
    XCTAssertTrue([trailTester doesRunMatchThisTrail: newrun]);
}

-(void) testdoesRunMatchThisTrail_RundoesnotMatchTrail_ReturnFalse
{
    Run* newrun = [[Run alloc] init];
    newrun.locations = [[NSMutableArray alloc] init];
    [newrun.locations addObject:[[CLLocation alloc] initWithLatitude:-56.6462520 longitude:-36.6462520]];
    [newrun.locations addObject:[[CLLocation alloc] initWithLatitude:-56.6462520 longitude:-31.6462520]];
    [newrun.locations addObject:[[CLLocation alloc] initWithLatitude:-59.6462520 longitude:-37.6462520]];
    [newrun.locations addObject:[[CLLocation alloc] initWithLatitude:-60.6462520 longitude:-38.6462520]];
    [newrun.locations addObject:[[CLLocation alloc] initWithLatitude:-60.6462520 longitude:-39.6462520]];
    [newrun.locations addObject:[[CLLocation alloc] initWithLatitude:-70.6462520 longitude:-30.6462520]];
    [newrun.locations addObject:[[CLLocation alloc] initWithLatitude:-70.6462520 longitude:-50.6462520]];
    [newrun.locations addObject:[[CLLocation alloc] initWithLatitude:-70.6462520 longitude:-40.6462520]];
    [newrun.locations addObject:[[CLLocation alloc] initWithLatitude:-20.6462520 longitude:-20.6462520]];
    XCTAssertFalse([trailTester doesRunMatchThisTrail: newrun]);

}

@end
