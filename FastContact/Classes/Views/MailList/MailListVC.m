//
//  MailListVC.m
//  FastContact
//
//  Created by YTYanK on 17/1/16.
//  Copyright © 2017年 YTYanK. All rights reserved.
//

#import "MailListVC.h"
#import "AddressBookModel.h"


@interface MailListVC ()<UISearchResultsUpdating,UISearchBarDelegate,UISearchResultsUpdating>
{
    NSMutableArray <AddressBookModel *> *addressDatas;
    UISearchController *_mailSearchController;
}
// 全部名字
@property (strong, nonatomic) NSDictionary *allNames;
// 名字组 - 存在值的Names
@property (strong, nonatomic) NSMutableDictionary *names;
// allKeys
@property (strong, nonatomic) NSMutableArray *allKeys;
// key 组 - 存在值的key
@property (strong, nonatomic) NSMutableArray *keys;
// 存放搜索到的Key
@property (strong, nonatomic) NSMutableArray *searchKeys;
// 存放搜索到的Name
@property (strong, nonatomic) NSMutableDictionary *searchNames;

@end

static NSString *const reuseIdentifier = @"MailCell";

@implementation MailListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self operationMailListWithData:self.modelData];
    [self initMailSearchController];
        
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_mailSearchController.active) {
        return [_searchKeys count];
    }else {
        return [_keys count];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([_keys count] == 0)
        return 0;
    
    NSString *key;
    NSArray *nameSection;
    if (_mailSearchController.active) {
        key = [_searchKeys objectAtIndex:section];
        nameSection = [_searchNames objectForKey:key];
        return [nameSection count];
    }else {
        key = [_keys objectAtIndex:section];
        nameSection = [_names objectForKey:key];
        return [nameSection count];
    }
    
}

#pragma mark - Table D
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger section = [indexPath section];
    NSString *key;
    NSArray *nameSection;
    
    if (_mailSearchController.active) {
        key = [_searchKeys objectAtIndex:section];
        nameSection = [_searchNames objectForKey:key];
    }else {
        key = [_keys objectAtIndex:section];
        nameSection = [_names objectForKey:key];
        
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    }

    cell.textLabel.text = [nameSection objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark TableViewDelegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   // [_mailSearchController.searchBar resignFirstResponder];
    
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //    [search resignFirstResponder];
    //    search.text = @"";
    //    isSearching = NO;
    //    [tableView reloadData];
    return indexPath;
}
// 头部组
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    if (_mailSearchController.active) {
        header.textLabel.text = [_searchKeys objectAtIndex:section];
    }

}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    NSString* key;
    if (_mailSearchController.active) {
        key = [_searchKeys objectAtIndex:index];
    }else {
        key = [_keys objectAtIndex:index];
    }
    
    
    if (key == UITableViewIndexSearch) {
        [tableView setContentOffset:CGPointZero animated:NO];
        return NSNotFound;
    }
    else
        return index;
}

#pragma mark 右侧标题栏
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([self.keys count] == 0)
        return 0;
    
    NSString *key = [self.keys objectAtIndex:section];
    if (key == UITableViewIndexSearch)
        return  nil;
    
    return key;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (_isSearching)
        return nil;
    return _keys;
}




#pragma mark - 自定义
- (void)operationMailListWithData:(id)model {
    
    NSString *completePath = [[NSBundle mainBundle] pathForResource:@"MailList" ofType:@"plist"];
    
    //存放数组的字典
    NSMutableDictionary *dictplist = [NSMutableDictionary dictionaryWithContentsOfFile:completePath];
    NSMutableArray *keyArray = [[NSMutableArray alloc] init];
    
    //添加 key 到 key 数组
    [keyArray addObjectsFromArray:[[dictplist allKeys] sortedArrayUsingSelector:@selector(compare:)]];
    _allKeys = keyArray;
    _allNames  = [self readMailList:dictplist addModel:model];
    
    _names = [self splitDictionary:_allNames];
}
// 读取保存的通讯录,并把数据添加进去
- (NSMutableDictionary*)readMailList:(NSDictionary *)list addModel:(id)model  {
    NSMutableDictionary *dic = nil;
    addressDatas = model;
    NSString *completePath = [[NSBundle mainBundle] pathForResource:@"MailList" ofType:@"plist"];

    for (int i = 0; i< addressDatas.count; i++) {
        __weak NSString *nameStr = [addressDatas[i] name];
        NSString *pinyi = [MailListVC transform:nameStr];
        NSString *headLetter = [[pinyi substringToIndex:1] uppercaseString];
        
        
        if ([self deptNumInputShouldNumber:headLetter]) {
             headLetter = @"#";
        }
        
        //TODO: 这里需要添加判断非英文字母的时候
        if ([list objectForKey:headLetter] == nil) {
            NSMutableArray *newAry = [[NSMutableArray alloc] initWithObjects:nameStr, nil];
            [newAry addObject:nameStr];
            [list setValue:newAry forKey:headLetter];
          // 这个可以防止崩溃，但是。。会产生沉淀并且浪费内存
        }else {
            NSMutableArray *Ary = [list objectForKey:headLetter];
            [Ary addObject:nameStr];
            [list setValue:Ary forKey:headLetter];
            
        }
        dic = [list mutableCopy];
        
    }
    [dic writeToFile:completePath atomically:YES];
    return dic;
    
}

// 拆分通讯录
- (NSMutableDictionary *)splitDictionary:(NSDictionary *)list {
    _keys = [NSMutableArray array];
    NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
    for (NSString *key in _allKeys) {
        
        if ([[list objectForKey:key] count] > 0) {
            [_keys addObject:key];
            [mutDic setObject:[list objectForKey:key] forKey:key];
            
            
        }
    }
    return mutDic;
}

// 汉字转拼音
+ (NSString *)transform:(NSString *)chinese
{
    //kCFStringTransformMandarinLatin方法转化出来的是带音标的拼音
    //kCFStringTransformStripCombiningMarks  -- 无音标
    NSMutableString *pinyin = [chinese mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    NSLog(@"拼音--->%@", pinyin);
    return [pinyin uppercaseString];
}


- (void)initMailSearchController{
    _mailSearchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _mailSearchController.searchResultsUpdater = self;
    _mailSearchController.dimsBackgroundDuringPresentation = NO;
    _mailSearchController.hidesNavigationBarDuringPresentation = NO;
    _mailSearchController.searchBar.frame = CGRectMake(_mailSearchController.searchBar.frame.origin.x, _mailSearchController.searchBar.frame.origin.y, _mailSearchController.searchBar.frame.size.width, 44.0);
    _mailSearchController.searchBar.delegate = self;
    [self.headView addSubview: _mailSearchController.searchBar];
}



#pragma mark -  UISearchBarDelegate
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    // 输入的内容
    NSString *searchString = [_mailSearchController.searchBar text];
    // 用来判断是否中文
    BOOL chinese;
    NSString *pinyi;
    
    if ([searchString isEqualToString:@""] || searchString == nil) {
        [NSUD setValue:@"" forKey:@"saveHeadLetter"];
        [NSUD removeObjectForKey:@"saveHeadLetter"];
        _searchKeys = _keys;
        _searchNames = _names;
        [self.mailTableView reloadData];
        return;
    }
    
    
    if (searchString.length < 2) {
        NSString *headLetter = @"";
        if ([self deptNumInputShouldNumber:searchString]) {
             headLetter = @"#";
        }else {
            // 转拼音
            chinese = [self isChinese:searchString];
            if (chinese) {
                pinyi = [MailListVC transform:searchString];
            }else {
                pinyi = searchString;
            }
            
            headLetter = [[pinyi substringWithRange:NSMakeRange(0, 1)] uppercaseString];
        }
         [NSUD setValue:headLetter forKey:@"saveHeadLetter"];
    }
    
   
    
  
    //TODO: 模糊搜索，后期修改 -- 需要添加线程优化
    /*
     dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
     dispatch_async(globalQueue, ^{
             dispatch_async(dispatch_get_main_queue(), ^{
              //回到主线程
             });
     });
     
     */
    
    
    NSPredicate *keysPreicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", [NSUD objectForKey:@"saveHeadLetter"]];
    
    //过滤数据
    _searchKeys =  [NSMutableArray arrayWithArray:[_keys filteredArrayUsingPredicate:keysPreicate]];
    _searchNames = [NSMutableDictionary dictionary];
   
    if (_searchKeys.count > 0) {
        NSString *head = _searchKeys[0];
        NSMutableArray *searchAry = [NSMutableArray arrayWithArray:[_names objectForKey:head]];
        NSMutableArray *pinyinAry = [NSMutableArray array];
        
        for (NSString *vlueStr in searchAry) {
            pinyi = [MailListVC transform:vlueStr];
            if ([pinyi rangeOfString:searchString options:NSCaseInsensitiveSearch].length > 0) {
                [pinyinAry addObject:vlueStr];
            }
            
        }
        [_searchNames setValue:pinyinAry forKey:head];

    }
    
    
    //刷新表格
    [self.mailTableView reloadData];
}


//  判断是否中文
- (BOOL)isChinese:(NSString *)str {
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:str];
}
// 判断是否数字
- (BOOL)deptNumInputShouldNumber:(NSString *)str {
    
    NSString *regex =@"(^[0-9]*$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:str];
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
