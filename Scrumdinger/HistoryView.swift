//
//  HistoryView.swift
//  Scrumdinger
//
//  Created by HA on 2022/07/18.
//

import SwiftUI

struct HistoryView: View {
    let history: History
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                Divider()
                    .padding()
                Text("Attendees")
                    .font(.headline)
                Text(history.attendeeString)
                //Use optional binding to safely unwrap the value of transcript.
                if let transcript = history.transcript{
                    Text("Transcript")
                        .font(.headline)
                        .padding(.top)
                    Text(transcript)
                    
                }
            }
        }
        .navigationTitle(Text(history.date, style: .date))
        .padding()
    }
}
extension History{
    var attendeeString: String{
        ListFormatter.localizedString(byJoining: attendees.map{ $0.name })
    }
}

struct HistoryView_Previews: PreviewProvider {
    //In the preview provider, add a history variable that contains sample data. Then pass the variable to the HistoryView() initializer.
    static var history: History{
        History(attendees: [DailyScrum.Attendee(name:"Jon"),DailyScrum.Attendee(name:"Darla"),DailyScrum.Attendee(name:"Luis")], lengthInMinutes: 10, transcript: "Darla, would you like to start today? Sure, yesterday I reviewed Luis' PR and met with the design team to finalize the UI...")
    }
    
    static var previews: some View {
        HistoryView(history: history)
    }
}
