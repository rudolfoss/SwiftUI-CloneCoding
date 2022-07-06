//
//  TrailingIconLabel.swift
//  Scrumdinger
//
//  Created by HA on 2022/07/06.
//

import SwiftUI

struct TrailingIconLabelStyle: LabelStyle{
    //The configuration parameter is a LabelStyleConfiguration, which contains the icon and title views
    func makeBody(configuration: Configuration) -> some View {
        HStack{
            configuration.title
            configuration.icon
            
        }
    }
    
    
}

extension LabelStyle where Self ==TrailingIconLabelStyle{
    static var trailingIcon: Self {Self()}
}
