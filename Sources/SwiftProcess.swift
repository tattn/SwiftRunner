//
//  SwiftProcess.swift
//  SwiftRunner
//
//  Created by Tatsuya Tanaka on 2017/03/05.
//
//

import Foundation
import Result

public class SwiftProcess {

    #if os(Linux)
    // see: http://stackoverflow.com/questions/39764801/how-to-use-process-in-swift-3-for-linux
    fileprivate let process = Task()
    #else
    fileprivate let process = Process()
    #endif
    fileprivate let pipes: (output: Pipe, error: Pipe) = (Pipe(), Pipe())

    init(swiftPath: String = "/usr/bin/swift") {
        process.launchPath = swiftPath

        process.standardOutput = pipes.output
        process.standardError  = pipes.error
    }

    public func launch(at path: URL) -> Result<StandardStream, SwiftRunnerError> {
        let absolutePath = path.absoluteString.replacingOccurrences(of: "file://", with: "")
        return launch(atFile: absolutePath)
    }

    public func launch(atFile path: String) -> Result<StandardStream, SwiftRunnerError> {
        process.arguments  = ["run", path]
        process.launch()

        let outputData = pipes.output.fileHandleForReading.readDataToEndOfFile()
        let errorData  = pipes.error.fileHandleForReading.readDataToEndOfFile()

        if let output = String(data: outputData, encoding: .utf8),
            let error = String(data: errorData, encoding: .utf8) {

            let stream = StandardStream(output: output, error: error)
            return .success(stream)
        }

        return .failure(SwiftRunnerError.unexpected)
    }
}
