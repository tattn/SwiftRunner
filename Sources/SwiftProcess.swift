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

    fileprivate let process = Process()
    fileprivate let pipes: (output: Pipe, error: Pipe) = (Pipe(), Pipe())

    init(swiftPath: String = "/usr/bin/swift") {
        process.launchPath = swiftPath

        process.standardOutput = pipes.output
        process.standardError  = pipes.error
    }

    public func launch(file filename: String) -> Result<StandardStream, SwiftRunnerError> {
        process.arguments  = ["run", "./" + filename]
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
