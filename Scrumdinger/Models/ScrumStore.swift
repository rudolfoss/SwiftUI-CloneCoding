//
//  ScrumStore.swift
//  Scrumdinger
//
//  Created by HA on 2022/07/13.
//

import Foundation
import SwiftUI

//ObservableObject is a class-constrained protocol for connecting external model data to SwiftUI views.
class ScrumStore: ObservableObject{
    //Any view observing an instance of ScrumStore will render again when the scrums value changes.
    @Published var scrums:[DailyScrum]=[]
    
    //Scrumdinger는 사용자의 문서 폴더에 있는 파일에 스크럼을 로드하고 저장합니다. 해당 파일에 더 편리하게 액세스할 수 있도록 하는 기능을 추가합니다.
    private static func fileURL() throws ->URL{
     //Call url(for:in:appropriateFor:create:) on the default file manager.
        //클래스 의 공유 인스턴스를 사용 하여 현재 사용자의 Documents 디렉토리 위치를 가져옵니다
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        //Call appendingPathComponent(_:) to return the URL of a file named scrums.data.
        .appendingPathComponent("scrums.data")
    }
    
    //비동기 로드 메소드 만들기
    static func load() async throws ->[DailyScrum]{
//Calling withCheckedThrowingContinuation suspends the load function, then passes a continuation into a closure that you provide. A continuation is a value that represents the code after an awaited function.
        try await withCheckedThrowingContinuation{ continuation in
            //In the closure, call the legacy load function with a completion handler.
            load{ result in
                switch result{
                case .failure(let error):
                    continuation.resume(throwing: error)
                    //The array of scrums becomes the result of the withCheckedThrowingContinuation call when the async task resumes.
                case.success(let scrums):
                    continuation.resume(returning: scrums)
                }
                
            }
        }
    }

    //Add a Method to load Data
    //Result is a single type that represents the outcome of an operation, whether it’s a success or failure.
    static func load(completion: @escaping(Result<[DailyScrum],Error>)->Void){
        //디스패치 큐를 사용하여 기본 스레드 또는 백그라운드 스레드에서 실행할 작업을 선택합니다.
        DispatchQueue.global(qos: .background).async{
            do{
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else{
                    DispatchQueue.main.async{
                        completion(.success([]))
                    }
                    return
                }
                //Decode the file’s available data into a local constant named dailyScrums.
                let dailyScrums = try JSONDecoder().decode([DailyScrum].self, from: file.availableData)
                
                //On the main queue, pass the decoded scrums to the completion handler.
                //백그라운드 대기열에서 파일을 열고 내용을 디코딩하는 장기 실행 작업을 수행. 이러한 작업이 완료되면 기본 대기열로 다시 전환.
                DispatchQueue.main.async {
                    completion(.success(dailyScrums))
                }
            }catch{
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    //비동기 저장 메소드 만들기.
    //Create a static function named save that asynchronously returns an Int.
    @discardableResult
    static func save(scrums:[DailyScrum])async throws -> Int{
        //Call withCheckedThrowingContinuation using the await keyword.
        try await withCheckedThrowingContinuation{ continuation in
            //In the closure, call the legacy save function with a completion handler.
            save(scrums: scrums){ result in
                switch result{
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let scrumsSaved):
                    continuation.resume(returning: scrumsSaved)
                
                }
            }
        }
    }
    //Add a Method to Save Data
    static func save(scrums:[DailyScrum],completion: @escaping (Result<Int, Error>)->Void){
        //Create a do-catch statement on a background queue.
        DispatchQueue.global(qos: .background).async {
            do{
                //In the do clause, encode the scrums data.
                let data = try JSONEncoder().encode(scrums)
                //Create a constant for the file URL.
                let outfile = try fileURL()
                try data.write(to: outfile)
                //Pass the number of scrums to the completion handler.
                DispatchQueue.main.async {
                    completion(.success(scrums.count))
                }
            }catch{
                //In the catch clause, pass the error to the completion handler.
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
