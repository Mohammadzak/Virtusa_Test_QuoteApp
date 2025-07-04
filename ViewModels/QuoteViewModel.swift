//
//  QuoteViewModel.swift
//  QuoteApp
//
//  Created by mohammad Jakir on 04/07/25.
//
import Foundation

@MainActor
final class QuoteViewModel: ObservableObject {
    @Published private(set) var quote: Quote?
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?
    
    private let service: QuoteFetching
    
    init(service: QuoteFetching = QuoteService()) {
        self.service = service
    }
    
    func loadQuote() async {
        isLoading = true
        errorMessage = nil
        do {
            let newQuote = try await service.fetchRandomQuote()
            quote = newQuote
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
