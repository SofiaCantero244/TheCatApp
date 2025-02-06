//
//  NavigationWrapperView.swift
//  TheCatApp
//
//  Created by Sofia Cantero on 5/02/25.
//

import SwiftUI

struct NavigationWrapperView<Content: View>: View {
    @ObservedObject var destinationViewModel: DestinationViewModel
    var fabric: ScreensFabric
    var content: () -> Content
    
    var body: some View {
        NavigationStack(path: $destinationViewModel.destination) {
            content()
                .navigationDestination(for: ScreenDestination.self) { item in
                    fabric.createView(item: item)
                }
        }
    }
}
