//
//  DatePickerView+ViewModel.swift
//  StockMarketChallenge
//
//  Created by Jorge O'Neill on 20/10/2023.
//

import Foundation

extension DatePickerView {
    @MainActor class ViewModel: ObservableObject {
        let type: Models.DatePickerType
        @Published var startDate: Date
        @Published var endDate: Date

        var label: String {
            return type == .to ? "To:" : "From:"
        }

        init(type: Models.DatePickerType,
             startDate: Date,
             endDate: Date
        ) {
            self.type = type
            self.startDate = startDate
            self.endDate = endDate
        }
    }
}
