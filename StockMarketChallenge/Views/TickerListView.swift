//
//  TickerListView.swift
//  StockMarketChallenge
//
//  Created by Jorge O'Neill on 19/10/2023.
//

import SwiftUI

struct TickerListView: View {
    @StateObject private var viewModel = ViewModel()

    var body: some View {
        NavigationStack {
            List(viewModel.tickerList) { ticker in
                NavigationLink(value: ticker) {
                    let tickerCellViewModel = TickerCellView.ViewModel(ticker: ticker)
                    TickerCellView(viewModel: tickerCellViewModel)
                }
            }
            .navigationDestination(for: Models.TickerData.self, destination: { ticker in
                let assetDetailViewModel = AssetDetailView.ViewModel(ticker: ticker)
                AssetDetailView(viewModel: assetDetailViewModel)
            })
            .navigationTitle(Constants.UI.Labels.Titles.navigationTitle)
            .onAppear {
                do {
                    try viewModel.updateTickerList()
                }
                catch {
                    print("[TickerListView] updateTickerList error: \(error)")
                }
            }
        }
    }
}
