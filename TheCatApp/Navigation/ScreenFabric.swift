//
//  ScreenFabric.swift
//  TheCatApp
//
//  Created by Sofia Cantero on 5/02/25.
//

import SwiftUI

struct ScreensFabric {
    @ObservedObject var destinationViewModel: DestinationViewModel
    
    @ViewBuilder
    func createView(item: ScreenDestination) -> some View {
        switch item {
        case .catList:
            CatListView(viewModel: CatListViewModel(destinationViewModel: destinationViewModel))
        case .catDetail(let id):
            CatDetailView(viewModel: CatDetailViewModel(destinationViewModel: destinationViewModel, catId: id))
        }
    }
}

