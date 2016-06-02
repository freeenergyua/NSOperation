//
//  AGAnimationOperation.h
//  AGInvocationOperation
//
//  Created by AG on 6/1/16.
//  Copyright © 2016 AG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AGAnimationOperation : NSOperation {
    BOOL        executing;
    BOOL        finished;
    BOOL        canceled;
}

@property (strong,atomic)UIButton* buttonForAnimation;

-(id)initWithButton:(UIButton*)button;



@end
