//
//  Constants.swift
//  StockMarketChallenge
//
//  Created by Jorge O'Neill on 18/10/2023.
//

import Foundation

enum Constants {
    enum API {
        enum URL {
            static let accessKeyValue = "a7d874539227c571b304e3e1a1ff3f45"
            static let endOfDayLatestPath = "/v1/eod/latest"
            static let endOfDayHistoricalPath = "/v1/eod"
            static let tickersPath = "/v1/tickers"
            static let scheme = "http"
            static let host = "api.marketstack.com"

            enum QueryItems {
                static let accessKey = "access_key"
                static let symbols = "symbols"
                static let dateFrom = "date_from"
            }
        }
    }

    enum UI {
        enum Labels {
            enum Titles {
                static let navigationTitle = "Stocks"
                static let closingPrice = "Closing Price:"
                static let chartXLabel = "Date"
                static let chartYLabel = "Price"
                static let searchPrompt = "Stock name"
            }

            enum DefaultValues {
                static let closingPrice = "ND"
                static let closingDate = "ND"
                static let alertTitle = "Oops!"
                static let alertDescription = "There seems to be a problem"
                static let alertPrimaryButtonTitle = "Ok"
                static let alertSecondaryButtonTitle = "Cancel"
                static let alertButtonTitleRetry = "Retry"
            }

            enum Errors {
                static let invalidURL = "Data Service URL is incorrect"
                static let invalidServerResponse = "Invalid response received from Data Service"
                static let emptyResponse = "Data Service returned an empty response"
            }
        }

        enum Layout {
            enum Dimensions {
                static let outsidePadding: CGFloat = 36
                static let verticalPadding: CGFloat = 18
                static let horizontalPadding: CGFloat = 18
            }
        }
    }
}
