//
//  myOperation.h
//  AGInvocationOperation
//
//  Created by AG on 5/30/16.
//  Copyright © 2016 AG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AGDownloadOperation : NSOperation {
    BOOL        executing;
    BOOL        finished;
    BOOL        canceled;
}

@end
