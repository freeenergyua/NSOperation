//
//  ViewController.h
//  AGInvocationOperation
//
//  Created by AG on 5/30/16.
//  Copyright © 2016 AG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) NSOperationQueue* queque;


- (IBAction)pressButton:(UIButton *)sender;
- (IBAction)pressButtonSecond:(UIButton *)sender;
- (IBAction)pressButtonThird:(UIButton *)sender;

@end

