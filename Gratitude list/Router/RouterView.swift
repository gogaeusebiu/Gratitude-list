//
//  RouterView.swift
//  Gratitude list
//
//  Created by Goga Eusebiu on 11.03.2024.
//

import SwiftUI

struct RouterView<Content: View>: View {
    @StateObject var router = Router()
    
    private let content: Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationStack(path: $router.path) {
            content
                .navigationDestination(for: Route.self) { route in
                    router.view(for: route)
                }
        }
        .environmentObject(router)
    }
}
