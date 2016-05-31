#import "CECreateTaskFormElementCell.h"

@interface CECreateTaskFormElementCell ()

@property (strong, nonatomic, nonnull) UILabel *titleLabel;
@property (strong, nonatomic, nonnull) UIView *containerView;
@property (strong, nonatomic, nonnull) UIView *formElementView;

@end

@implementation CECreateTaskFormElementCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    [self loadSubviews];
    
    return self;
}

- (void)loadSubviews
{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.containerView];
    
    [self.contentView setNeedsUpdateConstraints];
    [self.contentView updateConstraintsIfNeeded];
}

- (void)updateConstraints
{
    [self.titleLabel remakeConstraints:^(MASConstraintMaker *make) {
        UIEdgeInsets insets = UIEdgeInsetsMake(5, 10, 0, 10);
        make.top.left.right.equalTo(self.contentView).with.insets(insets);
    }];
    
    [self.containerView remakeConstraints:^(MASConstraintMaker *make) {
        UIEdgeInsets insets = UIEdgeInsetsMake(5, 10, 0, 10);
        make.top.equalTo(self.titleLabel.bottom).with.insets(insets);
        make.left.bottom.right.equalTo(self.contentView).with.insets(insets);
    }];
    
    [super updateConstraints];
}

- (void)configureWithPresentable:(CECreateTaskFormElementCellPresentable *)presentable
{
    self.titleLabel.text = presentable.title;
    
    if (!self.formElementView) {
        self.formElementView = presentable.formElementView;
        [self.containerView addSubview:self.formElementView];
    }
    
    [self.formElementView remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.containerView);
    }];
    
    [self.contentView setNeedsUpdateConstraints];
    [self.contentView updateConstraintsIfNeeded];
}

+ (NSString *)reuseIdentifier
{
    return NSStringFromClass(self);
}

#pragma mark - Properties

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
    }
    
    return _titleLabel;
}

- (UIView *)containerView
{
    if (!_containerView) {
        _containerView = [UIView new];
    }
    
    return _containerView;
}

@end
