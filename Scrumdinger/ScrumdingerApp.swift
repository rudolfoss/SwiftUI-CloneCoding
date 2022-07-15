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
                    //작업을 사용하여 비동기 메서드 호출
                        Task{
                            do{
                                //You can ignore the return value because the discardableResult attribute annotates the save function.
                                try await ScrumStore.save(scrums: store.scrums)
                            }
                            catch{
                                fatalError("Error saving scrums.")
                            }
                    }
                }
            }
            
            //SwiftUI는 작업을 뷰와 task연결하는 데 사용할 수 있는 수정자를 제공. async시스템이 탐색 보기를 생성할 때 수정자를 사용하여 스크럼을 로드.
            .task {
                do{
                    store.scrums = try await ScrumStore.load()
                }
                catch{
                    fatalError("Error loading scrums.")
                }
            }
           /* .onAppear{
                ScrumStore.load{ result in
                    //Use a switch statement to update the store’s scrums array with the decoded data or halt execution if load(completion:) returns an error.
                    switch result{
                    case.failure(let error):
                        fatalError(error.localizedDescription)
                    case.success(let scrums):
                        store.scrums = scrums
            
                    }
                }
            }*/
        }
    }
}
