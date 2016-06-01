#import "CENotification+CEJSONMappable.h"

@implementation CENotification (CEJSONMappable)

+ (id)objectWithJSON:(NSDictionary *)JSON error:(NSError *__autoreleasing  _Nullable *)error
{
    CENotification *object = [self new];
    
    object.identifier = JSON[@"id"];
    object.objectId = JSON[@"object_id"];
    
    return object;
}

@end
