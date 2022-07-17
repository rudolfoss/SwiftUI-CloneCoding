//
//  ErrorWrapper.swift
//  Scrumdinger
//
//  Created by HA on 2022/07/15.
//

import Foundation


//Add an Error Wrapper Structure
//You can use the Error protocol to explicitly assign a type to an error-handling property.
//->프로토콜을 사용하여 Error오류 처리 속성에 유형을 명시적으로 할당할 수 있음.
struct ErrorWrapper: Identifiable{
    let id: UUID
    let error: Error
    let guidance: String

    //This initializer provides preview data to the error view that you’ll create in the next section.
    init(id: UUID = UUID(), error:Error, guidance: String){
        self.id = id
        self.error = error
        self.guidance = guidance
    }

}
