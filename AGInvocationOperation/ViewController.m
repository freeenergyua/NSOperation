//
//  ViewController.m
//  AGInvocationOperation
//
//  Created by AG on 5/30/16.
//  Copyright © 2016 AG. All rights reserved.
//

#import "ViewController.h"
#import "AGDownloadOperation.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *secondButton;
@property (weak, nonatomic) IBOutlet UIButton *thirdButton;
@property (weak, nonatomic) IBOutlet UIButton *firstButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.queque = [[NSOperationQueue alloc]init];
    [self.secondButton setBackgroundImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
    
//    self.queque.maxConcurrentOperationCount = 1;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startInfinityAnimation:(UIButton *)sender
{
    __weak typeof(self.firstButton) weakSender = self.firstButton;

    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"Start animation in thread - %@",[NSThread currentThread]);
        [UIView animateWithDuration: 0.4f
                              delay: 0.0f
                            options: UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAutoreverse |UIViewAnimationOptionRepeat
                         animations: ^{
                             __strong typeof(weakSender) strongSender = weakSender;
                             strongSender.layer.transform = CATransform3DMakeScale(1.1, 1.1, 0.0);
                         } completion: ^(BOOL finished){
                             __strong typeof(weakSender) strongSender = weakSender;
                             [UIView setAnimationRepeatCount: 0];
                             strongSender.layer.transform = CATransform3DMakeScale(1.0, 1.0, 0.0);
                         }];
    });
}

- (void)stopInfinityAnimation:(UIButton*)sender
{
    
    __weak typeof(sender) weakSender = sender;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"Stop animation- %@",[NSThread currentThread]);
        
        sender.layer.transform = CATransform3DMakeScale(1.0, 1.0, 0.0);
        [UIView animateWithDuration: 0.4
                              delay: 0.0
                            options: UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState
                         animations: ^{
                             __strong typeof(weakSender) strongSender = weakSender;
                             strongSender.layer.transform = CATransform3DMakeScale(1.0, 1.0, 0.0);
                         } completion: ^(BOOL finished){
                             
                         }];

    });
}

-(void)pulseAnimation:(UIButton *)sender {
    CABasicAnimation *pulseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulseAnimation.duration = .15;
    pulseAnimation.toValue = [NSNumber numberWithFloat:1.1];
    pulseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulseAnimation.autoreverses = YES;
    pulseAnimation.repeatCount = 2;
    [sender.layer addAnimation:pulseAnimation forKey:nil];
}

- (void)downloadTask:(UIButton*)sender {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSLog(@"Start download from  downloadTask- %@",[NSThread currentThread]);
        
        float randomLenghth = arc4random()% 2 + 0.5;
        [NSThread sleepForTimeInterval:randomLenghth];
        NSLog(@"Finish download from  downloadTask - %@",[NSThread currentThread]);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [sender.layer removeAllAnimations]; //dont work too
            [self stopInfinityAnimation:sender];
        });
    });
}


- (IBAction)pressButton:(UIButton *)sender {
    
//    [self pulseAnimation:sender];
//
//    
//    __weak typeof(sender) weakSender = sender;
//    __weak typeof(self) weakSelf     = self;
//    
//    AGDownloadOperation* opDownload = [[AGDownloadOperation alloc]initWithTarget:self selector:@selector(downloadTask:) object:sender];
//    
//    NSInvocationOperation* opAnima = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(startInfinityAnimation) object:nil];
//
//    [self.queque addOperation:opAnima];
//    [self.queque addOperation:opDownload];
////    if ([opDownload respondsToSelector:@selector(setCompletionBlock:)])
////    {
////        
////    }
//    
//    [opDownload setCompletionBlock:^{//not responce to selector
//        
//        __strong typeof(weakSender) strongSender = weakSender;
//        __strong typeof(weakSelf) strongSelf = weakSelf;
//        NSLog(@"setCompletionBlock 1111");
//
////        [strongSelf stopInfinityAnimation:strongSender];//dont stop
//        [strongSelf.firstButton.layer removeAllAnimations];
//      
//    }];
}

- (IBAction)pressButtonSecond:(UIButton *)sender {
   
    CGAffineTransform scale = CGAffineTransformMakeScale(0.3 , 0.3);
    CGAffineTransform scaleRestore = CGAffineTransformMakeScale(1.4 , 1.4);
    CGAffineTransform scaleRestoreFinal = CGAffineTransformMakeScale(1.0 , 1.0);
    CGAffineTransform rotate = CGAffineTransformMakeRotation(M_PI);
    CGAffineTransform entireAnimation = CGAffineTransformConcat(scale, rotate);

    
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        sender.transform = entireAnimation;
        sender.alpha = 0.1;

    } completion:^(BOOL finished) {

        [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut
        animations:^{
            
            sender.alpha = 1.0f;
            [sender setBackgroundImage:[UIImage imageNamed:@"Pause.png"] forState:UIControlStateNormal];
            sender.transform = scaleRestore;

        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 
                                 sender.transform = scaleRestoreFinal;
                                 
                             } completion:^(BOOL finished) {
        
                                 return;
                             }];
            return;
        }];
    }];
}

- (IBAction)pressButtonThird:(UIButton *)sender {
    
    //some animation
}

@end
