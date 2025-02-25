@testable import muterCore
import SwiftParser
import TestingExtensions
import XCTest

final class PrepareSourceCodeTests: MuterTestCase {
    private lazy var outputFilePath = fixturesDirectory + "/preparedSourceCode.swift"

    override func setUpWithError() throws {
        try super.setUpWithError()

        let contents = """
        func foo() {
            true && false
        }
        """.data(using: .utf8)

        FileManager.default.createFile(
            atPath: outputFilePath,
            contents: contents
        )
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()

        try FileManager.default.removeItem(atPath: outputFilePath)
    }

    func test_prepareSourceCode() throws {
        let sut = try XCTUnwrap(PrepareSourceCode().prepareSourceCode(outputFilePath))

        AssertSnapshot(sut.source.code.description)
    }
}
