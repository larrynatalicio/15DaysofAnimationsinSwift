//
//  SwiftExtensions.swift
//  PullToRefreshAnimation
//
//  Created by Larry Natalicio on 4/25/16.
//  Copyright © 2016 Larry Natalicio. All rights reserved.
//

import UIKit

extension CGPath {
    func forEach(@noescape body: @convention(block) (CGPathElement) -> Void) {
        typealias Body = @convention(block) (CGPathElement) -> Void
        func callback(info: UnsafeMutablePointer<Void>, element: UnsafePointer<CGPathElement>) {
            let body = unsafeBitCast(info, Body.self)
            body(element.memory)
        }
        let unsafeBody = unsafeBitCast(body, UnsafeMutablePointer<Void>.self)
        CGPathApply(self, unsafeBody, callback)
    }
}

/* 
 Finds the first point in a path. Uses the CGPath extension created above.
 This is used to add the flying-saucer image at the beginning of
 the path it will animate on.
 */
extension UIBezierPath {
    func firstPoint() -> CGPoint? {
        var firstPoint: CGPoint? = nil
        
        self.CGPath.forEach { element in
            // Just want the first one, but we have to look at everything.
            guard firstPoint == nil else { return }
            assert(element.type == .MoveToPoint, "Expected the first point to be a move")
            firstPoint = element.points.memory
        }
        return firstPoint
    }
}

