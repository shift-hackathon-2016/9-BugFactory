#import "CENotificationCell.h"

@interface CENotificationCell ()

@property (strong, nonatomic, nonnull) UIImageView *iconImageView;
@property (strong, nonatomic, nonnull) UILabel *titleLabel;
@property (strong, nonatomic, nonnull) UILabel *descriptionLabel;

@end

@implementation CENotificationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.backgroundColor = [UIColor clearColor];
    
    [self loadSubviews];
    
    return self;
}

+ (NSString *)reuseIdentifier
{
    return NSStringFromClass(self);
}

- (void)configureWithPresentable:(CENotificationCellPresentable *)presentable
{
    self.titleLabel.text = presentable.title;
    self.descriptionLabel.text = presentable.descriptionObject;
}

- (void)loadSubviews
{
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.descriptionLabel];
    
    [self.contentView setNeedsUpdateConstraints];
    [self.contentView updateConstraintsIfNeeded];
}

- (void)updateConstraints
{
    [self.iconImageView remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
        make.centerY.equalTo(self.contentView);
        make.width.height.equalTo(@40);
    }];
    
    [self.titleLabel remakeConstraints:^(MASConstraintMaker *make) {
        UIEdgeInsets insets = UIEdgeInsetsMake(10, 10, 10, 10);
        make.top.right.equalTo(self.contentView).with.insets(insets);
        make.left.equalTo(self.iconImageView.right).with.insets(insets);
    }];
    
    [self.descriptionLabel remakeConstraints:^(MASConstraintMaker *make) {
        UIEdgeInsets insets = UIEdgeInsetsMake(10, 10, 10, 10);
        make.top.equalTo(self.titleLabel.bottom).with.insets(insets);
        make.bottom.right.equalTo(self.contentView).with.insets(insets);
        make.left.equalTo(self.iconImageView.right).with.insets(insets);
    }];
    
    [super updateConstraints];
}

#pragma mark - Properties

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor whiteColor];
    }
    
    return _titleLabel;
}

- (UILabel *)descriptionLabel
{
    if (!_descriptionLabel) {
        _descriptionLabel = [UILabel new];
        _descriptionLabel.numberOfLines = 0;
        _descriptionLabel.textColor = [UIColor whiteColor];
    }
    
    return _descriptionLabel;
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
        _iconImageView.backgroundColor = [UIColor darkGrayColor];
        _iconImageView.layer.cornerRadius = 20;
        _iconImageView.layer.masksToBounds = YES;
        _iconImageView.image = [[UIImage imageNamed:@"hiring-sign"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _iconImageView.tintColor = [UIColor whiteColor];
    }
    
    return _iconImageView;
}

@end
