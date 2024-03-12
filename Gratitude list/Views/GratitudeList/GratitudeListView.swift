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
            if viewModel.gratitudeList.isEmpty {
                emptyView()
            } else {
                listOfGratitudes()
            }
        }
        .background(.gray.opacity(0.1))
        .navigationBarBackButtonHidden(true)
        .toastView(toast: $viewModel.toast)
        .modifier(ActivityIndicatorModifier(isLoading: viewModel.isLoading, message: "Loading gratitude list"))
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
    
    @ViewBuilder
    private func emptyView() -> some View {
        VStack(alignment: .center) {
            Text("There are no gratitudes to show.")
            Text("Add a new gratitude by pressing the button bellow.")
            
            Button {
                router.navigateTo(.addGratitude)
            } label: {
                HStack(alignment: .center, spacing: 10) {
                    Text("Add gratitude")
                        .foregroundStyle(.white)
                        .frame(maxWidth: 200)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 0)
                .frame(height: 56, alignment: .center)
                .background(.cyan)
                .cornerRadius(8)
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .centerLastTextBaseline)
    }
    
    @ViewBuilder
    private func listOfGratitudes() -> some View {
        VStack(alignment: .leading, spacing: 20) {
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
}

#Preview {
    GratitudeListView(viewModel: GratitudeListViewModel())
}
