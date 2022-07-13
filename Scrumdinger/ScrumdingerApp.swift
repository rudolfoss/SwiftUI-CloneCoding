//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by HA on 2022/07/05.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    //The @StateObject property wrapper creates a single instance of an observable object for each instance of the structure that declares it.
    @StateObject private var store = ScrumStore()
    var body: some Scene {
        WindowGroup {
            NavigationView{
                //Pass ScrumsView a binding to store.scrums.
                ScrumsView(scrums: $store.scrums){
                    //call ScrumStore.saveScrums() in the saveAction closure.
                    ScrumStore.save(scrums: store.scrums){ result in
                        //호출이 실패하면 오류를 로컬 상수에 바인딩하고 실행을 중지.
                        //현재 디스크에 데이터를 유지하는 동안 오류가 발생하면 앱이 충돌합니다.
                        if case.failure(let error) = result{
                            fatalError(error.localizedDescription)
                        }

                    }
                }
            }
            .onAppear{
                ScrumStore.load{ result in
                    //Use a switch statement to update the store’s scrums array with the decoded data or halt execution if load(completion:) returns an error.
                    switch result{
                    case.failure(let error):
                        fatalError(error.localizedDescription)
                    case.success(let scrums):
                        store.scrums = scrums
                    }
                }
            }
        }
    }
}
