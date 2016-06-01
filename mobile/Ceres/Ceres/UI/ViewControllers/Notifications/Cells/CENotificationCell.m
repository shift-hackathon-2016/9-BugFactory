#import "CENotificationCell.h"

@interface CENotificationCell ()

@property (strong, nonatomic, nonnull) UILabel *titleLabel;
@property (strong, nonatomic, nonnull) UILabel *descriptionLabel;

@end

@implementation CENotificationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
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
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.descriptionLabel];
    
    [self.contentView setNeedsUpdateConstraints];
    [self.contentView updateConstraintsIfNeeded];
}

- (void)updateConstraints
{
    [self.titleLabel remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    
    [self.descriptionLabel remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.bottom).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
        make.bottom.left.right.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    
    [super updateConstraints];
}

#pragma mark - Properties

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
    }
    
    return _titleLabel;
}

- (UILabel *)descriptionLabel
{
    if (!_descriptionLabel) {
        _descriptionLabel = [UILabel new];
        _descriptionLabel.numberOfLines = 0;
    }
    
    return _descriptionLabel;
}

@end
