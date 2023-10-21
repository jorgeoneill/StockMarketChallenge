//
//  TickerListViewModel.swift
//  StockMarketChallenge
//
//  Created by Jorge O'Neill on 19/10/2023.
//

import Foundation

extension TickerListView {
    @MainActor class ViewModel: ObservableObject {
        @Published private(set) var filteredTickerList: [Models.TickerData] = [Models.TickerData]()
        var alertDescription = ""
        private var tickerList: [Models.TickerData] = [Models.TickerData]() {
            didSet {
                filterValues(by: "")
            }
        }

        func filterValues(by searchTerm: String) {
            guard !searchTerm.isEmpty else {
                filteredTickerList = tickerList
                return
            }

            let resultList = tickerList.filter( { $0.name.localizedCaseInsensitiveContains(searchTerm)} )
            filteredTickerList = resultList.sorted(by: { $0.name < $1.name } )
        }


        func updateTickerList() async throws {
            guard tickerList.isEmpty else { return }

            let fetchedTickers = try await DataService.fetchTickers()
            tickerList = fetchedTickers.data.sorted(by: { $0.name < $1.name } )
            filteredTickerList = tickerList
        }
    }
}
