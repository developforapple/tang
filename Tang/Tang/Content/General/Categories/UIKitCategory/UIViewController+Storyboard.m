//
//  UIViewController+Storyboard.m
//
//
//  Created by Normal on 15/11/17.
//  Copyright © 2015年 Bo Wang. All rights reserved.
//

#import "UIViewController+Storyboard.h"

// 使用 YYCache 或 PINCache 时将把storyboard名进行本地缓存
#if (__has_include(<YYCache/YYCache.h>) || __has_include("YYCache.h"))
    #import <YYCache/YYCache.h>
    typedef YYCache _YGCache;
#elif (__has_include(<PINCache/PINCache.h>) || __has_include("PINCache.h"))
    #import <PINCache/PINCache.h>
    typedef PINCache _YGCache;
#else
    typedef NSCache _YGCache;

    @interface _YGCache (_category)
    @end
    @implementation _YGCache (_category)
    - (instancetype)initWithName:(NSString *)name
    {
        _YGCache *cache = [self init];
        cache.name = name;
        return cache;
    }
    @end
#endif

@implementation UIViewController (Storyboard)

+ (NSDictionary<NSString *,NSSet<NSString *> *> *)storyboardIdentifierMap
{
    static NSDictionary *kViewControllerIdentifierToClassMap;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSMutableDictionary *tmp = [NSMutableDictionary dictionary];
        NSArray *list = [NSBundle pathsForResourcesOfType:@"storyboardc" inDirectory:[NSBundle mainBundle].resourcePath];
        for (NSString *path in list) {
            NSString *name = [[path lastPathComponent] stringByDeletingPathExtension];
            NSString *realName = [[name componentsSeparatedByString:@"~"] firstObject];
            NSBundle *bundle = [NSBundle bundleWithPath:path];
            NSDictionary *nibNames = [bundle objectForInfoDictionaryKey:@"UIViewControllerIdentifiersToNibNames"];
            tmp[realName] = [NSSet setWithArray:nibNames.allKeys];
        }
        kViewControllerIdentifierToClassMap = tmp;
    });
    return kViewControllerIdentifierToClassMap;
}

FOUNDATION_EXTERN NSString *const kAppBundleID;

+ (_YGCache *)cache
{
    static _YGCache *cache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *bundleid = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleIdentifierKey];
        NSString *cacheName = [bundleid stringByAppendingString:@".UIViewController+Storyboard"];
        cache = [[_YGCache alloc] initWithName:cacheName];
    });
    return cache;
}

/**
 *  尝试从以storyboardName为名的storyboard中取
 *
 *  @param storyboardName storyboard文件名
 *  @param identifier     查找的对象id
 *
 *  @return 查找到的UIViewController实例。如果没有找到，返回nil
 */
+ (instancetype)tryTakeOutInstanceFromStoryboardNamed:(NSString *)storyboardName identifier:(NSString *)identifier
{
    if (!storyboardName || !identifier) return nil;
    
    /**
     *  这里需要捕获异常，否则程序会crash
     */
    @try {
        static SEL sel;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            //identifierToNibNameMap 是UIStoryboard的一个私有属性
            NSString *selStr = [NSString stringWithFormat:@"%@%@%@%@%@",@"identifier",@"To",@"Nib",@"Name",@"Map"];
            sel = NSSelectorFromString(selStr);
        });

        UIStoryboard *sb = [UIStoryboard storyboardWithName:storyboardName bundle:[NSBundle mainBundle]];
        NO_WARNING_BEGIN(-Warc-performSelector-leaks)
        id obj = [sb performSelector:sel];
        NO_WARNING_END
        if (obj && [obj isKindOfClass:[NSDictionary class]] && [[(NSDictionary *)obj allValues] containsObject:identifier]) {
            UIViewController *vc = [sb instantiateViewControllerWithIdentifier:identifier];
            return vc;
        }
        return nil;
    }
    @catch (NSException *exception) {
        return nil;
    }
}

+ (instancetype)instanceFromStoryboardWithIdentifier:(NSString *)identifier
{
    if (!identifier) return nil;
    
    // 取缓存的storyboard名
    _YGCache *cache = [self cache];
    NSString *cacheStoryboardName = (NSString *)[cache objectForKey:identifier];
    if (cacheStoryboardName) {
        id vc = [self tryTakeOutInstanceFromStoryboardNamed:cacheStoryboardName identifier:identifier];
        if (vc) {
            return vc;
        }
        // 缓存的name不再有效
        [cache removeObjectForKey:identifier];
    }
    // 未缓存，遍历storyboard文件名列表，开始尝试取出实例。
    NSDictionary *map = [self storyboardIdentifierMap];
    for (NSString *name in map) {
        NSSet *identifierList = map[name];
        NSString *theIdentifier = [[identifier componentsSeparatedByString:@"."] lastObject];
        if ([identifierList containsObject:theIdentifier]) {
            UIViewController *instance = [self tryTakeOutInstanceFromStoryboardNamed:name identifier:theIdentifier];
            if (instance) {
                // 成功获取实例后，对storyboard名进行缓存
                [cache setObject:name forKey:identifier];
                return instance;
            }
        }
    }
    return [[self alloc] init];
}

+ (instancetype)instanceFromStoryboard
{
    return [self instanceFromStoryboardWithIdentifier:NSStringFromClass([self class])];
}

@end
