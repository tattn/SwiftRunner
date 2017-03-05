import Foundation
import Result

public class SwiftRunner {
    public static let shared = SwiftRunner()

    public var swiftPath = "/usr/bin/swift"
    
    public func launchSwift(string: String) -> Result<StandardStream, SwiftRunnerError> {
        guard let temporaryFile = try? TemporaryFile(text: string) else {
            return .failure(.cannotCreateTemporaryFile)
        }
        
        let result = SwiftProcess(swiftPath: swiftPath).launch(file: temporaryFile.filepath)
        
        if case .success(let stream) = result {
            let stderr = stream.error.replacingOccurrences(of: temporaryFile.filepath, with: "")
            return .success(StandardStream(output: stream.output, error: stderr))
        }
        
        return result
    }
}
