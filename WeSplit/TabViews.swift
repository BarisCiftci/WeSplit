//
//  TabView.swift
//  WeSplit
//
//  Created by Baris Ciftci on 29/12/2023.
//

import SwiftUI

struct TabViews: View {
    var body: some View {
        TabView {
            NewsView()
                .tabItem {Label("WeSplit", systemImage: "square.split.2x1.fill")}
            ConverterView()
                .tabItem {Label("Converter", systemImage: "sun.max.fill")}
        }
    }
}

#Preview {
    TabViews()
}
