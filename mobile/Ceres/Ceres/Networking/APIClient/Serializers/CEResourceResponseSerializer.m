#import "CEResourceResponseSerializer.h"

#import "CEResourceErrorContext.h"

@implementation CEResourceResponseSerializer

- (id)responseObjectForResponse:(NSURLResponse *)response data:(NSData *)data error:(NSError *__autoreleasing _Nullable *)error
{
    id JSONObject = [super responseObjectForResponse:response data:data error:error];
    
    //catch error
    if (*error != nil) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        CEResourceErrorContext *errorContext;
        
        if (data) {
            NSError *serializationError;
            
            id errorJSONObject = [NSJSONSerialization JSONObjectWithData:data options:self.readingOptions error:&serializationError];
            
            if (!serializationError && errorJSONObject) {
                errorContext = [CEResourceErrorContext new];
                errorContext.statusCode = [errorJSONObject[@"status"] integerValue];
                errorContext.title = errorJSONObject[@"title"];
                errorContext.message = errorJSONObject[@"message"];
                errorContext.HTTPStatusCode = httpResponse.statusCode;
            }
        }
        
        // assign error context to error object
        NSError *customError = [(*error) setContext:errorContext];
        *error = customError;
    }
    
    return JSONObject;
}

- (NSSet<NSString *> *)acceptableContentTypes
{
    NSArray *acceptableContentTypes = @[
                                        @"application/json",
                                        @"text/json",
                                        @"text/javascript",
                                        @"application/vnd.api+json"
                                        ];
    
    return [NSSet setWithArray:acceptableContentTypes];
}

- (BOOL)removesKeysWithNullValues
{
    return YES;
}

@end
