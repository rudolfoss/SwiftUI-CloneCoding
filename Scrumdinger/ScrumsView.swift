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
                CardView(scrum: scrums)
                    .listRowBackground(scrums.theme.mainColor)
                
            }
        }
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        ScrumsView(scrums: DailyScrum.sampleData)
    }
}
