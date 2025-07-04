//
//  QuoteViewModelTests.swift
//  QuoteApp
//
//  Created by mohammad Jakir on 04/07/25.
//

import XCTest
@testable import QuoteApp

struct MockQuoteService: QuoteFetching {
    var quoteToReturn: Quote?
    var errorToThrow: Error?
    
    func fetchRandomQuote() async throws -> Quote {
        if let err = errorToThrow { throw err }
        return quoteToReturn!
    }
}

@MainActor
class QuoteViewModelTests: XCTestCase {
    func testLoadQuote_success() async {
        let mock = MockQuoteService(quoteToReturn: Quote(q: "Test", a: "Author"))
        let vm = QuoteViewModel(service: mock)
        await vm.loadQuote()
        XCTAssertEqual(vm.quote?.q, "Test")
        XCTAssertNil(vm.errorMessage)
        XCTAssertFalse(vm.isLoading)
    }
    
    func testLoadQuote_failure() async {
        let mock = MockQuoteService(errorToThrow: URLError(.notConnectedToInternet))
        let vm = QuoteViewModel(service: mock)
        await vm.loadQuote()
        XCTAssertNotNil(vm.errorMessage)
        XCTAssertFalse(vm.isLoading)
    }
}
