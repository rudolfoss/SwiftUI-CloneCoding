//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by HA on 2022/07/06.
//

import SwiftUI

struct ScrumsView: View {
    let scrums: [DailyScrum]
    var body: some View {
        List{
            ForEach(scrums, id: \.title){scrums in
                NavigationLink(destination: DetailView(scrum: scrums)){
                CardView(scrum: scrums)
                }
              //  .listRowBackground(scrums.theme.mainColor)
            }
        }
        .navigationTitle("Daily Scrums")
        .toolbar{
            Button(action:{}){
                Image(systemName: "plus")
            }
            .accessibilityLabel("New Scrum")
        }
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
        ScrumsView(scrums: DailyScrum.sampleData)
        }

    }
}
