//
//  TemporaryFile.swift
//  SwiftRunner
//
//  Created by Tatsuya Tanaka on 2017/03/05.
//
//

import Foundation

class TemporaryFile {
    let filepath: String
    
    init(text: String) throws {
        filepath = "./" + Date().timeIntervalSince1970.description.replacingOccurrences(of: ".", with: "")
        try text.write(toFile: filepath, atomically: true, encoding: .utf8)
    }
    
    deinit {
        try? FileManager.default.removeItem(atPath: filepath)
    }
}
