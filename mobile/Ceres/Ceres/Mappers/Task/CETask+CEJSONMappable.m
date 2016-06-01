#import "CETask+CEJSONMappable.h"

#import "CELocation+CEJSONMappable.h"

@implementation CETask (CEJSONMappable)

+ (id)objectWithJSON:(NSDictionary *)JSON error:(NSError *__autoreleasing  _Nullable *)error
{
    CETask *object = [self new];
    
    object.identifier = JSON[@"id"];
    object.categoryId = JSON[@"category_id"];
    object.userId = JSON[@"user_id"];
    object.locationId = JSON[@"location_id"];
    object.descriptionObject = JSON[@"description"];
    object.location = [CELocation objectWithJSON:JSON[@"location"] error:error];
    
    return object;
}

@end
