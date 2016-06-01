#import "CETaskMapPinPresentable.h"

@implementation CETaskMapPinPresentable

+ (instancetype)presentableWithTask:(CETask *)task
{
    CETaskMapPinPresentable *presentable = [self new];
    
    presentable.taskId = task.identifier;
    presentable.coordinate = [task.location coordinate];
    
    return presentable;
}

@end
