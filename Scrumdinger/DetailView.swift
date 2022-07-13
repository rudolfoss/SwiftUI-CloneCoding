//
//  DetailView.swift
//  Scrumdinger
//
//  Created by HA on 2022/07/09.
//

import SwiftUI

struct DetailView: View {
    @Binding var scrum: DailyScrum
    
    @State private var data = DailyScrum.Data()//개인 속성 추가
    @State private var isPresentingEditView = false
    
    var body: some View {
        List{
            Section(header: Text("Meeting info")){
                
                //pass the scrum binding in the MeetingView() destination.
                NavigationLink(destination: MeetingView(scrum: $scrum)){
                Label("Start Meeting", systemImage: "timer")
                    .font(.headline)
                    .foregroundColor(.accentColor)
                }
                HStack{
                    Label("Length", systemImage: "clock")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                }
                .accessibilityElement(children: .combine)
                HStack{
                    Label("Theme", systemImage: "paintpalette")
                    Spacer()
                    Text(scrum.theme.name)
                        .padding(4)
                    .foregroundColor(scrum.theme.accentColor)
                    .background(scrum.theme.mainColor)
                        .cornerRadius(4)
                }
                .accessibilityElement(children: .combine)
            }
            Section(header: Text("Attendees")){
                ForEach(scrum.attendees){ attendee in
                    Label(attendee.name, systemImage: "person")
                }
            }
        }
        .navigationTitle(scrum.title)
        .toolbar{
            Button("Edit"){
                isPresentingEditView = true
                data = scrum.data //Set data to scrum.data in the Edit button’s action closure.
            }
            
        }
        .sheet(isPresented: $isPresentingEditView){
            NavigationView{
                DetailEditView(data: $data) //Update the DetailEditView initializer to include a binding to data.
                    .navigationTitle(scrum.title)
                //cancel button
                    .toolbar{
                ToolbarItem(placement: .cancellationAction){
                    Button("Cancel"){
                        isPresentingEditView = false
                        }
                    }
                        ToolbarItem(placement: .confirmationAction){
                            Button("Done"){
                                isPresentingEditView = false
                                scrum.update(from: data)
                            }
                        }
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            DetailView(scrum: .constant(DailyScrum.sampleData[0]))
        }
        
    }
}
