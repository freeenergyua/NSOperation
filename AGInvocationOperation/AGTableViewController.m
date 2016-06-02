//
//  AGTableViewController.m
//  AGInvocationOperation
//
//  Created by AG on 6/2/16.
//  Copyright © 2016 AG. All rights reserved.
//

#import "AGTableViewController.h"
#import "AGTableViewCell.h"
#import "AGDownloadOperation.h"
#import "AGAnimationOperation.h"

@interface AGTableViewController ()

@property(assign, nonatomic)NSInteger downloadingIndex;

@property (strong, atomic) AGDownloadOperation* downloadOperation;
@property (strong, atomic) AGAnimationOperation* animationOperation;

@end


@implementation AGTableViewController

- (void)viewDidLoad {
    
    self.downloadOperation = [[AGDownloadOperation alloc]init];
    self.animationOperation =  [[AGAnimationOperation alloc]init];
    
    __weak typeof(self) weakSelf = self;
    
    [self.downloadOperation setCompletionBlock:^{
        NSLog(@"setCompletionBlock for downloading");
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.animationOperation cancel];
    }];
//
    

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AGTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    cell.textLabel.text = [NSString stringWithFormat:@"%lD",(long)indexPath.row];
    cell.cellButton.backgroundColor = [UIColor greenColor];
    [cell.cellButton addTarget:self action:@selector(startAnimation:) forControlEvents:UIControlEventTouchUpInside];
    cell.cellButton.tag = indexPath.row;
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}


- (void)startAnimation:(UIButton*)sender
{
    
    if([self.downloadOperation isExecuting] || [self.downloadOperation isFinished]){
        [self.downloadOperation cancel];
        [self.animationOperation cancel];
        [self.downloadOperation start];
        [self.animationOperation initWithButton:sender];
        self.downloadingIndex = sender.tag;
        [self.animationOperation start];
    } else {
        [self.downloadOperation start];
        self.downloadingIndex = sender.tag;
        [self.animationOperation initWithButton:sender];
        [self.animationOperation start];
    }
    [self.tableView reloadData];
}




@end
