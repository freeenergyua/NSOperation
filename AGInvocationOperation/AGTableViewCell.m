//
//  AGTableViewCell.m
//  AGInvocationOperation
//
//  Created by AG on 6/2/16.
//  Copyright © 2016 AG. All rights reserved.
//

#import "AGTableViewCell.h"

@implementation AGTableViewCell

//- (void)startAnimationCell {
//    NSLog(@"sender tag - %ld ",(long)self.cellButton.tag);
//    
//    __weak typeof(self.cellButton) weakSender = self.cellButton;
//    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        NSLog(@"Start animation in thread - %@",[NSThread currentThread]);
//        [UIView animateWithDuration: 0.4f
//                              delay: 0.0f
//                            options: UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAutoreverse |UIViewAnimationOptionRepeat
//                         animations: ^{
//                             __strong typeof(weakSender) strongSender = weakSender;
//                             strongSender.layer.transform = CATransform3DMakeScale(1.1, 1.1, 0.0);
//                         } completion: ^(BOOL finished){
//                             __strong typeof(weakSender) strongSender = weakSender;
//                             [UIView setAnimationRepeatCount: 0];
//                             strongSender.layer.transform = CATransform3DMakeScale(1.0, 1.0, 0.0);
//                         }];
//    });
//}
//
//- (void)stopAnimationCell {
//    
//    __weak typeof(self.cellButton) weakSender = self.cellButton;
//    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        NSLog(@"Stop animation- %@",[NSThread currentThread]);
//        
//        self.cellButton.layer.transform = CATransform3DMakeScale(1.0, 1.0, 0.0);
//        [UIView animateWithDuration: 0.4
//                              delay: 0.0
//                            options: UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState
//                         animations: ^{
//                             __strong typeof(weakSender) strongSender = weakSender;
//                             strongSender.layer.transform = CATransform3DMakeScale(1.0, 1.0, 0.0);
//                         } completion: ^(BOOL finished){
//                             
//                         }];
//        
//    });
//}


@end
