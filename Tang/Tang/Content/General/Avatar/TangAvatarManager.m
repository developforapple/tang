//
//  TangAvatarManager.m
//  Tang
//
//  Created by wwwbbat on 2017/9/17.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "TangAvatarManager.h"
#import "BingoCache.h"

@interface TangAvatarManager ()
@property (strong, nonatomic) NSMutableDictionary<NSString *,TASK> *taskDict;
@end

@implementation TangAvatarManager

+ (instancetype)manager
{
    static TangAvatarManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [TangAvatarManager new];
        manager.taskDict = [NSMutableDictionary dictionary];
    });
    return manager;
}

- (NSString *)avatarKey:(NSString *)blogName
{
    return [NSString stringWithFormat:@"avatar_%@",blogName];
}

- (NSString *)avatar:(NSString *)blogName size:(TangAvatarSize)size
{
    if (!blogName) return nil;
    
    NSString *avatar = (NSString *)[APPCACHE objectForKey:[self avatarKey:blogName]];
    if (avatar) {
        @try{
            NSString *url = [NSString stringWithFormat:avatar,size];
            return url;
        }@catch (NSException *ex){
            return avatar;
        }
    }
    [self requestAvatar:blogName];
    return nil;
}

- (NSString *)avatar:(NSString *)blogName
{
    return [self avatar:blogName size:TangAvatarSizeDefault];
}

- (void)requestAvatar:(NSString *)blogName
{
    if (self.taskDict[blogName]) return;
    
    TASK task =
    [API fetchAvatar:blogName completion:^(BOOL suc,NSString *url) {
        
        if (suc) {
            [APPCACHE setObject:url forKey:[self avatarKey:blogName]];
            self.taskDict[blogName] = nil;
        }
        
    }];
    
    self.taskDict[blogName] = task;
}

@end
