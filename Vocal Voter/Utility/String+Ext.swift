//
//  String+ExtViewController.swift
//  Vocal Voter
//
//  Created by Mobdev125 on 9/13/18.
//  Copyright © 2018 Mobdev125. All rights reserved.
//

import CryptoSwift

extension String {
    func password() -> String {
        let md5 = self.md5()
        guard let encodedString = md5.data(using: .utf8)?.base64EncodedString() else {
            return md5
        }
        return encodedString
    }
    
    static func generateBlobName(prefix: String, subfix: String) -> String {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return "\(dateFormatter.string(from: now))/\(prefix)_\(subfix)_\(now.timeIntervalSince1970).jpg"
    }
}
