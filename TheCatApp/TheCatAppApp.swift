//
//  TheCatAppApp.swift
//  TheCatApp
//
//  Created by Sofia Cantero on 4/02/25.
//

import SwiftUI

@main
struct TheCatAppApp: App {
    let destinationViewModel: DestinationViewModel
    let fabric: ScreensFabric
    
    init() {
        destinationViewModel = DestinationViewModel()
        fabric = ScreensFabric(destinationViewModel: destinationViewModel)
    }

    var body: some Scene {
        WindowGroup {
            NavigationWrapperView(destinationViewModel: destinationViewModel, fabric: fabric) {
                fabric.createView(item: .catList)
            }
        }
    }
}
