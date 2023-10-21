//
//  CellView+ViewModel.swift
//  StockMarketChallenge
//
//  Created by Jorge O'Neill on 19/10/2023.
//

import Foundation

extension TickerCellView {
    @MainActor class ViewModel: ObservableObject {
        @Published private(set) var title: String

        init(ticker: Models.TickerData) {
            title = ("\(ticker.name) (\(ticker.symbol))")
        }

    }
}
