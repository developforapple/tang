//
//  TangPostVideoParser.m
//  Tang
//
//  Created by wwwbbat on 2017/9/17.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "TangPostVideoParser.h"
#import "TFHpple.h"

@implementation TangPostVideoParser

+ (TangVideoBaseData *)parsePost:(TangPost *)post
{
    if (![post.type isEqualToString:@"video"]) return nil;
    
    if ([post.video_type isEqualToString:@"instagram"]) {
        return [self parseInstagramVideo:post];
    }
    
    
    return [self parseTumblrVideo:post];
}

+ (TangVideoBaseData *)parseTumblrVideo:(TangPost *)post
{
    TangVideoBaseData *data = [TangVideoBaseData new];
    data.from = TangVideoSourceTumblr;
    
    NSString *code = post.player.lastObject.embed_code;
    NSData *htmlData = [code dataUsingEncoding:NSUTF8StringEncoding];
    TFHpple *root = [TFHpple hppleWithHTMLData:htmlData];
    
    TFHppleElement *videoNode = [root searchWithXPathQuery:@"//video"].firstObject;
    NSDictionary *videoAttr = [videoNode attributes];
    data.id = videoAttr[@"id"];
    data.thumbnail = videoAttr[@"poster"];
    
    NSString *videoJSONInfo;
    for (NSString *k in videoAttr) {
        if ([k hasPrefix:@"data-"]) {
            videoJSONInfo = videoAttr[k];
            break;
        }
    }
    
    if (videoJSONInfo) {
        NSDictionary *JSONInfo = [NSJSONSerialization JSONObjectWithData:[videoJSONInfo dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        if ([JSONInfo isKindOfClass:[NSDictionary class]]) {
            data.duration = [JSONInfo[@"duration"] floatValue];
            data.filmstrip = [self safeStringValueForKeyPath:@"filmstrip.url" onObject:JSONInfo];
            data.filmstripWidth = [[self safeStringValueForKeyPath:@"filmstrip.width" onObject:JSONInfo] floatValue];
            data.filmstripHeight = [[self safeStringValueForKeyPath:@"filmstrip.height" onObject:JSONInfo] floatValue];
        }
    }
    
    TFHppleElement *sourceNode = [root searchWithXPathQuery:@"//source"].firstObject;
    data.source = [sourceNode objectForKey:@"src"];
    data.type = [[sourceNode objectForKey:@"type"] lastPathComponent];
    
    NSString *fileName = data.source.lastPathComponent;
    if ([fileName hasPrefix:@"tumblr_"]) {
        data.video = [NSString stringWithFormat:@"https://vtt.tumblr.com/%@.%@",fileName,data.type];
    }
    
    return data;
}

+ (TangVideoBaseData *)parseInstagramVideo:(TangPost *)post
{
    if (![post.type isEqualToString:@"video"] ||
        ![post.video_type isEqualToString:@"instagram"]) return nil;
    
    
    NSString *link = post.permalink_url;
    NSString *webURL = [link stringByAppendingPathComponent:@"embed"];
    NSData *webData = [NSData dataWithContentsOfURL:[NSURL URLWithString:webURL]];
    if (!webData) return nil;
    
    
    NSString *html = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
    NSString *regex = @"window._sharedData[\\s*]=([\\s\\S]*?);";
    
    NSRegularExpression *re = [NSRegularExpression regularExpressionWithPattern:regex options:kNilOptions error:nil];
    NSTextCheckingResult *result = [re firstMatchInString:html options:NSMatchingReportCompletion range:NSMakeRange(0, html.length)];
    
    if (result && result.numberOfRanges > 1) {
        NSString *JSONInfo = [html substringWithRange:[result rangeAtIndex:1]];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[JSONInfo dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        if (dict && [dict isKindOfClass:[NSDictionary class]]) {
            
            NSString *source = [self safeStringValueForKeyPath:@"entry_data.EmbedPostlude.graphql.shortcode_media.video_url" onObject:dict];
            NSString *type = source.pathExtension;
            NSString *video = source;
            NSTimeInterval duration = kTangFieldUnknown;
            NSString *filmstrip = nil;
            NSInteger filmstripWidth = kTangFieldUnknown;
            NSInteger filmstripHeight = kTangFieldUnknown;
            NSString *thumbnail = [self safeStringValueForKeyPath:@"entry_data.EmbedPostlude.graphql.shortcode_media.display_url" onObject:dict];
            
            TangVideoBaseData *data = [TangVideoBaseData new];
            data.from = TangVideoSourceInstagram;
            data.thumbnail = thumbnail;
            data.filmstrip = filmstrip;
            data.filmstripWidth = filmstripWidth;
            data.filmstripHeight = filmstripHeight;
            data.duration = duration;
            data.source = source;
            data.type = type;
            data.video = video;
            
            return data;
        }
    }
    
    return nil;
}

+ (NSString *)safeStringValueForKeyPath:(NSString *)keyPath onObject:(id)object
{
    @try{
        id value = [object valueForKeyPath:keyPath];
        if (!value) {
            return nil;
        }else if ([value isKindOfClass:[NSArray class]]) {
            return [value firstObject];
        }else if ([value isKindOfClass:[NSString class]]){
            return value;
        }else{
            return [NSString stringWithFormat:@"%@",value];
        }
    }@catch(NSException *ex){
        return nil;
    }
}

@end

NSInteger const kTangFieldUnknown = -1;

@implementation TangVideoBaseData
YYModelDefaultCode
@end
