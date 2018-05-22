//
//  NAMobileCountryCodeViewController.m
//  NextApp
//
//  Created by Megan   on 14-4-18.
//  Copyright (c) 2017年 MonetBlockchain Foundation All rights reserved.
//

#import "FFMobileCountryCodeVC.h"
#import "NSObject+LCDadasource.h"
@interface FFMobileCountryCodeVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
}


@property(nonatomic,retain) NSString * selectedString;

#define ___ds1 @"NACountryDatasource"
#define ___ds2 @"NACountryDatasourceAllKeys"

@end

@implementation FFMobileCountryCodeVC

-(void) dealloc
{
    LC_RDS(___ds1);
    LC_RDS(___ds2);
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id) initWithSelectedString:(NSString *)selectedString
{
    if (self = [super init]) {
       self.selectedString = selectedString;
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Build country datasource.
    NSString * path = [[NSBundle mainBundle] pathForResource:@"CountryMobilePrefix" ofType:@"list"];
    
    NSArray * allText = [[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil] componentsSeparatedByString:@"\n"];
    
    NSMutableDictionary * tempDic = [NSMutableDictionary dictionary];
    NSMutableArray * allKeys = [NSMutableArray array];
    
    for (NSString * text in allText) {
        
        NSArray * content = [text componentsSeparatedByString:@" "];
        
        NSString * country = [content objectAtIndex:0];
        NSString * code = [content objectAtIndex:1];
        
        if ([country compare:@"-"] == NSOrderedSame) {
            
            [allKeys addObject:code];
            [tempDic setObject:[NSMutableArray array] forKey:code];
            
        }else{
            
            NSString * result = [NSString stringWithFormat:@"%@ +%@",country,code];
            
            NSString * key = [allKeys lastObject];
            NSMutableArray * temp = [tempDic objectForKey:key];
            [temp addObject:result];
        }

    }
    
    [self setDatasource:tempDic key:___ds1];
    [self setDatasource:allKeys key:___ds2];
}

-(void) buildUI
{
    self.title = @"选择国家或地区";

    _tableView.sectionIndexTrackingBackgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor whiteColor];

    UIView * selectedCountryBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 64, DDYSCREENW, 30)];
    selectedCountryBackground.backgroundColor = APP_MAIN_COLOR;
    [self.view addSubview:selectedCountryBackground];
    [selectedCountryBackground addTapTarget:self action:@selector(selectedOldCountryAction)];
    
    UILabel * selectedCountryLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 30/2-14/2, DDYSCREENW-40, 14)];
    selectedCountryLabel.font = NA_FONT(13);
    selectedCountryLabel.textColor = [UIColor whiteColor];
    selectedCountryLabel.text = [NSString stringWithFormat:@"当前的选择： %@",self.selectedString];
    [selectedCountryBackground addSubview:selectedCountryLabel];
    
    float y = selectedCountryBackground.viewFrameY + selectedCountryBackground.viewFrameHeight;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, y, DDYSCREENW, DDYSCREENH - y) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableView];
}



#pragma mark - 

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return LC_DS(___ds2);
}


-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [LC_DS(___ds2) objectAtIndex:section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [LC_DS(___ds2) count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[LC_DS(___ds1) objectForKey:[LC_DS(___ds2) objectAtIndex:section]] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.font = NA_FONT(12);
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    NSString * key = [LC_DS(___ds2) objectAtIndex:indexPath.section];
    cell.textLabel.text = [[LC_DS(___ds1) objectForKey:key] objectAtIndex:indexPath.row];
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * key = [LC_DS(___ds2) objectAtIndex:indexPath.section];
    NSString * string = [[LC_DS(___ds1) objectForKey:key] objectAtIndex:indexPath.row];

    NSArray * count = [string componentsSeparatedByString:@" "];
    
    NSString * resultName = [NSString stringWithFormat:@"%@",[count objectAtIndex:0]];
    NSString * result = [NSString stringWithFormat:@"%@",[count objectAtIndex:1]];
    
    if (self.selectedAction) {
        self.selectedAction(result,resultName);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -


-(void) selectedOldCountryAction
{
    if (self.selectedAction) {
        self.selectedAction(self.selectedString,nil);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
