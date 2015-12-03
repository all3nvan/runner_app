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
#import "ProfileViewController.h"

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

-(IBAction) changeWeight:(id) sender{
    
}

-(IBAction) changeGender:(id) sender{
    
}

-(IBAction) changeHeight:(id) sender{
    
}

-(IBAction) changeUnit:(id) sender{
    
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
    

    _changeGender = (UISegmentedControl*)[cell viewWithTag: 197];
    
    _changeHeight = (UITextField*)[cell viewWithTag:198];
    
    _changeUnit = (UISegmentedControl*)[cell viewWithTag: 199];
    
    
    
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
