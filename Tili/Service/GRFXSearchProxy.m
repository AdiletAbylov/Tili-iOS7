//
// Created by Adilet Abylov on 11/24/13.
// Copyright (c) 2013 Adilet Abylov. All rights reserved.
//


#import "GRFXSearchProxy.h"
#import "AFHTTPRequestOperation.h"
#import "DCKeyValueObjectMapping.h"
#import "GRFXSearchResult.h"

#define SEARCH_URL @"http://tili.kg/dict/api/search/"

@implementation GRFXSearchProxy
{

@private
    __weak id <GRFXSearchProxyDelegate> _delegate;
}
@synthesize delegate = _delegate;

- (void)searchWord:(NSString *)word
{
    NSString *urlForSearch = [self urlToSearchWord:word];
    NSURLRequest *request = [NSURLRequest requestWithURL:[[NSURL alloc] initWithString:urlForSearch]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        DCKeyValueObjectMapping *parser = [DCKeyValueObjectMapping mapperForClass:[GRFXSearchResult class]];
        NSArray *results = [parser parseArray:responseObject];
        if (results.count == 0)
        {
            [_delegate searchProxyDidFailWithErrorString:@"Слово не найдено в словарях."];
        }
        else
        {
            [_delegate searchProxyDidSuccessWithResults:results];
        }
    }                                failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        NSLog(@"searchWord error: %@", error);
        [_delegate searchProxyDidFailWithErrorString:@"Произошла ошибка сервиса."];
    }];
    [operation start];
}

- (NSString *)urlToSearchWord:(NSString *)word
{
    NSString *url = [SEARCH_URL stringByAppendingString:word];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return url;
}
@end