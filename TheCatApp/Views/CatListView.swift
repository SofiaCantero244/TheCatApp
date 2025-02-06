//
//  ContentView.swift
//  TheCatApp
//
//  Created by Sofia Cantero on 4/02/25.
//

import SwiftUI

struct CatListView: View {
    @StateObject var viewModel: CatListViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("cat.title")
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal, 16)
                .accessibilityIdentifier("HomeViewTitle")
            
            if viewModel.catList.isEmpty {
                ProgressView()
                    .foregroundColor(.gray)
            } else {
                listView
            }
        }
        .alert(isPresented: $viewModel.showErrorAlert) {
            Alert(
                title: Text("error.title"),
                message: Text("error.message"),
                dismissButton: .default(Text("error.action"))
            )
        }
        .onAppear {
            viewModel.fetchCatList()
        }
    }
    
    private var listView: some View {
        List {
            ForEach(viewModel.catList, id: \.id) { cat in
                Text(cat.name)
                    .foregroundStyle(Color.black)
                    .id(cat.id)
                    .accessibilityIdentifier(cat.name)
                    .onTapGesture {
                        viewModel.navigateToCatDetail(id: cat.id)
                    }
            }
            
            if !viewModel.catsFetchCompleted {
                ProgressView()
                    .onAppear {
                        viewModel.fetchCatList()
                    }
            }
        }
        .padding()
        .listStyle(PlainListStyle())
    }
}
