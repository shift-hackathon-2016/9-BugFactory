#import "CEResourceNetworkService.h"

@implementation CEResourceNetworkService

@synthesize APIClient = _APIClient;

- (CEAPIClient *)APIClient
{
    return [CEAPIClient resourceClient];
}


@end
