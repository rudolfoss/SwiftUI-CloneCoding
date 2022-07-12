//
//  DetailEditView.swift
//  Scrumdinger
//
//  Created by HA on 2022/07/10.
//

import SwiftUI

struct DetailEditView: View {
    @Binding var data: DailyScrum.Data //사용자가 완료 버튼을 탭할 때 세부 정보 보기에서 스크럼을 업데이트하는 바인딩을 편집 보기에 추가
    @State private var newAttendeeName = ""
    var body: some View {
        Form{
            Section(header: Text("Meeting Info")){
                // $ syntax to create a binding to data.
                TextField("Title", text: $data.title)
                HStack{
                    Slider(value: $data.lengthInMinutes, in:5...30, step: 1){
                    Text("Length")
                    }
                    Spacer()
                    Text("\(Int(data.lengthInMinutes)) minutes")
                }
                //theme에 바인딩 전달.
                ThemePicker(selection: $data.theme)
            }
            Section(header: Text("Attendees")){
                ForEach(data.attendees) { attendee in
                    Text(attendee.name)
                }
                //ondelete 구문은 foreach 구문에만 존재. 반드시 foreach 구문안에 위치시켜야함.
                .onDelete{ indices in
                    data.attendees.remove(atOffsets: indices)
               }
                HStack{
                    TextField("New Attendee", text: $newAttendeeName)
                    Button(action: {
                        withAnimation{
                            let attendee = DailyScrum.Attendee(name: newAttendeeName)
                            data.attendees.append(attendee)
                            newAttendeeName = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                        //Add an accessibility label to the image.
                            .accessibilityLabel("Add attendee")
                    }
                    //Disable the button if newAttendeeName is empty.
                    .disabled(newAttendeeName.isEmpty)
                }
            }
        }
    }
}

struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEditView(data: .constant(DailyScrum.sampleData[0].data))
    }
}
