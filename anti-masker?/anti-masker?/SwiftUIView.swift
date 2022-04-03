//
//  SwiftUIView.swift
//  anti-masker?
//
//  Created by Ananya Aggarwal on 3/27/22.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        TabView{
            ContentView()
                .tabItem {
                    Label("Tab1",systemImage: "list.dash")
                }
            Text("Hello, World!")
                .tabItem {
                    Label("Tab2",systemImage: "list.dash")
                }
            Text("Hello, World!")
                .tabItem {
                    ZStack{
                        Color.red
                    Label("Tab3",systemImage: "list.dash")
                }
                }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
