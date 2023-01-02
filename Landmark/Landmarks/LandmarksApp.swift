//
//  LandmarksApp.swift
//  Landmarks
//
//  Created by HA on 2022/02/14.
//

import SwiftUI

@main
struct LandmarksApp: App {
    @StateObject private var modelData = ModelData() // 앱을 실행할 때 환경에 모델 개체를 배치하도록 앱 인스턴스 생성
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData) // 수정자를 사용하여 제공
        }
    }
}
