//
//  Formatters.swift
//  StockMarketChallenge
//
//  Created by Jorge O'Neill on 18/10/2023.
//

import Foundation

struct Formatters {
    // MARK: Date
    static func yearMonthDayString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        return formatter.string(from: date)
    }

    static func shortDateString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium

        return formatter.string(from: date)
    }

    static func date(from string: String) -> Date? {
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: string)
    }

    // MARK: Currency

    static func usDollarCurrencyString(from value: Float) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale(identifier: "en_US")

        return formatter.string(from: NSNumber(value: value))
    }

}
