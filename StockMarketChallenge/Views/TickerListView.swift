//
//  TickerListView.swift
//  StockMarketChallenge
//
//  Created by Jorge O'Neill on 19/10/2023.
//

import SwiftUI

struct TickerListView: View {
    @StateObject private var viewModel = ViewModel()
    @State private var searchTerm: String = ""
    @State private var isAlertVisible = false

    var body: some View {
        NavigationStack {
            List(viewModel.filteredTickerList) { ticker in
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
            .searchable(
                text: $searchTerm,
                prompt: Constants.UI.Labels.Titles.searchPrompt
            )
            .onChange(of: searchTerm, { _, newValue in
                let trimmedTerm = newValue.trimmingCharacters(in: .whitespaces)
                viewModel.filterValues(by: trimmedTerm)
            })
            .task {
                do {
                    try await viewModel.updateTickerList()
                } catch Models.NetworkError.emptyResponse {
                    viewModel.alertDescription = Constants.UI.Labels.Errors.emptyResponse
                    isAlertVisible = true
                } catch Models.NetworkError.invalidServerResponse {
                    viewModel.alertDescription = Constants.UI.Labels.Errors.invalidServerResponse
                    isAlertVisible = true
                } catch Models.NetworkError.invalidURL {
                    viewModel.alertDescription = Constants.UI.Labels.Errors.invalidURL
                    isAlertVisible = true
                } catch {
                    viewModel.alertDescription = error.localizedDescription
                    isAlertVisible = true
                }
            }
            .sheet(isPresented: $isAlertVisible) {
                let alerViewViewModel = AlertView.ViewModel(
                    description: viewModel.alertDescription,
                    primaryButtonTitle: Constants.UI.Labels.DefaultValues.alertButtonTitleRetry,
                    primaryButtonAction: {
                        Task {
                            do {
                                try await viewModel.updateTickerList()
                                isAlertVisible = false
                            }
                            catch {
                                isAlertVisible = true
                            }
                        }
                    },
                    secondaryButtonTitle: Constants.UI.Labels.DefaultValues.alertSecondaryButtonTitle,
                    secondaryButtonAction: {
                        isAlertVisible = false
                    }
                )
                AlertView(viewModel: alerViewViewModel)
            }
        }
    }
}
