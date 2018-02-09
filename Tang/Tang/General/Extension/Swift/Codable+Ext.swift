//
//  Codable+Ext.swift
//  Tang
//
//  Created by Tiny on 2018/2/8.
//  Copyright © 2018年 tiny. All rights reserved.
//

import UIKit

extension Decodable {
    static func fromJson(_ data : Data) -> Self? {
        do {
            return try JSONDecoder.init().decode(self, from: data)
        }catch {
            print("Decode json data failed. Error : ", error)
            return nil
        }
    }
}

extension Encodable {
    func toJson() -> Data? {
        do {
            return try JSONEncoder.init().encode(self)
        }catch {
            print("Encode object to json data failed. Error : ", error)
            return nil
        }
    }
}
