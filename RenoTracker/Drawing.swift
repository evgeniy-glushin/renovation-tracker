//
//  Drawing.swift
//  RenoTracker
//
//  Created by User on 18.01.2023.
//

import SwiftUI

struct Drawing: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            let width: CGFloat = rect.width
            let height: CGFloat = rect.height
            
            path.move(to: CGPoint(x: 0, y: height))
            
            path.addLine(to: CGPoint(x: width, y: height))
            path.addLine(to: CGPoint(x: 0.5 * width, y: 0))
            path.addLine(to: CGPoint(x: 0, y: height))
        }
    }
    
}

struct Drawing_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            
            
            Drawing()
                .stroke(Color.green, lineWidth: 1)
                .frame(width: 50, height: 50)
            //    .border(.pink)
            
            // Spacer()
        }
        
    }
}
