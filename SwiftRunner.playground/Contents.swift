//: Playground - noun: a place where people can play

import Cocoa
import SwiftRunner

let text   = "print(\"hello!\")"
let result = SwiftRunner.shared.launch(string: text) // => hello!

switch result {
case .success(let stream):
    stream.output // => "hello!\n"

case .failure(let error): break
}
