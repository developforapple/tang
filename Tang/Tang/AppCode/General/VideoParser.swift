//
//  VideoParser.swift
//  Tang
//
//  Created by Tiny on 2018/2/9.
//  Copyright © 2018年 tiny. All rights reserved.
//

import UIKit

class VideoParser: NSObject {

    static func parse(_ post : TangVideoPost) -> TangVideoInfo? {
        
        guard let video_type = post.video_type, post.type == .video else {
            return nil
        }
        
        var info : TangVideoInfo?
        switch video_type {
        case .instagram:
            info = parseInstagram(post)
        default:
            info = parseDefault(post)
        }
        return info
    }
    
    private static func getVideoImages(_ post : TangVideoPost, _ info : TangVideoInfo) {
    
        guard let firstFrameURL = post.thumbnail_url, let components = NSURLComponents.init(string: firstFrameURL) else {
            return
        }
        components.query = nil
        components.fragment = nil
        let url = components.string! as NSString
        let ext = url.pathExtension
        let head = (url.deletingPathExtension as NSString).deletingLastPathComponent as NSString
        let name = (url.deletingPathExtension as NSString).lastPathComponent as NSString
        var nameParts = name.components(separatedBy: "_")
        nameParts.removeLast()
        let nameHead = nameParts.joined(separator: "_")
        
        var result : [String] = []
        
        for i in 0..<5 {
            let aName = nameHead + "_frame\(i+1)"
            let full = (head.appendingPathComponent(aName) as NSString).appendingPathExtension(ext)!
            result.append(full)
        }
        
        info.frames = result
        info.poster = (head.appendingPathComponent(nameHead + "_smart1") as NSString).appendingPathExtension(ext)!
        info.filmstrip = (head.appendingPathComponent(nameHead + "_filmstrip") as NSString).appendingPathExtension(ext)!
    }
    
    private static func parseDefault(_ post : TangVideoPost) -> TangVideoInfo? {
        
        let info = TangVideoInfo()
        info.type = .tumblr
        info.duration = post.duration
        info.width = post.thumbnail_width
        info.height = post.thumbnail_height
        
        getVideoImages(post, info)
        
        if let videoURL = post.video_url {
            info.video = videoURL
            info.format = (videoURL as NSString).pathExtension
        }
        
        if let source_url = post.source_url {
            info.source = source_url
        }
        
        if let embed = post.player.last?.embed_code.data(using: .utf8),
            let root = TFHpple.init(htmlData: embed),
            let videoNode = root.search(withXPathQuery: "//video").first as? TFHppleElement,
            let videoAttr = videoNode.attributes as? [String:Any]{
            
            if info.poster == nil, let poster = videoAttr["poster"] as? String {
                info.poster = poster
                if info.frames.count == 0 {
                    info.frames.append(poster)
                }
            }
            
            if let sourceNode = root.search(withXPathQuery: "//source").first as? TFHppleElement {
                info.video_page = sourceNode.object(forKey: "src")
                info.format = (sourceNode.object(forKey: "type") as NSString).lastPathComponent

                let regular = try? NSRegularExpression.init(pattern: "tumblr_[0-9a-zA-Z]*", options: .caseInsensitive)
                if let result = regular?.firstMatch(in: info.video_page!,
                                                    options: [],
                                                    range: info.video_page!.rangeOfAll) {
                    let fileName = (info.video_page! as NSString).substring(with: result.range)
                    info.video = String.init(format: "https://vtt.tumblr.com/%@.%@", fileName,info.format!)
                }
            }
        }
        
        return info
    }
    
    private static func parseInstagram(_ post : TangPost) -> TangVideoInfo? {
        
        
//        guard let url = (post.permalink_url as NSString?)?.appendingPathComponent("embed"),
//              let webURL = URL.init(string: url),
//              let data = try? Data.init(contentsOf: webURL),
//              let html = String.init(data: data, encoding: .utf8),
//              let re = try? NSRegularExpression.init(pattern: "window._sharedData[\\s*]=([\\s\\S]*?);", options: []),
//              let result = re.firstMatch(in: html, options: .reportCompletion, range: html.rangeOfAll),
//              result.numberOfRanges > 1,
//              let jsonData = (html as NSString).substring(with: result.range(at: 1)).data(using: .utf8),
//              let jsonDict = (try? JSONSerialization.jsonObject(with: jsonData, options: [])) as? [String:Any],
//              let videoinfo = searchVideoURLAndDisplayURLs(on:jsonDict)?.first,
//              videoinfo.count > 0
//        else { return nil }
//
//        let info = TangVideoInfo()
//        info.from = .instagram
//        info.thumbnail = videoinfo.count>1 ? videoinfo[1] : ""
//        info.filmstrip = nil
//        info.filmstripWidth = nil
//        info.filmstripHeight = nil
//        info.duration = nil
//        info.source = videoinfo.first!
//        info.type = (info.source as NSString).pathExtension
//        info.video = info.source
//        return info
        
        return nil
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
