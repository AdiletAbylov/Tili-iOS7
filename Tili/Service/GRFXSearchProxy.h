//
// Created by Adilet Abylov on 11/24/13.
// Copyright (c) 2013 Adilet Abylov. All rights reserved.
//


#import <Foundation/Foundation.h>

@protocol GRFXSearchProxyDelegate <NSObject>
- (void)searchProxyDidSuccessWithResults:(NSArray *)results;

- (void)searchProxyDidFailWithErrorString:(NSString *)errorString;
@end

@interface GRFXSearchProxy : NSObject
@property(weak) id <GRFXSearchProxyDelegate> delegate;

- (void)searchWord:(NSString *)word;
@end