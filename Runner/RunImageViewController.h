//
//  RunImageViewController.h
//  Runner
//
//  Created by Allen Van on 12/2/15.
//  Copyright © 2015 Group9. All rights reserved.
//

#import "ViewController.h"

@interface RunImageViewController : ViewController

@property UIImage *runImage;
@property (strong, nonatomic) IBOutlet UIImageView *runImageView;
@property NSString *runId;

@end
