#import "CELocation+CEJSONMappable.h"

@implementation CELocation (CEJSONMappable)

+ (id)objectWithJSON:(NSDictionary *)JSON error:(NSError *__autoreleasing  _Nullable *)error
{
    CELocation *object = [self new];
    
    object.latitude = JSON[@"latitude"];
    object.longitude = JSON[@"longitude"];
    
    return object;
}

@end
