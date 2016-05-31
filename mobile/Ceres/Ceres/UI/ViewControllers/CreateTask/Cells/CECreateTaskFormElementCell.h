#import <UIKit/UIKit.h>

#import "CECreateTaskFormElementCellPresentable.h"

@interface CECreateTaskFormElementCell : UITableViewCell

+ (nonnull NSString *)reuseIdentifier;
- (void)configureWithPresentable:(nonnull CECreateTaskFormElementCellPresentable *)presentable;

@end
