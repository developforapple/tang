//
//  SafeCode.m
//  Laidian
//
//  Created by Jay on 2018/2/1.
//  Copyright © 2018年 来电科技. All rights reserved.
//

#import "SafeCode.h"

NSErrorUserInfoKey const SafeCodeErrorReasonKey = @"SafeCodeErrorReasonKey";
NSErrorUserInfoKey const SafeCodeErrorCallStackSymbolsKey = @"SafeCodeErrorCallStackSymbolsKey";
NSErrorUserInfoKey const SafeCodeErrorCallStackReturnAddressesKey = @"SafeCodeErrorCallStackReturnAddressesKey";

@implementation SafeCode

+ (BOOL)try:(__attribute__((noescape)) void(^)(void))tryBlock
      error:(__autoreleasing NSError * _Nullable *)error
{
    if (!tryBlock) return NO;

    NSError *result = safeCode(tryBlock);
    BOOL suc = result == nil;
    *error = result;
    return suc;
}

NSError * _Nullable
safeCode(__attribute__((noescape)) void(^tryBlock)(void)){
    
    if (!tryBlock)  return nil;
    
    NSError *error;
    @try {
        tryBlock();
    }
    @catch (NSException *e) {
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:e.userInfo];
        userInfo[SafeCodeErrorReasonKey] = e.reason;
        userInfo[SafeCodeErrorCallStackSymbolsKey] = e.callStackSymbols;
        userInfo[SafeCodeErrorCallStackReturnAddressesKey] = e.callStackReturnAddresses;
        error = [NSError errorWithDomain:e.name code:0 userInfo:userInfo];
    }
    return error;
}

@end
