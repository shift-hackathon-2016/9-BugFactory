#import "CETaskPresentable.h"

@implementation CETaskPresentable

+ (instancetype)presentableWithTask:(CETask *)task
{
    CETaskPresentable *presentable = [self new];
    
    presentable.descriptionObject = task.descriptionObject;
    
    return presentable;
}

@end
