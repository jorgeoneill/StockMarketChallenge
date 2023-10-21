//
//  AlertView.swift
//  StockMarketChallenge
//
//  Created by Jorge O'Neill on 21/10/2023.
//

import SwiftUI

struct AlertView: View {
    @StateObject var viewModel: ViewModel

    var body: some View {
        VStack {
            Spacer()
            Text(viewModel.title).font(.title)
                .bold()
                .padding([.vertical], Constants.UI.Layout.Dimensions.verticalPadding)
                .multilineTextAlignment(.center)
            Text(viewModel.description)
                .font(.title3)
                .multilineTextAlignment(.center)
            Spacer()
            HStack {
                Button(viewModel.primaryButtonTitle) {
                    viewModel.primaryButtonAction()
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)

                if
                    let secondaryButtonTitle = viewModel.secondaryButtonTitle,
                    let secondaryButtonAction = viewModel.secondaryButtonAction {
                    Spacer()
                    Button(secondaryButtonTitle) {
                        secondaryButtonAction()
                    }
                    .buttonStyle(.bordered)
                    .controlSize(.large)

                }
            }
        }
        .padding(Constants.UI.Layout.Dimensions.outsidePadding)
    }
}

#Preview {
    AlertView(
        viewModel: AlertView.ViewModel(
            title: Constants.UI.Labels.DefaultValues.alertTitle,
            description: Constants.UI.Labels.DefaultValues.alertDescription,
            primaryButtonTitle: Constants.UI.Labels.DefaultValues.alertPrimaryButtonTitle,
            primaryButtonAction: {
                print("Primary button pressed")
            },
            secondaryButtonTitle: Constants.UI.Labels.DefaultValues.alertSecondaryButtonTitle,
            secondaryButtonAction: {
                print("Secondary button pressed")
            }
        ))
}
