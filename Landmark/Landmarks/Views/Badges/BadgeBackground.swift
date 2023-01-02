//
//  BadgeBackground.swift
//  Landmarks
//
//  Created by HA on 2022/03/05.
//

import SwiftUI

struct BadgeBackground: View {
    var body: some View {
        GeometryReader{ geometry in
        Path { path in
            var width: CGFloat = min(geometry.size.width,  geometry.size.height)
            let height = width
            let xScale: CGFloat = 0.832
            let xOffset = (width * (1.0 - xScale)) / 2.0
            width *= xScale
            path.move( //move(to:) 메소드는 모양의 영역에서 마우스를 가져가는것 처럼 그리기커서 이동
                to: CGPoint(
                    x: width * 0.95 + xOffset,
                    y: height * (0.20 + HexagonParameters.adjustment)
                )
            )
            
            HexagonParameters.segments.forEach{ segment in path.addLine(
                    to: CGPoint(
                        x: width * segment.line.x + xOffset,
                        y: height * segment.line.y
                    )
                )
                
                path.addQuadCurve(
                    to: CGPoint(
                        x: width * segment.curve.x + xOffset,
                        y: height * segment.curve.y
                    ),
                    control: CGPoint(
                        x: width * segment.control.x + xOffset,
                        y: height * segment.control.y
                    )
                )
            }
        }
        .fill(.linearGradient(
            Gradient(colors: [Self.gradientStart, Self.gradientEnd]),
            startPoint: UnitPoint(x:0.5, y: 0),
            endPoint: UnitPoint(x:0.5, y: 0.6)
        ))
        }
        .aspectRatio(1, contentMode: .fit) // 1:1 종횡비 유지. 정사각형모양
    }
    static let gradientStart = Color(red: 239.0 / 255, green: 120.0 / 255, blue: 221.0 / 255)
    static let gradientEnd = Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 255)
}

struct BadgeBackground_Previews: PreviewProvider {
    static var previews: some View {
        BadgeBackground()
    }
}
