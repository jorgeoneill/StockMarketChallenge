//
//  DatePickerView.swift
//  StockMarketChallenge
//
//  Created by Jorge O'Neill on 20/10/2023.
//

import SwiftUI

struct DatePickerView: View {
    @StateObject var viewModel: ViewModel
    @Binding var selectedDate: Date

    var body: some View {
        VStack {
            Text(viewModel.label).bold()
            DatePicker(
                viewModel.label,
                selection: $selectedDate ,
                in: viewModel.startDate...viewModel.endDate,
                displayedComponents: .date
            )
            .datePickerStyle(.compact)
            .labelsHidden()

        }
    }
}
