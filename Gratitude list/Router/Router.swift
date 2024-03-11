//
//  Router.swift
//  Gratitude list
//
//  Created by Goga Eusebiu on 11.03.2024.
//

import SwiftUI

enum Route: Hashable {
    case gratitudeList
    case gratitudeDetail(UUID)
    case addGratitude
}

class Router: ObservableObject {
    @Published var path = NavigationPath()

    @ViewBuilder
    func view(for route: Route) -> some View {
        switch route {
        case .gratitudeList:
            GratitudeListView(viewModel: GratitudeListViewModel())
        case .gratitudeDetail(let gratitudeId):
            GratitudeDetailView(viewModel: GratitudeDetailViewModel(gratitudeId: gratitudeId))
        case .addGratitude:
            AddGratitudeView(viewModel: AddGratitudeViewModel())
        }
    }

    func navigateTo(_ route: Route) {
        path.append(route)
    }

    func pop() {
        path.removeLast()
    }

    func popToRoot() {
        path.removeLast(path.count)
    }
}
