//
//  GratitudeListView.swift
//  Gratitude list
//
//  Created by Goga Eusebiu on 11.03.2024.
//

import SwiftUI

struct GratitudeListView: View {
    @EnvironmentObject var router: Router
    @ObservedObject var viewModel: GratitudeListViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 20) {
                ForEach(viewModel.gratitudeList) { gratitude in
                    GratitudeCard(gratitude: gratitude)
                        .onTapGesture {
                            router.navigateTo(.gratitudeDetail(gratitude.id))
                        }
                }
            }
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .topLeading)
        }
        .background(.gray.opacity(0.1))
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationImageButton(systemName: "plus")
                    .tapAction {
                        router.navigateTo(.addGratitude)
                    }
            }
            ToolbarItem(placement: .topBarLeading) {
                NavigationTitle(title: "Daily Gratitude")
            }
        }
        .onAppear {
            Task {
                await viewModel.getListOfGratitudes()
            }
        }
    }
}

#Preview {
    GratitudeListView(viewModel: GratitudeListViewModel())
}
