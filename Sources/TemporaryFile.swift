//
//  TemporaryFile.swift
//  SwiftRunner
//
//  Created by Tatsuya Tanaka on 2017/03/05.
//
//

import Foundation

class TemporaryFile {
    let path: URL
    
    init(text: String) throws {
        let directoryURL = try createTemporaryDirectory()

        let fileName = createUniqueName()
        path = directoryURL.appendingPathComponent(fileName)

        try text.write(to: path, atomically: true, encoding: .utf8)
    }

    deinit {
        try? FileManager.default.removeItem(at: path)
    }
}

private func createTemporaryDirectory() throws -> URL {
    let directoryURL = URL(fileURLWithPath: NSTemporaryDirectory())
        .appendingPathComponent(ProcessInfo.processInfo.globallyUniqueString, isDirectory: true)

    try FileManager.default.createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)

    return directoryURL
}

private func createUniqueName() -> String {
    let uniqueName = Date().timeIntervalSince1970.description.replacingOccurrences(of: ".", with: "")
    return "\(ProcessInfo.processInfo.globallyUniqueString)_\(uniqueName)"
}
