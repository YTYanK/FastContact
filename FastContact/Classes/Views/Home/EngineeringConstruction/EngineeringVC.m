//
//  EngineeringVC.m
//  FastContact
//
//  Created by YTYanK on 17/1/11.
//  Copyright © 2017年 YTYanK. All rights reserved.
//

#import "EngineeringVC.h"

@interface EngineeringVC ()

@end

@implementation EngineeringVC

static NSString *cellIdentifier = @"engineeringCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self updateUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     self.title = @"工程建设";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom
- (void)updateUI {
    [self initTableViewMJRefresh];
}

- (void)initTableViewMJRefresh {
    //self.engineeringTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.engineeringTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
    }];
    self.engineeringTableView.header.automaticallyChangeAlpha = YES;
    [self.engineeringTableView.header beginRefreshing];
    
    self.engineeringTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
    }];

}


#pragma mark - TableDelegate
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
   // UITableViewCell* cellheight = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return 44.f;
}

//- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section {
//    return 20.f;
//}
//
//- (UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section {
//    return nil;
//}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath*)indexPath {
    [self performSegueWithIdentifier:@"goToEngineeringDetailed" sender:self];
}

// 计算偏移量
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    if (scrollView.contentOffset.y < - 54) {
//    }
}

#pragma mark -  TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [NSString stringWithFormat:@"工程测试%ld",(long)indexPath.row];
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
