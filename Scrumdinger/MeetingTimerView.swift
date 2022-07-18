//
//  MeetingTimerView.swift
//  Scrumdinger
//
//  Created by HA on 2022/07/17.
//

import SwiftUI

struct MeetingTimerView: View {
    //Add properties named theme and speakers.
    let speakers: [ScrumTimer.Speaker]
    let isRecording: Bool
    let theme: Theme
    
    //Add a computed property named currentSpeaker that returns the name of the current speaker.
    //The current speaker is the first person on the list who hasn’t spoken. If there isn’t a current speaker, the expression returns “Someone.”
    private var currentSpeaker: String{
        speakers.first(where: {!$0.isCompleted})?.name ?? "Someone"
    }
    
    var body: some View {
        Circle()
            .strokeBorder(lineWidth: 24)
            .overlay{
                VStack{
                Text(currentSpeaker)
                    .font(.title)
                Text("is speaking")
                    Image(systemName: isRecording ? "mic" : "mic.slash")
                        .font(.title)
                        .padding(.top)
//Modify the image with an accessibility label that reads either "with transcription" or "without transcription" based on the value of isRecording.
                        .accessibilityLabel(isRecording ? "with transcription" : "without transcription")
                }
                //This modifier makes VoiceOver read the two text views as one sentence.
                .accessibilityElement(children: .combine)
                .foregroundStyle(theme.accentColor)
        }
            .overlay{
                ForEach(speakers){ speaker in
                    if speaker.isCompleted, let index = speakers.firstIndex(where:{ $0.id == speaker.id}){
                        SpeakerArc(speakerIndex: index, totalSpeakers: speakers.count)
                            .rotation(Angle(degrees: -90))
                            .stroke(theme.mainColor,lineWidth: 12)
                    }
                }
            }
            .padding(.horizontal)
    }
}

struct MeetingTimerView_Previews: PreviewProvider {
    //A static array of sample speaker data is helpful while you develop the speaker list UI.
    static var speakers:[ScrumTimer.Speaker]{
        [ScrumTimer.Speaker(name:"Bill", isCompleted: true),ScrumTimer.Speaker(name: "Cathy",isCompleted: false)]
    }
    static var previews: some View {
        //update the preview provider.
        MeetingTimerView(speakers: speakers, isRecording: true, theme:  .yellow)
    }
}
