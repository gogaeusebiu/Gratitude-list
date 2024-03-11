//
//  Gratitude_listApp.swift
//  Gratitude list
//
//  Created by Goga Eusebiu on 11.03.2024.
//

import SwiftUI

@main
struct Gratitude_listApp: App {
    var body: some Scene {
        WindowGroup {
            RouterView {
                GratitudeListView(viewModel: GratitudeListViewModel())
            }
        }
    }
}
