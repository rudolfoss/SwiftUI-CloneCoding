//
//  LandmarkRow.swift
//  Landmarks
//
//  Created by HA on 2022/02/14.
//

import SwiftUI

struct LandmarkRow: View {
    var landmark: Landmark
    var body: some View {
        HStack{
            landmark.image
                .resizable()
                .frame(width:50, height: 50)
            Text(landmark.name)
            Spacer()

            if landmark.isFavorite{
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
        }
    }
}

struct LandmarkRow_Previews: PreviewProvider {
    static var landmarks = ModelData().landmarks/*개체와 함께 작동하도록 미리보기 업데이트 */
    
    static var previews: some View {
        Group{
            LandmarkRow(landmark: landmarks[0])
            LandmarkRow(landmark: landmarks[1])
        }
        .previewLayout(.fixed(width: 300, height: 70))

    }
}
