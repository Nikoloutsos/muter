import Foundation

struct ApplySchemata: RunCommandStep {
    @Dependency(\.writeFile)
    private var writeFile: WriteFile
    @Dependency(\.notificationCenter)
    private var notificationCenter: NotificationCenter

    func run(
        with state: AnyRunCommandState
    ) async throws -> [RunCommandState.Change] {
        for mutationMap in state.mutationMapping {
            guard let sourceCode = state.sourceCodeByFilePath[mutationMap.filePath] else {
                // TODO: log?
                continue
            }

            let rewriter = MuterRewriter(mutationMap)

            let newFile = rewriter.visit(sourceCode)

            do {
                try writeFile(
                    newFile.description,
                    mutationMap.filePath
                )
            } catch {
                throw MuterError.literal(reason: error.localizedDescription)
            }
        }

        return []
    }
}
