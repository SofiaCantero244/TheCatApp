//
//  DestinationViewModel.swift
//  TheCatApp
//
//  Created by Sofia Cantero on 5/02/25.
//

import SwiftUI

enum ScreenDestination: Hashable {
    case catList
    case catDetail(id: String)
}

class DestinationViewModel: ObservableObject {
    @Published var destination: [ScreenDestination]
    
    init(destination: [ScreenDestination] = []) {
        self.destination = destination
    }
    
    @MainActor
    func navigateTo(_ screen: ScreenDestination) {
        destination.append(screen)
    }
}

