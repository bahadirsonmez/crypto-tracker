//
//  ContentView.swift
//  CryptoTracker
//
//  Created by Bahadır Sönmez on 19.12.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            VStack {
                Text("TextColor")
                    .foregroundColor(Color.theme.accent)
                Text("GreenColor")
                    .foregroundColor(Color.theme.green)
                Text("RedColor")
                    .foregroundColor(Color.theme.red)
                Text("SecondaryTextColor")
                    .foregroundColor(Color.theme.secondaryText)
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
