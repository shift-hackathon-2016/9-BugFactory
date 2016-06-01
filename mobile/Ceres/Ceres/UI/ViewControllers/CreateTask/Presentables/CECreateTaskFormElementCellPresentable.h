#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CEFormElementType) {
    CEFormElementTypeDescription,
    CEFormElementTypeStartDate,
    CEFormElementTypeEndDate
};

@interface CECreateTaskFormElementCellPresentable : NSObject

@property (strong, nonatomic, nonnull) UIView *formElementView;
@property (strong, nonatomic, nonnull) NSString *title;
@property (assign, nonatomic) CEFormElementType formElementType;

@property (strong, nonatomic, nonnull) id formValue;

@end
