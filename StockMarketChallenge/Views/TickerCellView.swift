//
//  CellView.swift
//  StockMarketChallenge
//
//  Created by Jorge O'Neill on 18/10/2023.
//

import SwiftUI

struct TickerCellView: View {
    @StateObject var viewModel: ViewModel

    var body: some View {
        Text(viewModel.title)
    }
}
