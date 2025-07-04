//
//  Quate.swift
//  QuoteApp
//
//  Created by mohammad Jakir on 04/07/25.
//
import Foundation

struct Quote: Identifiable, Codable {
    let id = UUID()
    let q: String
    let a: String
    
    enum CodingKeys: String, CodingKey {
        case q, a
    }
}
