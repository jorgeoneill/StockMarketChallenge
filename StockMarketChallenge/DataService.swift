//
//  DataService.swift
//  StockMarketChallenge
//
//  Created by Jorge O'Neill on 18/10/2023.
//

import Foundation

class DataService {
    static func fetchHistoricalAssetData(
        for symbol: String,
        from initialDate: Date? = nil
    ) async throws -> [Models.AssetData] {
        guard let url = Endpoints.historicalData(
            for: symbol,
            from: initialDate
        )
        else {
            throw Models.NetworkError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard
            let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200
        else {
            throw Models.NetworkError.invalidServerResponse
        }

        let historicalDataItems = try JSONDecoder().decode(
            Models.Assets.self,
            from: data
        ).data

        return historicalDataItems
    }

    static func fetchLatestAssetData(for symbol: String) async throws -> Models.AssetData {
        guard let url = Endpoints.latestData(for: symbol) else {
            throw Models.NetworkError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard
            let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200
        else {
            throw Models.NetworkError.invalidServerResponse
        }

        let latestData = try JSONDecoder().decode(
            Models.Assets.self,
            from: data
        )

        guard let latestDataItem = latestData.data.first else {
            throw Models.NetworkError.emptyResponse
        }

        return latestDataItem
    }

    static func fetchTickers() async throws -> Models.Tickers {
        guard let url = Endpoints.tickers() else {
            throw Models.NetworkError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard
            let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200
        else {
            throw Models.NetworkError.invalidServerResponse
        }

        let tickers = try JSONDecoder().decode(
            Models.Tickers.self,
            from: data
        )
        return tickers
    }
}
