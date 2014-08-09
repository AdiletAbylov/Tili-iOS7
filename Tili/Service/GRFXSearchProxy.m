//
// Created by Adilet Abylov on 11/24/13.
// Copyright (c) 2013 Adilet Abylov. All rights reserved.
//


#import "GRFXSearchProxy.h"
#import "AFHTTPRequestOperation.h"
#import "DCKeyValueObjectMapping.h"
#import "GRFXEntry.h"
#import "DCParserConfiguration.h"
#import "DCObjectMapping.h"

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

                DCParserConfiguration *configuration = [DCParserConfiguration configuration];
                DCObjectMapping *dictMapping = [DCObjectMapping mapKeyPath:@"dictname"
                                                               toAttribute:@"dictionaryName"
                                                                   onClass:[GRFXEntry class]];
                [configuration addObjectMapping:dictMapping];

                DCObjectMapping *valueMapping = [DCObjectMapping mapKeyPath:@"value"
                                                                toAttribute:@"text"
                                                                    onClass:[GRFXEntry class]];
                [configuration addObjectMapping:valueMapping];

                DCKeyValueObjectMapping *parser = [DCKeyValueObjectMapping mapperForClass:[GRFXEntry class] andConfiguration:configuration];
                NSArray *results = [parser parseArray:responseObject];
                if (results.count == 0)
                {
                    [_delegate searchProxyDidFailWithErrorString:@"Слово не найдено в словарях."];
                }
                else
                {
                    [_delegate searchProxyDidSuccessWithResults:results];
                }
            }                        failure:^(AFHTTPRequestOperation *operation, NSError *error)
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