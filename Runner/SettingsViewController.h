//
//  SettingsViewController.h
//  Runner
//
//  Created by abc on 11/28/15.
//  Copyright © 2015 Group9. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *settingsOptions;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuButton;

@property (weak, nonatomic) IBOutlet UITextField *changeWeight;
@property (weak, nonatomic) IBOutlet UISegmentedControl *changeGender;

@property (weak, nonatomic) IBOutlet UITextField *changeHeight;

@property (weak, nonatomic) IBOutlet UISegmentedControl *changeUnit;



@end
