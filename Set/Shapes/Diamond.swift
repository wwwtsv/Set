//
//  Diamond.swift
//  Set
//
//  Created by Алексей Цветков on 5/30/22.
//

import SwiftUI

struct Diamond: Shape {
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let area = min(rect.width, rect.height) / 2
        
        let leftCoord = CGPoint(x: center.x - area, y: center.y)
        let rightCoord = CGPoint(x: center.x + area, y: center.y)
        let topCoord = CGPoint(x: center.x, y: center.y + area / 2)
        let bottomCoord = CGPoint(x: center.x, y: center.y - area / 2)
        
        var p = Path()
        p.move(to: leftCoord)
        p.addLine(to: bottomCoord)
        p.addLine(to: rightCoord)
        p.addLine(to: topCoord)
        p.addLine(to: leftCoord)
        
        return p
    }

}
