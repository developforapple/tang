//
//  TangVideoData.m
//  Tang
//
//  Created by wwwbbat on 2017/9/18.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "TangVideoData.h"

BOOL createFolderAtPath(NSString *path){
    BOOL isDirectory;
    if ([[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory]) {
        if (!isDirectory) {
            [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
            return [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        }
        return YES;
    }
    return [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
}

@interface TangVideoData ()
{
    dispatch_semaphore_t _lock;
}
@end

@implementation TangVideoData

- (instancetype)init
{
    self = [super init];
    if (self) {
        _lock = dispatch_semaphore_create(1);
    }
    return self;
}

- (void)lock
{
    // 锁定1秒
    dispatch_semaphore_wait(_lock, dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)));
}

- (void)unlock
{
    dispatch_semaphore_signal(_lock);
}

- (void)addData:(NSData *)data location:(NSUInteger)location
{
    //TODO
}

- (BOOL)isEmpty
{
    return self.fragments.count == 0;
}

- (BOOL)isFully
{
    [self lock];
    
    BOOL ok = YES;
    for (long long idx = 0; idx < _length; ) {
        ok = NO;
        for (TangVideoFragment *fragment in self.fragments) {
            NSRange range = NSMakeRange(fragment.location, fragment.length);
            if (NSLocationInRange(idx, range)) {
                idx = NSMaxRange(range)+1;
                ok = YES;
                break;
            }
        }
        if (!ok) {
            break;
        }
    }
    
    [self unlock];
    return ok;
}

- (NSArray *)sortedFragments
{
    NSArray *sortedFragments = [self.fragments sortedArrayUsingComparator:^NSComparisonResult(TangVideoFragment *obj1, TangVideoFragment *obj2) {
        NSComparisonResult result;
        if (obj1.location < obj2.location) {
            result = NSOrderedAscending;
        }else if (obj1.location == obj2.location){
            result = obj1.length < obj2.length ? NSOrderedAscending  : NSOrderedDescending ;
        }else{
            result = NSOrderedDescending;
        }
        return result;
    }];
    return sortedFragments;
}

- (BOOL)overlapped
{
    if (self.fragments == nil || self.fragments.count <= 1) return NO;
    
    [self lock];
    
    BOOL overlapped = NO;
    NSArray *sortedFragments = [self sortedFragments];
    for (NSInteger idx = 1; idx < sortedFragments.count; idx++) {
        TangVideoFragment *lastOne = sortedFragments[idx-1];
        TangVideoFragment *thisOne = sortedFragments[idx];
        if (lastOne.location + lastOne.length > thisOne.location) {
            overlapped = YES;
            break;
        }
    }
    
    [self unlock];
    
    return overlapped;
}

- (void)smoothen
{
    if (self.fragments == nil || self.fragments.count <= 1) return;
    
    [self lock];
    
    NSArray *sortedFragments = [self sortedFragments];
    NSMutableArray *newFragments = [NSMutableArray array];
    
    TangVideoFragment *tmpFragment;
    
    for (NSInteger idx = 0; idx < sortedFragments.count; idx++) {
        
        TangVideoFragment *thisOne = sortedFragments[idx];
        
        // 开启新的分段
        if (!tmpFragment || tmpFragment.location + tmpFragment.length < thisOne.location) {
            tmpFragment = thisOne;
            [newFragments addObject:tmpFragment];
            continue;
        }
        
        // 合并 thisOne 的数据到分段中

        // 合并的数据的起点为分段末尾
        long long newDataLoc = tmpFragment.location + tmpFragment.length;
        // 合并的数据的长度
        long long newDataLen = thisOne.location + thisOne.length - newDataLoc;
        // 长度小于等于0时，表示thisOne已经被完全包含在分段中了。无需合并
        if (newDataLen > 0) {
            
            // 合并的数据在 thisOne data 中的范围
            NSRange newDataRange = NSMakeRange(newDataLoc-thisOne.location, newDataLen);
            NSData *newData = [thisOne getData:newDataRange];
            
            if (newData) {
                [tmpFragment appendData:newData];
            }
        }
    }
    
    // 更新分段数据
    self.fragments = newFragments;
    
    [self unlock];
}

- (NSRange)missingDataRangeInRange:(NSRange)range
{
    return NSMakeRange(0, 0);
}

@end

@interface TangVideoFragment ()
@property (copy, readwrite, nonatomic) NSString *url;
@property (assign, readwrite, nonatomic) long long location;
@property (assign, readwrite, nonatomic) long long length;
@property (strong, readwrite, nonatomic) NSMutableData *data;
@property (copy, readwrite, nonatomic) NSString *filePath;
@end

@implementation TangVideoFragment

- (instancetype)initWithURL:(NSString *)url location:(long long)location
{
    self = [super init];
    if (self) {
        self.url = url;
        self.location = location;
        NSUInteger hash = url.hash;
        
        NSString *folder = [AppTmpPath stringByAppendingPathComponent:[@(hash) stringValue]];
        createFolderAtPath(folder);
//        self.filePath = [folder stringByAppendingPathComponent:[]];
    }
    return self;
}

+ (instancetype)fragmentWithURL:(NSString *)url location:(long long)location
{
    return [[[self class] alloc] initWithURL:url location:location];
}

- (NSData *)getData:(NSRange)range
{
    if (self.data) {
        NSUInteger length = self.data.length;
        if (range.location <= length && NSMaxRange(range) <= length) {
            return [self.data subdataWithRange:range];
        }
        return nil;
    }
    return nil;
}

- (void)appendData:(NSData *)data
{
    if (data) {
        [self.data appendData:data];
        self.length += data.length;
    }
}

- (void)close
{
    
}

- (BOOL)isIntersectWith:(TangVideoFragment *)fragment
{
    if (!fragment || !fragment.url.length || !self.url.length || ![self.url isEqualToString:fragment.url]) return NO;
    
    return NO;
}

@end
