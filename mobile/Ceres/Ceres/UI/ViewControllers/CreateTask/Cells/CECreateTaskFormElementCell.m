#import "CECreateTaskFormElementCell.h"

@implementation CECreateTaskFormElementCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    [self loadSubviews];
    
    return self;
}

- (void)loadSubviews
{
    
    
    [self.contentView setNeedsUpdateConstraints];
    [self.contentView updateConstraintsIfNeeded];
}

- (void)updateConstraints
{
    
    
    [super updateConstraints];
}

- (void)configureWithPresentable:(CECreateTaskFormElementCellPresentable *)presentable
{
    
}

+ (NSString *)reuseIdentifier
{
    return NSStringFromClass(self);
}

#pragma mark - Properties



@end
