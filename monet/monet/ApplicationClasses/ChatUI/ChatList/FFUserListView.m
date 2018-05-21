//
//  FFUserListView.m
//  MonetBlockchain
//
//  Created by Rain on 17/9/18.
//  Copyright © 2017年 MonetBlockchain Foundation All rights reserved.
//

#import "FFUserListView.h"

static NSString *cellID = @"FFUserListViewCellID";

@interface FFUserListViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *avatarView;
@end

@implementation FFUserListViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _avatarView = [[UIImageView alloc] initWithFrame:self.bounds];
        _avatarView.image = [UIImage imageNamed:@"icon_head_defaul"];
        _avatarView.contentMode = UIViewContentModeScaleAspectFill;
        _avatarView.backgroundColor = DDYRGBA(240, 240, 240, 1);
        [self addSubview:_avatarView];
    }
    return self;
}

@end

///////////////////////////////////////////////////////////////////////////////////

@interface FFUserListView ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation FFUserListView

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

+ (instancetype)listView {
    return [[self alloc] initWithFrame:DDYRect(0, 64, DDYSCREENW, FFUserListViewH)];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupContentView];
    }
    return self;
}

- (void)setupContentView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection =UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.itemSize = CGSizeMake(50, 50);
    layout.minimumInteritemSpacing = 10;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = DDY_White;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [_collectionView registerClass:[FFUserListViewCell class] forCellWithReuseIdentifier:cellID];
    [self addSubview:_collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FFUserListViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
//    cell.avatarView.image = ;
    return cell;
}

- (void)changeList:(NSMutableArray *)onlineUserArray {
    _dataArray = onlineUserArray;
    [_collectionView reloadData];
}

@end
