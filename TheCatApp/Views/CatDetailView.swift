//
//  CatDetailView.swift
//  TheCatApp
//
//  Created by Sofia Cantero on 5/02/25.
//

import SwiftUI

struct CatDetailView: View {
    @ObservedObject var viewModel: CatDetailViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 16) {
                if viewModel.catDetail?.name == nil {
                    ProgressView("cat.detail.loading")
                } else {
                    nameCat
                    VStack(spacing: .zero) {
                        imageCat
                        detailBox
                    }
                    description
                }
            }
            .onAppear {
                viewModel.fetchCatDetails()
            }
            .alert(isPresented: $viewModel.showErrorAlert) {
                Alert(
                    title: Text("error.title"),
                    message: Text("error.message"),
                    dismissButton: .default(Text("error.action"))
                )
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
            })
        }
        .padding(.horizontal, .zero)
    }
    
    private var nameCat: some View {
        Text(viewModel.catDetail?.name ?? "").accessibilityIdentifier("DetailViewTitle")
            .font(.title)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
    }
    
    private var imageCat: some View {
        AsyncImage(url: viewModel.catImageURL) { image in
            image.resizable()
                .scaledToFit()
                .padding(.horizontal, .zero)
                .frame(height: 200)
                .clipped()
        } placeholder: {
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .foregroundColor(.gray.opacity(0.3))
                .padding()
                .frame(height: 200)
        }
    }
    
    private var detailBox: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("cat.detail.title")
                .font(.title2).bold()
                .padding(.horizontal, 16)
            
            HStack(spacing: 32) {
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(viewModel.breedCharacteristics, id: \.id) { characteristic in
                        Text(characteristic.title).bold()
                            .frame(height: 28)
                    }
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(viewModel.breedCharacteristics, id: \.id) { characteristic in
                        detailRatingRow(value: characteristic.rating)
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal, 32)
        }
        .padding(.vertical, 16)
        .background(Color("yellowCatColor"))
        .accessibilityElement(children: .combine)
        .accessibilityIdentifier("breedCharacteristics")
    }
    
    private func detailRatingRow(value: Int) -> some View {
        HStack(spacing: .zero) {
            ForEach(0..<5, id: \.self) { index in
                Circle()
                    .fill(index < value ? Color("greenCatColor") : Color.gray.opacity(0.3))
                    .frame(width: 12, height: 12)
            }
        }
        .frame(height: 28)
    }
    
    private var description: some View {
        Text(viewModel.catDetail?.description ?? "")
            .padding(.horizontal, 16)
            .accessibilityIdentifier("breedDescription")
    }
}
