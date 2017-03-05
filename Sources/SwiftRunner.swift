import Foundation
import Result

public class SwiftRunner {
    public static let shared = SwiftRunner()

    public var swiftPath = "/usr/bin/swift"
    
    public func launch(string: String) -> Result<StandardStream, SwiftRunnerError> {
        let temporaryFile: TemporaryFile
        do {
            temporaryFile = try TemporaryFile(text: string)
        } catch {
            return .failure(.cannotCreateTemporaryFile(error))
        }

        let result = SwiftProcess(swiftPath: swiftPath).launch(at: temporaryFile.path)
        
        if case .success(let stream) = result {
            let stderr = stream.error.replacingOccurrences(of: temporaryFile.path.relativePath, with: "")
            return .success(StandardStream(output: stream.output, error: stderr))
        }
        
        return result
    }
}
