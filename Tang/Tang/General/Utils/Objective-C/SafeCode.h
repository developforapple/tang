//
//  SafeCode.h
//  Laidian
//
//  Created by Tiny on 2018/2/1.
//  Copyright © tiny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 对应NSException的reason
FOUNDATION_EXPORT NSErrorUserInfoKey const SafeCodeErrorReasonKey;
// 对应NSException的callStackSymbols
FOUNDATION_EXPORT NSErrorUserInfoKey const SafeCodeErrorCallStackSymbolsKey;
// 对应NSException的callStackReturnAddresses
FOUNDATION_EXPORT NSErrorUserInfoKey const SafeCodeErrorCallStackReturnAddressesKey;

/**
 本类主要用于在swift中catch到Objective-C的异常。
 使用类方法时，swift中使用 do{ try SafeCode.try{...} }catch{...}语句。
 使用函数时，swift中要用 if let error = safeCode(...) {} 语句
 */
__attribute__((objc_subclassing_restricted))
@interface SafeCode : NSObject
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

/**
 执行Block，处理Block中可能发生的异常

 @param tryBlock 需要执行的代码
 @param error 发生的异常
 @return 是否执行成功
 */
+ (BOOL)try:(__attribute__((noescape)) void(^)(void))tryBlock
      error:(__autoreleasing NSError * _Nullable *)error;

@end

/**
 执行Block，处理Block中可能发生的异常
 
 @param tryBlock 需要执行的代码
 @return catch到的异常
 */
FOUNDATION_EXTERN
NSError * _Nullable
safeCode(__attribute__((noescape)) void(^tryBlock)(void));

NS_ASSUME_NONNULL_END
