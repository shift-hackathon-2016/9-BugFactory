#import "CEAPIClient.h"

#import "CEResourceRequestSerializer.h"
#import "CEResourceResponseSerializer.h"

static NSString * const kAPIURL = @"http://api.getceres.com";

@implementation CEAPIClient

+ (instancetype)resourceClient
{
    static dispatch_once_t onceToken;
    static CEAPIClient *resourceClient;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *sessionConfiguration;
#warning TODO missing session configuration
        
        NSURL *URL = [NSURL URLWithString:kAPIURL];
        resourceClient = [[CEAPIClient alloc] initWithBaseURL:URL sessionConfiguration:sessionConfiguration];
        resourceClient.requestSerializer = [CEResourceRequestSerializer serializer];
        [resourceClient.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
        [resourceClient.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        
        resourceClient.responseSerializer = [CEResourceResponseSerializer serializer];
    });
    
    return resourceClient;
}

#pragma mark - Network

- (RACSignal *)GET:(NSString *)path parameters:(id)parameters
{
    return [self GET:path parameters:parameters progress:nil];
}

- (RACSignal *)GET:(NSString *)path parameters:(id)parameters progress:(nullable CENetworkProgressBlock)progress
{
    return [[self requestPath:path parameters:parameters method:@"GET" progress:progress] setNameWithFormat:@"%@ GET:%@, parameters:%@", self.class, path, parameters];
}

- (RACSignal *)POST:(NSString *)path parameters:(id)parameters
{
    return [self POST:path parameters:parameters progress:nil];
}

- (RACSignal *)POST:(NSString *)path parameters:(id)parameters progress:(nullable CENetworkProgressBlock)progress
{
    return [[self requestPath:path parameters:parameters method:@"POST" progress:progress] setNameWithFormat:@"%@ POST:%@, parameters:%@", self.class, path, parameters];
}

- (RACSignal *)PUT:(NSString *)path parameters:(id)parameters
{
    return [self PUT:path parameters:parameters progress:nil];
}

- (RACSignal *)PUT:(NSString *)path parameters:(id)parameters progress:(nullable CENetworkProgressBlock)progress
{
    return [[self requestPath:path parameters:parameters method:@"PUT" progress:progress] setNameWithFormat:@"%@ PUT:%@, parameters:%@", self.class, path, parameters];
}

- (RACSignal *)PATCH:(NSString *)path parameters:(id)parameters
{
    return [self PATCH:path parameters:parameters progress:nil];
}

- (RACSignal *)PATCH:(NSString *)path parameters:(id)parameters progress:(nullable CENetworkProgressBlock)progress
{
    return [[self requestPath:path parameters:parameters method:@"PATCH" progress:progress] setNameWithFormat:@"%@ PATCH:%@, parameters:%@", self.class, path, parameters];
}

- (RACSignal *)DELETE:(NSString *)path parameters:(id)parameters
{
    return [self DELETE:path parameters:parameters progress:nil];
}

- (RACSignal *)DELETE:(NSString *)path parameters:(id)parameters progress:(nullable CENetworkProgressBlock)progress
{
    return [[self requestPath:path parameters:parameters method:@"DELETE" progress:progress] setNameWithFormat:@"%@ DELETE:%@, parameters:%@", self.class, path, parameters];
}

- (RACSignal *)HEAD:(NSString *)path parameters:(id)parameters
{
    return [self HEAD:path parameters:parameters progress:nil];
}

- (RACSignal *)HEAD:(NSString *)path parameters:(id)parameters progress:(CENetworkProgressBlock)progress
{
    return [[self requestPath:path parameters:parameters method:@"HEAD" progress:progress] setNameWithFormat:@"%@ DELETE:%@, parameters:%@", self.class, path, parameters];
}

#pragma mark - Private

- (nonnull RACSignal *)requestPath:(nonnull NSString *)path parameters:(nullable id)parameters method:(nonnull NSString *)method progress:(nullable CENetworkProgressBlock)progress
{
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        
        NSError *serializerError = nil;
        NSString *URLString = [[NSURL URLWithString:path
                                      relativeToURL:self.baseURL] absoluteString];
        
        NSURLRequest *request = [[self requestSerializer] requestWithMethod:method URLString:URLString parameters:parameters error:&serializerError];

        if (!request) {
            [subscriber sendError:serializerError];
        }
        
        RACSubject *uploadProgressSubject;
        RACSubject *downloadProgressSubject;
        
        if (progress) {
            uploadProgressSubject = [RACSubject subject];
            downloadProgressSubject = [RACSubject subject];
            RACSignal *uploadProgressSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [uploadProgressSubject subscribe:subscriber];
                
                return nil;
            }];
            RACSignal *downloadProgressSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [downloadProgressSubject subscribe:subscriber];
                
                return nil;
            }];
            progress(uploadProgressSignal, downloadProgressSignal);
        }
        
        NSURLSessionDataTask *task = [self dataTaskWithRequest:request uploadProgress:^(NSProgress *_Nonnull uploadProgress) {
            if (uploadProgressSubject) {
                [uploadProgressSubject sendNext:uploadProgress];
            }
        } downloadProgress:^(NSProgress *_Nonnull downloadProgress) {
            if (downloadProgressSubject) {
                [downloadProgressSubject sendNext:downloadProgress];
            }
        } completionHandler:^(NSURLResponse *_Nonnull response, id _Nullable responseObject, NSError *_Nullable error) {
            if (uploadProgressSubject) {
                [uploadProgressSubject sendCompleted];
            }
            
            if (downloadProgressSubject) {
                [downloadProgressSubject sendCompleted];
            }
            
            if (error) {
                [subscriber sendError:error];
            } else {
                [subscriber sendNext:RACTuplePack(response, responseObject)];
                [subscriber sendCompleted];
            }
        }];
        
        [task resume];
        
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}

@end
