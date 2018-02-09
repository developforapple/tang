//
//  VideoParser.swift
//  Tang
//
//  Created by Jay on 2018/2/9.
//  Copyright © 2018年 tiny. All rights reserved.
//

import UIKit

class VideoParser: NSObject {

    static func parse(_ post : TangPost) -> TangVideoInfo? {
        guard let a = post.type?.elementsEqual("video"), a, let video_type = post.video_type else {
            return nil
        }
        
        var info : TangVideoInfo?
        switch video_type {
        case "instagram":
            info = parseInstagram(post)
        default:
            info = parseDefault(post)
        }
        return info
    }
    
    private static func parseDefault(_ post : TangPost) -> TangVideoInfo? {
        
        let info = TangVideoInfo()
        info.from = .default
        
        let htmlData = post.player?.last?.embed_code?.data(using: .utf8)
        let root = TFHpple.init(htmlData: htmlData ?? Data.init())
        
        let videoNode = root?.search(withXPathQuery: "//video").first as? TFHppleElement
        let videoAttr = videoNode?.attributes as? [String:String]
        info.id = videoAttr?["id"]
        info.thumbnail = videoAttr?["poster"]
        
        var videoJsonInfo : String?
        for (k,v) in videoAttr ?? [:] {
            if k.hasPrefix("data-"){
                videoJsonInfo = v
                break
            }
        }
        if let data = videoJsonInfo?.data(using: .utf8) {
            if let jsonInfo = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String:Any] {
                info.duration = TimeInterval.init((jsonInfo["duration"] as? String) ?? "0")
                info.filmstrip = getSafeStringValue(on: jsonInfo, for: "filmstrip.url")
                
                let filmstripWidthStr = getSafeStringValue(on: jsonInfo, for: "filmstrip.width")
                info.filmstripWidth = Int(filmstripWidthStr ?? "0")
                
                let filmstripHeightStr = getSafeStringValue(on: jsonInfo, for: "filmstrip.height")
                info.filmstripHeight = Int(filmstripHeightStr ?? "0")
            }
        }
        
        let sourceNode = root?.search(withXPathQuery: "//source").first as? TFHppleElement
        info.source = sourceNode?.object(forKey: "src") ?? ""
        info.type = (sourceNode?.object(forKey: "type") as NSString?)?.lastPathComponent
        
        let regular = try? NSRegularExpression.init(pattern: "tumblr_[0-9a-zA-Z]*", options: .caseInsensitive)
        if let result = regular?.firstMatch(in: info.source,
                                            options: [],
                                            range: info.source.rangeOfAll) {
            let fileName = (info.source as NSString).substring(with: result.range)
            info.video = String.init(format: "https://vtt.tumblr.com/%@.%@", fileName,info.type)
        }
        
        return info
    }
    
    private static func parseInstagram(_ post : TangPost) -> TangVideoInfo? {
        
        guard let url = (post.permalink_url as NSString?)?.appendingPathComponent("embed"),
              let webURL = URL.init(string: url),
              let data = try? Data.init(contentsOf: webURL),
              let html = String.init(data: data, encoding: .utf8),
              let re = try? NSRegularExpression.init(pattern: "window._sharedData[\\s*]=([\\s\\S]*?);", options: []),
              let result = re.firstMatch(in: html, options: .reportCompletion, range: html.rangeOfAll),
              result.numberOfRanges > 1,
              let jsonData = (html as NSString).substring(with: result.range(at: 1)).data(using: .utf8),
              let jsonDict = (try? JSONSerialization.jsonObject(with: jsonData, options: [])) as? [String:Any],
              let videoinfo = searchVideoURLAndDisplayURLs(on:jsonDict)?.first,
              videoinfo.count > 0
        else { return nil }
        
        let info = TangVideoInfo()
        info.from = .instagram
        info.thumbnail = videoinfo.count>1 ? videoinfo[1] : ""
        info.filmstrip = nil
        info.filmstripWidth = nil
        info.filmstripHeight = nil
        info.duration = nil
        info.source = videoinfo.first!
        info.type = (info.source as NSString).pathExtension
        info.video = info.source
        return info
    }
    
    private static func getSafeStringValue(on object: Any, for keyPath : String) -> String? {
        var result : String?
        do {
            try SafeCode.try {
                
                guard   let obj = object as? NSObject,
                        let v = obj.value(forKeyPath: keyPath) as? NSObject
                else {return}
                
                switch v {
                case _  where v is [String] :
                    result = (v as! [String]).first
                case _ where v is String :
                    result = v as? String;
                default :
                    result = String.init(format: "%@", v)
                }
            }
        } catch {
        }
        return result
    }
    
    private static func searchVideoURLAndDisplayURLs(on jsonObject : [String:Any]) -> [[String]]? {
        
        let video_url = jsonObject["video_url"] as? String
        let display_url = jsonObject["display_url"] as? String
        if let vu = video_url {
            return [[vu,display_url ?? ""]]
        }
        
        var all : [[String]] = [[]]
        
        for (_,v) in jsonObject {
            
            if let d = v as? [String:Any] {
                if let a = searchVideoURLAndDisplayURLs(on: d) {
                    all.append(contentsOf: a)
                }
            }else if let d = v as? [Any] {
                
                for b in d {
                    if let tmp = b as? [String:Any] {
                        if let a = searchVideoURLAndDisplayURLs(on: tmp){
                            all.append(contentsOf: a)
                        }
                    }
                }
            
            }
        }
        
        if all.count > 0 {
            return all
        }
        return nil
    }
}
