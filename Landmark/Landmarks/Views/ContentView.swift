//
//  ContentView.swift
//  Landmarks
//
//  Created by HA on 2022/02/14.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .featured

    enum Tab{
        case featured
        case list
    }

    var body: some View {
        TabView(selection: $selection){
            CategoryHome()
                .tabItem{
                    Label("Featured", systemImage: "star")
                }
                .tag(Tab.featured)
            
            LandmarkList()
                .tabItem{
                    Label("List", systemImage: "list.bullet")
                }
                .tag(Tab.list)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData()) //환경에 모델 개체 추가
    }
}
