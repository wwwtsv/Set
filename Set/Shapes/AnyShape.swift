//
//  AnyShape.swift
//  Set
//
//  Created by Алексей Цветков on 6/7/22.
//

import SwiftUI

struct AnyShape: InsettableShape {
    init<S: Shape>(_ wrapped: S) {
        _path = { rect in
            let path = wrapped.path(in: rect)
            return path
        }
    }

    func path(in rect: CGRect) -> Path {
        return _path(rect)
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        return self
    }

    private let _path: (CGRect) -> Path
}
