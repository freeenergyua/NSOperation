//
//  AGAnimationOperation.m
//  AGInvocationOperation
//
//  Created by AG on 6/1/16.
//  Copyright © 2016 AG. All rights reserved.
//

#import "AGAnimationOperation.h"
#import "AGTableViewCell.h"


@implementation AGAnimationOperation

-(id)initWithButton:(UIButton*)button {
    if (self = [super init])
         _buttonForAnimation = button;
    return self;
}

- (void) start;

{
    NSLog(@"Start Animation function started");
    if ([self isCancelled])
    {
        
        NSLog(@"isCancelled");
        // Move the operation to the finished state if it is canceled.
        [self willChangeValueForKey:@"isFinished"];
        finished = YES;
        [self didChangeValueForKey:@"isFinished"];
        return;
    }
    
    // If the operation is not canceled, begin executing the task.
    [self willChangeValueForKey:@"isExecuting"];
    [NSThread detachNewThreadSelector:@selector(main) toTarget:self withObject:nil];
    executing = YES;
    [self didChangeValueForKey:@"isExecuting"];
    
}

- (void) main;
{
    
    NSLog(@"Main Animation function started");
    if ([self isCancelled]) {
        return;
    }
    
    __weak typeof(self.buttonForAnimation) weakButton = self.buttonForAnimation;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
//        NSLog(@"Start animation in thread - %@",[NSThread currentThread]);
        [UIView animateWithDuration: 0.4f
                              delay: 0.0f
                            options: UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAutoreverse |UIViewAnimationOptionRepeat
                         animations: ^{
                             __strong typeof(weakButton) strongButton = weakButton;
                             strongButton.layer.transform = CATransform3DMakeScale(1.1, 1.1, 0.0);
                         } completion: ^(BOOL finished){
                             __strong typeof(weakButton) strongButton = weakButton;
                             [UIView setAnimationRepeatCount: 0];
                             strongButton.layer.transform = CATransform3DMakeScale(1.0, 1.0, 0.0);
                         }];
    });
//    [self completeOperation];
}

- (BOOL) isAsynchronous;
{
    return NO;
}
- (BOOL)isCancelled
{
    return canceled;
}
- (BOOL)isExecuting {
    return executing;
}

- (BOOL)isFinished {
    return finished;
}
- (void)cancel {
    [self willChangeValueForKey:@"isCanceled"];
    canceled = YES;
    [self didChangeValueForKey:@"isCanceled"];
    [self completeOperation];
}


- (void)completeOperation {
    
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    [self willChangeValueForKey:@"isCanceled"];
    
    executing = NO;
    finished = YES;
    canceled = NO;
 
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
    [self didChangeValueForKey:@"isCanceled"];
    
   
    
    __weak typeof(self.buttonForAnimation) weakButton = self.buttonForAnimation;
        
    dispatch_async(dispatch_get_main_queue(), ^{

        self.buttonForAnimation.layer.transform = CATransform3DMakeScale(1.0, 1.0, 0.0);
        [UIView animateWithDuration: 0.4
                              delay: 0.0
                            options: UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState
                         animations: ^{
                             __strong typeof(weakButton) strongButton = weakButton;
                             
                             strongButton.layer.transform = CATransform3DMakeScale(1.0, 1.0, 0.0);
                         } completion: ^(BOOL finished){
                             NSLog(@"Animation Finished");
                         }];
    });
    
    NSLog(@"completeOperation for animation");
}

@end
