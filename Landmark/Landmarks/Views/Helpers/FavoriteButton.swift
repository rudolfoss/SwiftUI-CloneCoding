//
//  FavoriteButton.swift
//  Landmarks
//
//  Created by HA on 2022/02/22.
//

import SwiftUI

struct FavoriteButton: View {
    @Binding var isSet : Bool //버튼의 현재 상태를 나타내는 바인딩
    var body: some View {
        Button{
            isSet.toggle()
        }label: {
            Label("Toggle Favorite", systemImage: isSet ? "star.fill" : "star")
                .labelStyle(.iconOnly)
                .foregroundColor(isSet ? .yellow : .gray)
            
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(isSet: .constant(true))
    }
}
