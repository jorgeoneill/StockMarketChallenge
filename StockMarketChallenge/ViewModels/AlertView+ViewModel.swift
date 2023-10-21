//
//  AlertView+ViewModel.swift
//  StockMarketChallenge
//
//  Created by Jorge O'Neill on 21/10/2023.
//

import Foundation

extension AlertView {
    @MainActor class ViewModel: ObservableObject {
        @Published private(set) var title: String
        @Published private(set) var description: String
        @Published private(set) var primaryButtonTitle: String
        @Published private(set) var primaryButtonAction: () -> ()
        @Published private(set) var secondaryButtonTitle: String?
        @Published private(set) var secondaryButtonAction: (() -> ())?

        init(
            title: String = Constants.UI.Labels.DefaultValues.alertTitle,
            description: String = Constants.UI.Labels.DefaultValues.alertDescription,
            primaryButtonTitle: String = Constants.UI.Labels.DefaultValues.alertPrimaryButtonTitle,
            primaryButtonAction: @escaping () -> Void,
            secondaryButtonTitle: String? = nil,
            secondaryButtonAction: (() -> ())? = nil
        ) {
            self.title = title
            self.description = description
            self.primaryButtonTitle = primaryButtonTitle
            self.primaryButtonAction = primaryButtonAction
            self.secondaryButtonTitle = secondaryButtonTitle
            self.secondaryButtonAction = secondaryButtonAction
        }

    }
}
