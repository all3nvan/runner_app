//
//  SettingsViewController.m
//  Runner
//
//  Created by abc on 11/28/15.
//  Copyright © 2015 Group9. All rights reserved.
//

#import "SettingsViewController.h"
#import "SWRevealViewController.h"
#import "ViewController.h"
#import "LoginViewController.h"
#import "ProfileTableViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController {
    NSArray *allSettings;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.settingsOptions.delegate = self;
    self.settingsOptions.dataSource = self;
    allSettings = @[@"weight", @"gender", @"height", @"unit", @"version"];
    // Do any additional setup after loading the view.
    SWRevealViewController *revealViewController = self.revealViewController;
    
    [self.menuButton setTarget: revealViewController];
    [self.menuButton setAction: @selector( revealToggle:)];
    [self.view addGestureRecognizer:revealViewController.panGestureRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(IBAction) genderSegmentedControlIndexChanged{
    switch (self.changeGender.selectedSegmentIndex) {
        case 0:
            [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"gender"];
            break;
        case 1:
            [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"gender"];
            break;
        case 2:
            [[NSUserDefaults standardUserDefaults] setInteger:2 forKey:@"gender"];
            break;
        default:
            break;
    }
    
}

-(IBAction) unitSegmentedControlIndexChanged{
    switch (self.changeGender.selectedSegmentIndex) {
        case 0:
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isMetric"];
            break;
        case 1:
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isMetric"];
            break;
        default:
            break;
    }
    
}



-(BOOL)getUnit {
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"isMetric"] != nil) {
        return [[NSUserDefaults standardUserDefaults] boolForKey:@"isMetric"];
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isMetric"];
        return true;
    }
}

-(int)getGender {
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"gender"] != nil) {
        return [[NSUserDefaults standardUserDefaults] integerForKey:@"gender"];
    } else {
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"gender"];
        return 1;
    }
}

-(NSString*)getHeight {
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"height"] != nil) {
        return [[NSUserDefaults standardUserDefaults] stringForKey:@"height"];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:@"5' 2''" forKey:@"height"];
        return @"5' 2''";
    }
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return allSettings.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellIdentifier = [allSettings objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    _changeWeight = (UITextField*)[cell viewWithTag:196];
    
    if ([CellIdentifier isEqualToString:@"weight"] ) {
        _changeWeight = (UITextField*)[cell viewWithTag:196];
        _changeWeight.text = [[[PFUser currentUser] objectForKey:@"userWeight"] description ];
    }
    
    if ([CellIdentifier isEqualToString:@"gender"] ) {
        _changeGender = (UISegmentedControl*)[cell viewWithTag: 197];
        _changeGender.selectedSegmentIndex = [self getGender];
    }
    if ([CellIdentifier isEqualToString:@"height"] ) {
        _changeHeight = (UITextField*)[cell viewWithTag:198];
        _changeHeight.text = [self getHeight];
    }
    if ([CellIdentifier isEqualToString:@"unit"] ) {
        _changeUnit = (UISegmentedControl*)[cell viewWithTag: 199];
        _changeUnit.selectedSegmentIndex = [self getUnit];
    }
    
    
    
    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
