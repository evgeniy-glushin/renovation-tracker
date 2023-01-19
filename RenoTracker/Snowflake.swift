
import SwiftUI

struct Snowflake: Shape {
    func path(in rect: CGRect) -> Path {
        
        var (branch, centerX, centerY) = buildBranch(width: rect.width, height: rect.height)
        var snowflake = Path()

        (0..<6).map {
            CGAffineTransform.identity
                .translatedBy(x: centerX, y: centerY)
                .rotated(by: Angle(degrees: Double($0*60)).radians)
                .translatedBy(x: -centerX, y: -centerY)
        }.map { branch.applying($0) }
         .forEach { snowflake.addPath($0) }
        
        return snowflake
    }
     
    private func buildBranch(width: CGFloat, height: CGFloat) -> (Path, CGFloat, CGFloat) {
        let (centerX, centerY) = (width / 2, height / 2)
        let (stemStartX, stemStartY) = (centerX, height * 0.13)
        let (leftStemEndX, leftStemEndY) = (centerX * 0.75, height * 0.03)
        let (rightStemEndX, rightStemEndY) = (centerX * 1.25, height * 0.03)
    
        var branch = Path()
        
        branch.move(to: CGPoint(x: centerX, y: centerY))
        branch.addLine(to: CGPoint(x: centerX, y: 0))
        
        branch.move(to: CGPoint(x: stemStartX, y: stemStartY))
        branch.addLine(to: CGPoint(x: leftStemEndX, y: leftStemEndY))
        
        branch.move(to: CGPoint(x: stemStartX, y: stemStartY))
        branch.addLine(to: CGPoint(x: rightStemEndX, y: rightStemEndY))
        
        return (branch, centerX, centerY)
    }
}

struct Snowflake_Previews: PreviewProvider {
    static var previews: some View {
        Snowflake()
            .stroke(Color.blue, lineWidth: 1)
            .frame(width: 100, height: 100)
            .border(Color.brown)
    }
}
