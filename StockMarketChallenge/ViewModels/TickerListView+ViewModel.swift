//
//  TickerListViewModel.swift
//  StockMarketChallenge
//
//  Created by Jorge O'Neill on 19/10/2023.
//

import Foundation

extension TickerListView {
    @MainActor class ViewModel: ObservableObject {
        @Published private(set) var tickerList: [Models.TickerData] = [Models.TickerData]()

        func updateTickerList() throws {
            Task {
                do {
                    let fetchedTickers = try await DataService.fetchTickers()
                    tickerList = fetchedTickers.data
                }
                catch {
                    print("[TickerListView.ViewModel] updateTickerList error: \(error)")
                    throw error
                }
            }
        }
    }
}
