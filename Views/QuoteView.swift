//
//  QuoteView.swift
//  QuoteApp
//
//  Created by mohammad Jakir on 04/07/25.
//

import SwiftUI

struct QuoteView: View {
    @StateObject var vm = QuoteViewModel()
    
    var body: some View {
        VStack(spacing: 24) {
            if vm.isLoading {
                ProgressView("Thanks For Your Patience Fetching data...")
            } else if let error = vm.errorMessage {
                Text("Error: \(error)").foregroundColor(.blue)
                retryButton
            } else if let q = vm.quote {
                Text("“\(q.q)”")
                    .font(.title)
                    .multilineTextAlignment(.center)
                Text("— \(q.a)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                retryButton
            } else {
                retryButton
            }
        }
        .padding()
        .task {
            await vm.loadQuote()
        }
    }
    
    private var retryButton: some View {
        Button("Refresh Quote") {
            Task {
                await vm.loadQuote()
            }
        }
        .buttonStyle(.borderedProminent)
    }
}

struct QuoteView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteView()
    }
}
