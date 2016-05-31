#import "CENotificationCell.h"

@interface CENotificationCell ()



@end

@implementation CENotificationCell

+ (NSString *)reuseIdentifier
{
    return NSStringFromClass(self);
}

- (void)configureWithPresentable:(CENotificationCellPresentable *)presentable
{
    
}

@end
