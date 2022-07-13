//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by HA on 2022/07/06.
//

import SwiftUI

struct ScrumsView: View {
    @Binding var scrums: [DailyScrum]
    //You’ll observe this value and save user data when it becomes inactive. @environment
    @Environment(\.scenePhase) private var scenePhase
    @State private var isPresentingNewScrumView = false
    @State private var newScrumData = DailyScrum.Data()
    let saveAction: ()->Void
    
    var body: some View {
        List{
            ForEach($scrums){ $scrum in
                NavigationLink(destination: DetailView(scrum: $scrum)){
                    CardView(scrum: scrum)
                }
                .listRowBackground(scrum.theme.mainColor)
            }
        }
        .navigationTitle("Daily Scrums")
        .toolbar{
            Button(action:{
                isPresentingNewScrumView = true
            }){
                Image(systemName: "plus")
            }
            .accessibilityLabel("New Scrum")
        }
        .sheet(isPresented: $isPresentingNewScrumView){
            NavigationView{
                //newScrumData에 바인딩 전달
                DetailEditView(data: $newScrumData)
                    .toolbar{
                        ToolbarItem(placement: .cancellationAction){
                            Button("Dismiss"){
                                isPresentingNewScrumView = false
                                //사용자가 시트를 닫을 때 다시 초기화
                                newScrumData = DailyScrum.Data()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction){
                            Button("Add"){
                                // create a new DailyScrum to insert into the array.
                                let newScrum = DailyScrum(data:newScrumData)
                                scrums.append(newScrum)
                                isPresentingNewScrumView = false
                                //사용자가 시트를 닫을 때 다시 초기화
                                newScrumData = DailyScrum.Data()
                            }
                        }
                    }
            }
        }
        .onChange(of: scenePhase) { phase in
            //Call saveAction() if the scene is moving to the inactive phase.
//A scene in the inactive phase no longer receives events and may be unavailable to the user.

            if phase == .inactive{saveAction()}
        }
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ScrumsView(scrums: .constant(DailyScrum.sampleData),saveAction: {})
        }

    }
}
