//
//  DetailView+ViewModel.swift
//  StockMarketChallenge
//
//  Created by Jorge O'Neill on 19/10/2023.
//

import Foundation

import Foundation

extension AssetDetailView {
    @MainActor class ViewModel: ObservableObject {
        @Published private(set) var assetTitle: String
        @Published private(set) var assetSubtitle: String
        @Published private(set) var closingPricLabel: String
        @Published private(set) var closingPriceValue: String
        @Published private(set) var closingDateValue: String
        @Published private(set) var fromDatePickerViewModel: DatePickerView.ViewModel?
        @Published private(set) var toDatePickerViewModel: DatePickerView.ViewModel?
        @Published private(set) var historicalDataItems: [Models.AssetData]
        @Published private(set) var selectedHistoricalDataItems: [Models.AssetData]
        var alertDescription = ""
        private var tickerSymbol = ""

        @Published var selectedStartDate: Date {
            didSet {
                filterHistoricalDataBySelectedPeriod()
            }
        }
        @Published var selectedEndDate: Date {
            didSet {
                filterHistoricalDataBySelectedPeriod()
            }
        }

        init(ticker: Models.TickerData) {
            tickerSymbol = ticker.symbol
            assetTitle = ticker.name
            assetSubtitle = ticker.symbol
            closingPricLabel = Constants.UI.Labels.Titles.closingPrice
            closingPriceValue = Constants.UI.Labels.DefaultValues.closingDate
            closingDateValue = Constants.UI.Labels.DefaultValues.closingDate
            selectedStartDate = .distantPast
            selectedEndDate = .now
            historicalDataItems = []
            selectedHistoricalDataItems = []
        }

        func updateWithLatestAssetData() async throws {
            let assetData = try await DataService.fetchLatestAssetData(for: tickerSymbol)
            assetSubtitle = assetData.symbol
            closingPriceValue = String(Formatters.usDollarCurrencyString(from: assetData.adjustedClosingPrice) ?? Constants.UI.Labels.DefaultValues.closingPrice)
        }

        func updateWithHistoricalAssetData() async throws {
            let fetchedHistoricalDataItems = try await DataService.fetchHistoricalAssetData(for: tickerSymbol)
            let sortedHistoricalDataItems = fetchedHistoricalDataItems.sorted { $0.date < $1.date }
            historicalDataItems = sortedHistoricalDataItems
            selectedHistoricalDataItems = historicalDataItems
            let startDate = historicalDataItems.first?.date ?? .distantPast
            let endDate = historicalDataItems.last?.date ?? .now
            closingDateValue = Formatters.shortDateString(from: endDate)
            selectedStartDate = startDate
            selectedEndDate = endDate
            fromDatePickerViewModel = DatePickerView.ViewModel(
                type: .from,
                startDate: selectedStartDate,
                endDate: selectedEndDate
            )

            toDatePickerViewModel = DatePickerView.ViewModel(
                type: .to,
                startDate: selectedStartDate,
                endDate: selectedEndDate
            )
        }

        func filterHistoricalDataBySelectedPeriod() {
            selectedHistoricalDataItems = historicalDataItems.filter { $0.date > selectedStartDate && $0.date < selectedEndDate }
        }

    }
}
