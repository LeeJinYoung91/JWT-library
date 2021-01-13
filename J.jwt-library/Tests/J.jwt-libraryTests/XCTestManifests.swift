import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(J_jwt_libraryTests.allTests),
    ]
}
#endif
