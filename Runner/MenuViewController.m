//
//  MenuViewController.m
//  Runner
//
//  Created by William Souraphath on 10/28/15.
//  Copyright © 2015 Group9. All rights reserved.
//

#import "MenuViewController.h"
#import "SWRevealViewController.h"


@interface MenuViewController ()

@end

@implementation MenuViewController{
    NSArray *menuItems;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.menuOptions.delegate = self;
    self.menuOptions.dataSource = self;
    menuItems = @[@"runner", @"history", @"settings", @"profile"];

    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Number of rows is the number of time zones in the region for the specified section.
    return menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
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
