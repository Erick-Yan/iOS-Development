/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view that displays the background of a badge.
*/

import SwiftUI

struct BadgeBackground: View {
    var body: some View {
        /// GeometryReader enables badge to fill up entire container view.
        GeometryReader { geometry in
            /// Paths can be used to combine lines, curves, and drawing primitives to form complex shapes.
            Path { path in
                var width = min(geometry.size.width, geometry.size.height) /// Necessary to fill width of view.
                let height = width
                /// Below scales shape with offset to recenter.
                let xScale: CGFloat = 0.832
                let xOffset = (width * (1.0 - xScale)) / 2.0
                width *= xScale

                /// move(to:) moves the drawing cursor within the shape bounds like a pen.
                path.move(
                    to: CGPoint(
                        x: width * 0.95 + xOffset,
                        y: height * (0.20 + HexagonParameters.adjustment)
                    )
                )

                HexagonParameters.segments.forEach { segment in
                    /// addLine(to:) methodtakes a single point and draws it. Successive calls form lines between points.
                    path.addLine(
                        to: CGPoint(
                            x: width * segment.line.x + xOffset,
                            y: height * segment.line.y
                        )
                    )

                    /// addQuadCurve adds rounded edges to the hexagon.
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
            /// Fill shape with gradient.
            .fill(.linearGradient(
                Gradient(colors: [Self.gradientStart, Self.gradientEnd]),
                startPoint: UnitPoint(x: 0.5, y: 0),
                endPoint: UnitPoint(x: 0.5, y: 0.6)
            ))
        }
        .aspectRatio(1, contentMode: .fit)
    }
    static let gradientStart = Color(red: 239.0 / 255, green: 120.0 / 255, blue: 221.0 / 255)
    static let gradientEnd = Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 255)
}

struct BadgeBackground_Previews: PreviewProvider {
    static var previews: some View {
        BadgeBackground()
    }
}
