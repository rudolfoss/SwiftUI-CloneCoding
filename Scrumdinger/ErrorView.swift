//
//  ErrorView.swift
//  Scrumdinger
//
//  Created by HA on 2022/07/17.
//

import SwiftUI

//Create an Error View

struct ErrorView: View {
    let errorWrapper: ErrorWrapper
    //이 경우 뷰의 dismiss구조에 액세스하고 뷰를 닫는 함수처럼 호출.
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView{
        VStack{
        Text("An error has occured!")
                .font(.title)
                .padding(.bottom)
            Text(errorWrapper.error.localizedDescription)
                .font(.headline)
            Text(errorWrapper.guidance)
                .font(.caption)
                .padding(.top)
            Spacer()
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(16)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                Button("Dismiss"){
                    dismiss()
                }
                }
            }
        }
    }
}
struct ErrorView_Previews: PreviewProvider {
    enum SampleError: Error{
        case errorRequired
    }
    static var wrapper: ErrorWrapper{
        ErrorWrapper(error: SampleError.errorRequired, guidance: "You can safely ignore this error")
    }
    static var previews: some View {
        //Pass the error wrapper to the ErrorView initializer.
        ErrorView(errorWrapper: wrapper)
    }
}
