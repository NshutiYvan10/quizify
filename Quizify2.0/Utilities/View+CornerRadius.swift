//
//  View+CornerRadius.swift
//  Quizify2.0
//
//  Created by Inyambo Auca on 31/07/2025.
//

//import SwiftUI
//
//// This custom view modifier allows you to apply a corner radius to specific corners
//// of a view, which is a common requirement in modern UI design that isn't
//// natively supported by the standard .cornerRadius() modifier.
//extension View {
//    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
//        clipShape(RoundedCorner(radius: radius, corners: corners))
//    }
//}
//
//// The Shape that calculates the path for the specific rounded corners.
//struct RoundedCorner: Shape {
//    var radius: CGFloat = .infinity
//    var corners: UIRectCorner = .allCorners
//
//    func path(in rect: CGRect) -> Path {
//        let path = UIBezierPath(
//            roundedRect: rect,
//            byRoundingCorners: corners,
//            cornerRadii: CGSize(width: radius, height: radius)
//        )
//        return Path(path.cgPath)
//    }
//}


import SwiftUI

// This custom Shape allows applying a corner radius to specific corners of a view.
// This version is compatible with macOS and avoids UIKit dependencies.
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: RectCorner = .allCorners

    // Defines which corners to round.
    struct RectCorner: OptionSet {
        let rawValue: Int

        static let topLeft = RectCorner(rawValue: 1 << 0)
        static let topRight = RectCorner(rawValue: 1 << 1)
        static let bottomLeft = RectCorner(rawValue: 1 << 2)
        static let bottomRight = RectCorner(rawValue: 1 << 3)
        
        static let allCorners: RectCorner = [.topLeft, .topRight, .bottomLeft, .bottomRight]
    }

    // Creates the path for the shape with the specified rounded corners.
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let p1 = CGPoint(x: rect.minX, y: rect.minY)
        let p2 = CGPoint(x: rect.maxX, y: rect.minY)
        let p3 = CGPoint(x: rect.maxX, y: rect.maxY)
        let p4 = CGPoint(x: rect.minX, y: rect.maxY)

        // Top-left corner
        if corners.contains(.topLeft) {
            path.move(to: p1.offsetBy(dx: 0, dy: radius))
            path.addArc(center: p1.offsetBy(dx: radius, dy: radius), radius: radius, startAngle: .degrees(180), endAngle: .degrees(270), clockwise: false)
        } else {
            path.move(to: p1)
        }

        // Top-right corner
        if corners.contains(.topRight) {
            path.addLine(to: p2.offsetBy(dx: -radius, dy: 0))
            path.addArc(center: p2.offsetBy(dx: -radius, dy: radius), radius: radius, startAngle: .degrees(270), endAngle: .degrees(0), clockwise: false)
        } else {
            path.addLine(to: p2)
        }

        // Bottom-right corner
        if corners.contains(.bottomRight) {
            path.addLine(to: p3.offsetBy(dx: 0, dy: -radius))
            path.addArc(center: p3.offsetBy(dx: -radius, dy: -radius), radius: radius, startAngle: .degrees(0), endAngle: .degrees(90), clockwise: false)
        } else {
            path.addLine(to: p3)
        }

        // Bottom-left corner
        if corners.contains(.bottomLeft) {
            path.addLine(to: p4.offsetBy(dx: radius, dy: 0))
            path.addArc(center: p4.offsetBy(dx: radius, dy: -radius), radius: radius, startAngle: .degrees(90), endAngle: .degrees(180), clockwise: false)
        } else {
            path.addLine(to: p4)
        }

        path.closeSubpath()

        return path
    }
}

// A helper extension to make applying the custom corner radius easier.
extension View {
    func cornerRadius(_ radius: CGFloat, corners: RoundedCorner.RectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

// Helper to offset a CGPoint, used in path creation.
fileprivate extension CGPoint {
    func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
        return CGPoint(x: x + dx, y: y + dy)
    }
}
