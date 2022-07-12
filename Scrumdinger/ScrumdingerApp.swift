//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by HA on 2022/07/05.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    @State private var scrums = DailyScrum.sampleData
    var body: some Scene {
        WindowGroup {
            NavigationView{
            ScrumsView(scrums: $scrums)
            }
        }
    }
}
