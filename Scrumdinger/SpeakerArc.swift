//
//  SpeakerArc.swift
//  Scrumdinger
//
//  Created by HA on 2022/07/17.
//

import SwiftUI

struct SpeakerArc: Shape{
    //Add constant properties for speakerIndex and totalSpeakers.
    let speakerIndex: Int
    let totalSpeakers: Int
    
    private var degreePerSpeaker: Double{
        360.0 / Double(totalSpeakers)
    }
    private var startAngle: Angle{
        Angle(degrees: degreePerSpeaker * Double(speakerIndex) + 1.0)
    }
    private var endAngle: Angle{
        Angle(degrees: startAngle.degrees + degreePerSpeaker - 1.0)
    }
    //The Path initializer takes a closure that passes in a path parameter.
    func path(in rect: CGRect)-> Path{
        //The coordinate system contains an origin in the lower left corner, with positive values extending up and to the right.
        let diameter = min(rect.size.width, rect.size.height) - 24.0
        let radius = diameter / 2.0
        //Create a constant to store the center of the rectangle.
        let center = CGPoint(x: rect.midX, y: rect.midY)
        return Path{path in
            path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        }
    }
}
