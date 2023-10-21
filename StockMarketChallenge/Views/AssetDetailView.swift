//
//  DetailView.swift
//  StockMarketChallenge
//
//  Created by Jorge O'Neill on 18/10/2023.
//

import SwiftUI
import Charts

struct AssetDetailView: View {
    @StateObject var viewModel: ViewModel

    var body: some View {
        VStack {
            Text(viewModel.assetTitle).font(.largeTitle)
                .multilineTextAlignment(.center)
                .bold()

            Text(viewModel.assetSubtitle)
                .multilineTextAlignment(.center)

            HStack {
                Text(viewModel.closingPricLabel)
                    .bold()
                Text(viewModel.closingPriceValue)
                Spacer()
                Text("|")
                Spacer()
                Text(viewModel.closingDateValue)
            }
            .padding(
                [.vertical],
                Constants.UI.Layout.Dimensions.verticalPadding
            )

            Chart {
                ForEach(viewModel.selectedHistoricalDataItems) { dataItem in
                    LineMark(
                        x: .value(
                            Constants.UI.Labels.Titles.chartXLabel,
                            dataItem.date
                        ),
                        y: .value(
                            Constants.UI.Labels.Titles.chartYLabel,
                            dataItem.adjustedClosingPrice
                        )
                    )
                }
            }
            .chartYScale(
                domain: .automatic(
                    includesZero: false)
            )
            .padding(
                [.vertical],
                Constants.UI.Layout.Dimensions.verticalPadding
            )

            HStack {
                if let fromDatePickerViewModel = viewModel.fromDatePickerViewModel {
                    DatePickerView(
                        viewModel: DatePickerView.ViewModel(
                            type: fromDatePickerViewModel.type,
                            startDate: fromDatePickerViewModel.startDate,
                            endDate: fromDatePickerViewModel.endDate), selectedDate: $viewModel.selectedStartDate
                    )
                }

                Spacer()

                if let toDatePickerViewModel = viewModel.toDatePickerViewModel {
                    DatePickerView(viewModel: DatePickerView.ViewModel(
                        type: toDatePickerViewModel.type,
                        startDate: toDatePickerViewModel.startDate,
                        endDate: toDatePickerViewModel.endDate), selectedDate: $viewModel.selectedEndDate
                    )
                }
            }
        }
        .padding(
            [.leading, .trailing, .bottom],
            Constants.UI.Layout.Dimensions.outsidePadding
        )
    }
}

#Preview {
    NavigationStack {
        AssetDetailView(viewModel: AssetDetailView.ViewModel(ticker: Models.TickerData(
            symbol: "AAPL",
            name: "Apple")
        ))
        .navigationTitle(Constants.UI.Labels.Titles.navigationTitle)
    }
}
