#import <UIKit/UIKit.h>

#import "CENotificationCellPresentable.h"

@interface CENotificationCell : UITableViewCell

+ (nonnull NSString *)reuseIdentifier;
- (void)configureWithPresentable:(nonnull CENotificationCellPresentable *)presentable;

@end
