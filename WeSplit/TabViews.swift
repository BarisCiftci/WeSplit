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
            ContentView()
                .tabItem {Label("Menu", systemImage: "list.dash")}
        }
    }
}

#Preview {
    TabViews()
}
