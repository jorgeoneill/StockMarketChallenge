//
//  Endpoint.swift
//  StockMarketChallenge
//
//  Created by Jorge O'Neill on 18/10/2023.
//

import Foundation

struct Endpoints {
    static func latestData(for symbol: String) -> URL? {
        let queryItems = [
            URLQueryItem(
                name: Constants.API.URL.QueryItems.accessKey,
                value: Constants.API.URL.accessKeyValue
            ),
            URLQueryItem(
                name: Constants.API.URL.QueryItems.symbols,
                value: symbol
            )
        ]
        var components = URLComponents()
        components.scheme = Constants.API.URL.scheme
        components.host = Constants.API.URL.host
        components.path = Constants.API.URL.endOfDayLatestPath
        components.queryItems = queryItems

        return components.url
    }

    static func historicalData(for symbol: String, from startingDate: Date? = nil) -> URL? {
        var queryItems = [
            URLQueryItem(
                name: Constants.API.URL.QueryItems.accessKey,
                value: Constants.API.URL.accessKeyValue
            ),
            URLQueryItem(
                name: Constants.API.URL.QueryItems.symbols,
                value: symbol
            ),
        ]

        if let startingDate {
            queryItems.append(URLQueryItem(
                name: Constants.API.URL.QueryItems.dateFrom,
                value: Formatters.yearMonthDayString(from: startingDate))
            )
        }

        var components = URLComponents()
        components.scheme = Constants.API.URL.scheme
        components.host = Constants.API.URL.host
        components.path = Constants.API.URL.endOfDayHistoricalPath
        components.queryItems = queryItems

        return components.url
    }

    static func tickers() -> URL? {
        let queryItems = [
            URLQueryItem(
                name: Constants.API.URL.QueryItems.accessKey,
                value: Constants.API.URL.accessKeyValue
            )
        ]

        var components = URLComponents()
        components.scheme = Constants.API.URL.scheme
        components.host = Constants.API.URL.host
        components.path = Constants.API.URL.tickersPath
        components.queryItems = queryItems

        return components.url
    }

}
