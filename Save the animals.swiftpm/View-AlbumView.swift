//
//  View-AlbumView.swift
//  Save the animals
//
//  Created by Patrick Battisti Forsthofer on 09/04/22.
//

import SwiftUI

struct AlbumView: View {
    @Environment(\.dismiss) var dismiss
    
    let data = (1...100).map { "Item \($0)" }
    
    let columns = [
        GridItem(.adaptive(minimum: 120))
    ]
    
    var body: some View {
        ZStack {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(data, id: \.self) { item in
                        AquariumView()
                    }
                }
                .padding(.horizontal)
                .padding(.top, 40)
            }
            .navigationTitle("Animals saved")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        CloseButton()
                    }
                }
            }
        }
        }
        .overlay(content: SheedIndicator.init)
    }
}
