#import "CEAPIClient.h"

@implementation CEAPIClient

+ (instancetype)resourceClient
{
    static dispatch_once_t onceToken;
    static ADAPIClient *resourceClient;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *sessionConfiguration;
#warning TODO missing session configuration
        
        resourceClient = [[ADAPIClient alloc] initWithBaseURL:[ADConfiguration sharedInstance].resourceAPIURL sessionConfiguration:sessionConfiguration];
        resourceClient.requestSerializer = [ADResourceRequestSerializer serializer];
        [resourceClient.requestSerializer setValue:@"application/vnd.api+json" forHTTPHeaderField:@"Content-type"];
        [resourceClient.requestSerializer setValue:@"application/vnd.api+json" forHTTPHeaderField:@"Accept"];
        
        resourceClient.responseSerializer = [ADResourceResponseSerializer serializer];
    });
    
    return resourceClient;
}

@end
