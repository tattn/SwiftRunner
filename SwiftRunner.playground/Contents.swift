//: Playground - noun: a place where people can play

import Cocoa
import SwiftRunner

let text   = "print(\"hello!\")"
let result = SwiftRunner.shared.run(string: text)

switch result {
case .success(let stream):
    stream.output // => "hello!\n"

case .failure(let error): break
}
