//
//  SearchBarView.swift
//  CryptoTracker
//
//  Created by Bahadır Sönmez on 22.12.2022.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchText.isEmpty ? Color.theme.secondaryText : Color.theme.accent
                )
            ZStack(alignment: .trailing) {
                TextField("Search by name or symbol...", text: $searchText)
                    .disableAutocorrection(true)
                Image(systemName: "xmark.circle.fill")
                    .padding()
                    .offset(x: 10)
                    .opacity(searchText.isEmpty ? 0.0 : 1.0)
                    .onTapGesture {
                        UIApplication.shared.endEditing()
                        searchText = ""
                    }
            }
            .foregroundColor(Color.theme.accent)
        }
        .font(.headline)
        .padding(.horizontal)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(color: Color.theme.accent.opacity(0.15),
                        radius: 10,
                        x: 0, y: 0)
        )
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant("Hello"))
    }
}
