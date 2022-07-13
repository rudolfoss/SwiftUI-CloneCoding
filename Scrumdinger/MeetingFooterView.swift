//
//  MeetingFooterView.swift
//  Scrumdinger
//
//  Created by HA on 2022/07/12.
//

import SwiftUI

struct MeetingFooterView: View {
    let speakers: [ScrumTimer.Speaker]
    var skipAction: ()->Void
    
    //스피커 번호를 결정하는 개인 계산 속성을 추가합니다.
    private var speakerNumber: Int?{
        guard let index = speakers.firstIndex(where: {!$0.isCompleted}) else{return nil}
        return index+1
    }
    private var isLastSpeaker: Bool{
        //활성 발언자가 마지막 발언자인지 확인하는 개인 계산 속성을 추가합니다.
        return speakers.dropLast().allSatisfy{$0.isCompleted}
    }
    private var speakerText: String{
        guard let speakerNumber = speakerNumber else { return "No more speakers"}
            return "Speaker \(speakerNumber) of \(speakers.count)"
        }

    
    var body: some View {
        VStack{
            HStack{
                if isLastSpeaker{
                    Text("Last Speaker")
            } else{
                Text(speakerText)
                Spacer()
                Button(action: skipAction){
                    Image(systemName: "forward.fill")
                }
                .accessibilityLabel("Next speaker")
                }
            }
        }
        .padding([.bottom, .horizontal])
    }
}


struct MeetingFooterView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingFooterView(speakers: DailyScrum.sampleData[0].attendees.speakers,skipAction: {})
            .previewLayout(.sizeThatFits)
    }
}
