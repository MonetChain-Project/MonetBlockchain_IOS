//
//  FFAddFriendsVC.m
//  MonetBlockchain
//
//  Created by Megan on 2017/12/15.
//  Copyright © 2017年 MonetBlockchain Foundation All rights reserved.
//

#import "FFAddFriendsVC.h"
#import "FFSearchContactCell.h"
#import "FFOtherUserInfoVC.h"

@interface FFAddFriendsVC ()<UISearchResultsUpdating, UISearchBarDelegate>
{
    BOOL      _isSearch;
    UILabel * _emptyLabel;
}
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSMutableArray *searchArray;
@property(nonatomic,retain) NSString * searchString;

@end

@implementation FFAddFriendsVC

- (NSMutableArray *)searchArray {
    if (!_searchArray) {
        _searchArray = [NSMutableArray array];
    }
    return _searchArray;
}

- (UISearchController *)searchController {
    if (!_searchController) {
        // 初始化搜索控制器
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        // 保证UISearchController在激活状态下push后searchBar不会仍留在界面上
        self.definesPresentationContext = YES;
        // 搜索更新时调用的代理
        _searchController.searchResultsUpdater = self;
        // 搜索条代理
        _searchController.searchBar.delegate = self;
        // 搜索时是否隐藏背景 (没感觉区别在哪)
        _searchController.dimsBackgroundDuringPresentation = NO;
        // 搜索时是否隐藏导航
        _searchController.hidesNavigationBarDuringPresentation = YES;
        // 搜索时背景变模糊
        _searchController.obscuresBackgroundDuringPresentation = NO;
        // 占位文字 .placeholder
        [_searchController.searchBar ddy_LeftPlaceholder:DDYLocalStr(@"Search")];
        // 搜索栏背景图
        _searchController.searchBar.backgroundImage = [UIImage imageWithColor:DDY_White size:CGSizeMake(DDYSCREENW, 44)];
        // 设置搜索栏背景色
        _searchController.searchBar.barTintColor = DDY_White;
        // 设置搜索栏背景色
        _searchController.searchBar.backgroundColor = DDY_White;
        // 搜索输入栏背景色
        [_searchController.searchBar setSearchFieldBackgroundImage:[self getBgImg] forState:UIControlStateNormal];
        // 改变高度 不能直接设置frame
        _searchController.searchBar.transform = CGAffineTransformMakeScale(1, 1);
        // 隐藏上下分割线
        _searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
        // 设置frame
        _searchController.searchBar.frame = CGRectMake(0, 0.5, DDYSCREENW, 40);
        _searchController.searchBar.returnKeyType = UIReturnKeySearch;
    }
    return _searchController;
}

- (UIImage *)getBgImg {
    return [[UIImage imageWithColor:DDYRGBA(235, 235, 235, 1) size:DDYSize(DDYSCREENW-30, 28)] imageCornerRadius:8];
}

- (void)setupTableView {
    // 解决显示索引视图引起的搜索栏长度变短问题
    UIView *searchBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DDYSCREENW, 44)];
    [searchBarView addSubview:self.searchController.searchBar];
    // 添加搜索控制器
    self.tableView.tableHeaderView = searchBarView;
    // 隐藏空白cell
    self.tableView.tableFooterView = [UIView new];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    
    self.title = @"Add friend";
    
    _emptyLabel = [[UILabel alloc] initWithFrame:LC_RECT(10, 200, DDYSCREENW - 20, 25)];
    _emptyLabel.text = @"The user does not exits";
    _emptyLabel.textColor = LC_RGB(155, 155, 155);
    _emptyLabel.font = NA_FONT(15);
    _emptyLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_emptyLabel];
    _emptyLabel.hidden = YES;
}



//#pragma mark - DataSource
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    [self handleNoData];
//    return self.searchArray.count;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_isSearch == NO) {
        return 1;
    }
    return self.searchArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_isSearch == NO) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        if (self.searchString) {
            cell.imageView.image = [UIImage imageNamed:@"icon_search_friend.png"];
            cell.textLabel.text = [NSString stringWithFormat:@"搜索: %@",self.searchString];
        }
        return cell;
    }
    
    FFSearchContactCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchContactCell"];
    
    if (!cell) {
        cell = [[FFSearchContactCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SearchContactCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.user = self.searchArray[indexPath.row];
    return cell;
}



#pragma mark TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

#pragma mark 代理方法改变headerfooter颜色
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if ([view isMemberOfClass:[UITableViewHeaderFooterView class]])
    {
        UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
        header.textLabel.textColor = FF_MAIN_COLOR;
        header.contentView.backgroundColor = DDYRGBA(235, 235, 235, 1);
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_isSearch == NO) {
        
        if (self.searchString) {
            [self loadSearchData:self.searchString];
        }
    }
    else
    {
        FFUser * user = self.searchArray[indexPath.row];
        FFOtherUserInfoVC * controller = [[FFOtherUserInfoVC alloc] initWithUser:user];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    [self.tableView reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.searchString = searchText;
    _isSearch = NO;
    _emptyLabel.hidden = YES;
    [self.searchDisplayController.searchResultsTableView reloadData];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    // 改变取消字体
    _searchController.searchBar.showsCancelButton = YES;
    UIButton *cancelBtn = [_searchController.searchBar valueForKey:@"cancelButton"];
    [cancelBtn setTitleColor:FF_MAIN_COLOR forState:UIControlStateNormal];
    [cancelBtn setTitle:DDYLocalStr(@"Cancel") forState:UIControlStateNormal];
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.searchString = searchBar.text;
    [self loadSearchData:searchBar.text];
}

-(void)loadSearchData:(NSString *)searchString
{
    [FFLocalUserInfo LCInstance].isUser = YES;
    [FFLocalUserInfo LCInstance].isSignUp = YES;
    
    NSDictionary * params = @{
                              @"keyword":searchString
                              };
    [NANetWorkRequest na_postDataWithService:@"discover" action:@"search" parameters:params results:^(BOOL status, NSDictionary *result) {
        
        if (status)
        {
            NSArray * data = [result objectForKey:@"data"];
            NSMutableArray * temp = [NSMutableArray array];
            for (NSDictionary * dict in data) {
                FFUser * user = [FFUser userWithDict:dict];
                [temp addObject:user];
            }

            self.searchArray = temp;

            
            if (self.searchArray.count == 0) {
                
               _emptyLabel.hidden = NO;
            }
            else{
                
               _emptyLabel.hidden = YES;
            }
            
            _isSearch = YES;
            NSLog(@"==搜索成功==");
            
            [self.tableView reloadData];
        }
        else
        {
            NSLog(@"==网络异常==");
        }
    }];
}

- (void)handleTapBlankView:(UITapGestureRecognizer *)tapGestureRecognizer {
    [_searchController.view endEditing:YES];
}

- (void)handleNoData {
    if (self.searchController.active) {
        
    }
    else
    {
        
    }
}

@end
