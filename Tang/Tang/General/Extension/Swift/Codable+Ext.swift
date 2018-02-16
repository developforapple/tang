//
//  Codable+Ext.swift
//  Tang
//
//  Created by Tiny on 2018/2/8.
//  Copyright © 2018年 tiny. All rights reserved.
//

import UIKit

private let DefaultJSONDecoder : JSONDecoder = {
    let decoder = JSONDecoder.init()
    decoder.dateDecodingStrategy = .secondsSince1970
    decoder.dataDecodingStrategy = .deferredToData
    return decoder
}()
private let DefaultJSONEncoder : JSONEncoder = {
    let encoder = JSONEncoder.init()
    encoder.dateEncodingStrategy = .secondsSince1970
    encoder.dataEncodingStrategy = .deferredToData
    return encoder
}()

extension Decodable {
    static func fromJson(_ data : Data) -> Self? {
        do {
            return try DefaultJSONDecoder.decode(self, from: data)
        }catch {
            print("Decode json data failed. Error : ", error)
            return nil
        }
    }
}

extension Encodable {
    func toJson() -> Data? {
        do {
            return try DefaultJSONEncoder.encode(self)
        }catch {
            print("Encode object to json data failed. Error : ", error)
            return nil
        }
    }
}
