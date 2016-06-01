#import "CEUser+CEJSONMappable.h"

@implementation CEUser (CEJSONMappable)

+ (id)objectWithJSON:(NSDictionary *)JSON error:(NSError *__autoreleasing  _Nullable *)error
{
    CEUser *object = [self new];
    
    object.identifier = JSON[@"id"];
    object.firstName = JSON[@"first_name"];
    object.lastName = JSON[@"last_name"];
    
    return object;
}

@end
