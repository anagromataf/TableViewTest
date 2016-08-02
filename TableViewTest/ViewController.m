//
//  ViewController.m
//  TableViewTest
//
//  Created by Tobias Kraentzer on 02.08.16.
//  Copyright © 2016 Tobias Kräntzer. All rights reserved.
//

#import "HeaderView.h"
#import "ViewController.h"

@interface ViewController () <UITableViewDataSource>
@property (nonatomic, assign) NSUInteger numberOfsections;
@property (nonatomic, assign) NSUInteger numberOfItems;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.numberOfsections = 7;
    self.numberOfItems = 0;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 33;
    
    self.tableView.sectionHeaderHeight = 40;
//    self.tableView.estimatedSectionHeaderHeight = 33;
    
    [self.tableView registerClass:[HeaderView class] forHeaderFooterViewReuseIdentifier:@"HeaderView"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView beginUpdates];
        self.numberOfItems = 12;
        NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
        for (NSUInteger i = 0; i < self.numberOfItems; i++) {
            [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:self.numberOfsections - 1]];
        }
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView endUpdates];
    });
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.numberOfsections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == self.numberOfsections - 1) {
        return self.numberOfItems;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld/%ld", (long)indexPath.section, indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HeaderView *view = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HeaderView"];
    view.textLabel.text = [NSString stringWithFormat:@"%ld", section];
    return view;
}

@end
