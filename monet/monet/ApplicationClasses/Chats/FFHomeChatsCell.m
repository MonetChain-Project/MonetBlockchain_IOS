//
//  FFHomeChatsCell.m
//  MonetBlockchain
//
//  Created by Rain on 17/12/11.
//  Copyright © 2017年 MonetBlockchain Foundation All rights reserved.
//

#import "FFHomeChatsCell.h"

@interface FFHomeChatsCell ()
/** 头像 */
@property (nonatomic, strong) DDYHeader *avatarView;
/** 昵称 */
@property (nonatomic, strong) UILabel *nameLabel;
/** 时间 */
@property (nonatomic, strong) UILabel *timeLabel;
/** 内容 */
@property (nonatomic, strong) UILabel *contentLabel;
/** 未读 */
@property (nonatomic, strong) UILabel *unreadLabel;

@end

@implementation FFHomeChatsCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    NSString *cellID = NSStringFromClass([self class]);
    FFHomeChatsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    return cell?cell:[[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self setupContentView];
    }
    return self;
}

- (void)setupContentView {
    _avatarView = [DDYHeader headerWithHeaderWH:46];
    _avatarView.ddy_x = 12;
    _avatarView.ddy_y = 12;
    _avatarView.backgroundColor = DDY_ClearColor;
    [self.contentView addSubview:_avatarView];
//    _avatarView = ({
//        UIImageView *avatarView = [[UIImageView alloc] initWithFrame:DDYRect(10, 10, 50, 50)];
//        avatarView.contentMode = UIViewContentModeScaleAspectFill;
//        [self.contentView addSubview:avatarView];
//        DDYBorderRadius(avatarView, avatarView.ddy_w/2.0, 0, DDY_ClearColor);
//        avatarView;
//    });
    
    _nameLabel = [self labelColor:DDY_Big_Black font:DDYFont(17) bgColor:DDY_ClearColor];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    
    _timeLabel = [self labelColor:DDY_Mid_Black font:DDYFont(12) bgColor:DDY_ClearColor];
    _timeLabel.textAlignment = NSTextAlignmentRight;
    
    _contentLabel = [self labelColor:DDY_Mid_Black font:DDYFont(14) bgColor:DDY_ClearColor];
    _contentLabel.textAlignment = NSTextAlignmentLeft;
    
    _unreadLabel = [self labelColor:DDY_White font:DDYFont(10) bgColor:DDY_Red];
    _unreadLabel.textAlignment = NSTextAlignmentCenter;
    DDYBorderRadius(_unreadLabel, 8, 0, DDY_Red);
}

#pragma mark 生成label
- (UILabel *)labelColor:(UIColor *)color font:(UIFont *)font bgColor:(UIColor *)bgColor {
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = bgColor;
    label.textColor = color;
    label.font = font;
    [self.contentView addSubview:label];
    return label;
}

- (void)setRecentModel:(FFRecentModel *)recentModel {
    _recentModel = recentModel;
    _nameLabel.text = recentModel.remarkName;
    _timeLabel.text = [NSDate chatTime:DDYStrFormat(@"%ld",(long)recentModel.timeStamp) enOrCn:DDYLocalStr(@"enOrCn")];
    _contentLabel.text = recentModel.showText;
    _unreadLabel.text = DDYStrFormat(@"%@",recentModel.unread>99?@"99+":[NSString stringWithFormat:@"%ld",(long)recentModel.unread]);
    _unreadLabel.hidden = (recentModel.unread<1);
    _timeLabel.hidden = (recentModel.timeStamp==0);
    switch (recentModel.chatType)
    {
        case FFChatTypeEveryOne:
        {
            _avatarView.imgArray = @[[UIImage imageNamed:@"FFT_wallet_icon"]];
            _avatarView.urlArray = @[@""];
        }
            break;
        case FFChatTypeSingle:
        {
            _avatarView.imgArray = @[[FFUser avatarWithRemarkName:recentModel.remarkName]];
            NSString *imgURL = [[FFUserDataBase sharedInstance] getUserWithLocalID:recentModel.remoteID].userImage;
            _avatarView.urlArray = @[imgURL ? imgURL : @""]; // 有可能各种原因造成url不存在，例如无网用户
        }
            break;
        case FFChatTypeGroup:
        {
            FFGroupModel *group = [[FFUserDataBase sharedInstance] getGroupWithCid:recentModel.remoteID];
            NSMutableArray *avatarArray = [NSMutableArray array];
            NSMutableArray *placeholderArray = [NSMutableArray array];
            for (FFUser *user in group.memberList) {
                [placeholderArray addObject:user.remarkName ? [FFUser avatarWithRemarkName:user.remarkName] : @"随便写的"];
                [avatarArray addObject:user.userImage ? user.userImage : @""];
            }
            _avatarView.imgArray = placeholderArray;
            _avatarView.urlArray = (avatarArray && avatarArray.count) ? avatarArray : @[@""] ;
        }
            break;
        case FFChatTypeSystem:
        default:
        {
            _avatarView.imgArray = @[[UIImage imageNamed:@"logo"]];
            _avatarView.urlArray = @[@""];
        }
            break;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat margin = 10;
    _timeLabel.frame = DDYRect(DDYSCREENW-margin-[_timeLabel labW], margin, [_timeLabel labW], 20);
    _nameLabel.frame = DDYRect(_avatarView.ddy_right+margin, margin, [_nameLabel labMaxW:_timeLabel.ddy_x-_avatarView.ddy_right-36], 20);
    _unreadLabel.frame = DDYRect(_nameLabel.ddy_right+5, margin, [_unreadLabel labMinW:13]+4, 16);
    _contentLabel.frame = DDYRect(_nameLabel.ddy_x, _avatarView.ddy_bottom-20, DDYSCREENW-margin-_avatarView.ddy_right-margin, 20);
}

@end
