//
//  LandmarkDetail.swift
//  Landmarks
//
//  Created by HA on 2022/02/19.
//

import SwiftUI

struct LandmarkDetail: View {
    @EnvironmentObject var modelData: ModelData // 환경의 모델데이터 엑세스
    var landmark: Landmark
    
    var landmarkIndex: Int {
        modelData.landmarks.firstIndex(where: { $0.id == landmark.id})!
    }//모델 데이터와 비교하여 입력 랜드마크의 인덱스 계산
    
    var body: some View {
        ScrollView{
            MapView(coordinates: landmark.locationCoordinate)
                .ignoresSafeArea(edges: .top)
                .frame(height: 300)
            
            CircleImage(image: landmark.image)
                .offset(y:-130)
                .padding(.bottom,-130)
            
        VStack(alignment: .leading) {
            HStack{
            Text(landmark.name)
                    .font(.title)
                FavoriteButton(isSet: $modelData.landmarks[landmarkIndex].isFavorite)
        
            }
            HStack {
            
                Text(landmark.park)
                Spacer()
                Text(landmark.state)
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
            
            Divider()
            Text("About \(landmark.name)")
                .font(.title2)
            Text(landmark.description)
        }
        .padding()
        }
        .navigationTitle(landmark.name)
    }
}

struct LandmarkDetail_Previews: PreviewProvider {
    static let modelData = ModelData()
    
    static var previews: some View {
        LandmarkDetail(landmark: modelData.landmarks[0])
            .environmentObject(modelData)
    }
}
