//
//  Models.swift
//  StockMarketChallenge
//
//  Created by Jorge O'Neill on 18/10/2023.
//

import Foundation

struct Models {
    struct AssetData: Decodable, Identifiable {
        let id = UUID()
        let symbol: String
        let adjustedClosingPrice: Float
        let date: Date

        enum CodingKeys: String, CodingKey {
            case symbol
            case adjustedClosingPrice = "adj_close"
            case date
        }

        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
            symbol = try container.decode(
                String.self,
                forKey: CodingKeys.symbol
            )
            adjustedClosingPrice = try container.decode(
                Float.self,
                forKey: CodingKeys.adjustedClosingPrice
            )
            let dateString = try container.decode(
                String.self,
                forKey: CodingKeys.date
            )
            date = Formatters.date(from: dateString) ?? .now
        }
    }

    struct Assets: Decodable {
        var data: [Models.AssetData]
    }

    struct TickerData: Decodable, Identifiable, Hashable {
        let id = UUID()
        let symbol: String
        let name: String
    }

    struct Tickers: Decodable {
        var data: [Models.TickerData]
    }

    enum NetworkError: Error {
        case invalidURL
        case invalidServerResponse
        case emptyResponse
    }

    public enum DatePickerType {
        case from
        case to
    }
}
