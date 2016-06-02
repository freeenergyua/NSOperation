//
//  myOperation.m
//  AGInvocationOperation
//
//  Created by AG on 5/30/16.
//  Copyright © 2016 AG. All rights reserved.
//

#import "AGDownloadOperation.h"

@implementation AGDownloadOperation

- (void) start
{
     NSLog(@"Start Downloading function started");
    if ([self isCancelled])
    {
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

- (void) main
{
    
     NSLog(@"Main download function started");
    if ([self isCancelled]) {
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSLog(@"Start download - %@",[NSThread currentThread]);
        
        float randomLenghth = arc4random()% 5 + 5;
        [NSThread sleepForTimeInterval:randomLenghth];
        NSLog(@"Finish download- %@",[NSThread currentThread]);
       
        [self completeOperation];
    });
//    [self completeOperation];
}
- (void)cancel {
    if (self.isCancelled) {
        [self completeOperation];
    }
}

- (BOOL) isAsynchronous
{
    return NO;
}

- (BOOL)isExecuting
{
    return executing;
}

- (BOOL)isFinished
{
    return finished;
}
- (BOOL)isCancelled
{
    return canceled;
}

- (void)completeOperation
{
    
    NSLog(@"completeOperation Downloading");
    
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    
    executing = NO;
    finished = YES;
    
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}

@end
