//
//  CatListViewTests.swift
//  TheCatAppTests
//
//  Created by Sofia Cantero on 6/02/25.
//

import XCTest
import SwiftUI

@testable import TheCatApp

final class CatListViewModelTests: XCTestCase {
    func testFetchCatListSuccess() async {
        let viewModel = CatListViewModel(catsAPI: MockCatsAPI(), destinationViewModel: DestinationViewModel())

        Task {
            await viewModel.fetchCatList()
            
            XCTAssertEqual(viewModel.catList.first?.id, "abys")
            XCTAssertEqual(viewModel.catList.first?.name, "Abyssinian")
            XCTAssertEqual(viewModel.catList.count, 3)
            XCTAssertFalse(viewModel.isLoading)
            XCTAssertFalse(viewModel.showErrorAlert)
        }
    }
    
    func testFetchCatListError() async {
        let viewModel = CatListViewModel(catsAPI: MockCatsErrorAPI(), destinationViewModel: DestinationViewModel())

        Task {
            await viewModel.fetchCatList()
            
            XCTAssertEqual(viewModel.catList.count, 0)
            XCTAssertFalse(viewModel.isLoading)
            XCTAssertTrue(viewModel.showErrorAlert)
        }
    }

    func testFetchCatDetailSuccess() async {
        let viewModel = CatDetailViewModel(catsAPI: MockCatsAPI(), destinationViewModel: DestinationViewModel(), catId: "abys")
        
        Task {
            await viewModel.fetchCatDetails()
            
            XCTAssertEqual(viewModel.breedCharacteristics.count, 11)
            XCTAssertEqual(viewModel.catDetail?.name, "Abyssinian")
            XCTAssertEqual(viewModel.catDetail?.id, "abys")
            XCTAssertFalse(viewModel.isLoading)
            XCTAssertFalse(viewModel.showErrorAlert)
        }
    }
    
    func testFetchCatDetailError() async {
        let viewModel = CatDetailViewModel(catsAPI: MockCatsErrorAPI(), destinationViewModel: DestinationViewModel(), catId: "abys")
        
        Task {
            await viewModel.fetchCatDetails()

            XCTAssertEqual(viewModel.breedCharacteristics.count, 0)
            XCTAssertTrue(viewModel.catDetail == nil)
            XCTAssertFalse(viewModel.isLoading)
            XCTAssertTrue(viewModel.showErrorAlert)
        }
    }
}
