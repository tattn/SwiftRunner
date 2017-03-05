//
//  Errors.swift
//  SwiftRunner
//
//  Created by Tatsuya Tanaka on 2017/03/05.
//
//

import Foundation

public enum SwiftRunnerError: Swift.Error {
    case cannotCreateTemporaryFile(Swift.Error)
    case unexpected
}
