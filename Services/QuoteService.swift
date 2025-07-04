//
//  QuoteService.swift
//  QuoteApp
//
//  Created by mohammad Jakir on 04/07/25.
//
import Foundation

protocol QuoteFetching {
    func fetchRandomQuote() async throws -> Quote
}

final class QuoteService: QuoteFetching {
    private let session: URLSession
    private let baseURL = URL(string: "https://zenquotes.io/api/random")!
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchRandomQuote() async throws -> Quote {
        let (data, resp) = try await session.data(from: baseURL)
        guard let http = resp as? HTTPURLResponse, http.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        let decoded = try JSONDecoder().decode([Quote].self, from: data)
        guard let first = decoded.first else {
            throw URLError(.cannotDecodeContentData)
        }
        return first
    }
}
