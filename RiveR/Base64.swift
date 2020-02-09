//
//  Base64.swift
//  RiveR
//
//  Created by Duoy on 2020/2/9.
//  Copyright © 2020 雲の祈り. All rights reserved.
//
import Foundation

extension String {
    // base64编码
    func toBase64() -> String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }

    // base64解码
    func fromBase64() -> String? {
        if let decodedData = NSData(base64Encoded: self, options: .ignoreUnknownCharacters){
            return NSString(data: decodedData as Data, encoding: String.Encoding.utf8.rawValue) as String?
        }
        return nil
    }
}
