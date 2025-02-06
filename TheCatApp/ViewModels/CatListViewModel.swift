//
//  CatListViewModel.swift
//  TheCatApp
//
//  Created by Sofia Cantero on 5/02/25.
//

import Foundation

struct CatData: Equatable, Hashable {
    let id: String
    let name: String
}

class CatListViewModel: ObservableObject {
    let destinationViewModel: DestinationViewModel
    let catsAPI: CatsAPIType
    
    @Published var catList: [CatData] = []
    @Published var isLoading = false
    @Published var showErrorAlert = false
    
    var catsFetchCompleted = false
    private var page = 0

    init(catsAPI: CatsAPIType = CatsAPICore(), destinationViewModel: DestinationViewModel) {
        self.catsAPI = catsAPI
        self.destinationViewModel = destinationViewModel
    }
    
    @MainActor
    func fetchCatList() {
        isLoading = true
        Task {
            let result = try await catsAPI.fetchCatBreeds(limit: 15, page: page)
            isLoading = false
            catsFetchCompleted = result.breeds.isEmpty
            page += 1
            
            guard result.error == nil else {
                showErrorAlert = true
                return
            }
            let newCats = result.breeds.compactMap { CatData(id: $0.id ?? "", name: $0.name ?? "") }
            self.catList.append(contentsOf: newCats)
        }
    }
    
    @MainActor
    func navigateToCatDetail(id: String) {
        destinationViewModel.navigateTo(.catDetail(id: id))
    }
}
