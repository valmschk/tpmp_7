import UIKit

struct ShapeGeometry {
    
    // MARK: - Равносторонний треугольник
    
    static func trianglePath(center: CGPoint, sideLength: CGFloat) -> UIBezierPath {
        let height = sideLength * sqrt(3) / 2
        
        let topPoint = CGPoint(x: center.x, y: center.y - height * 2 / 3)
        let leftPoint = CGPoint(x: center.x - sideLength / 2, y: center.y + height / 3)
        let rightPoint = CGPoint(x: center.x + sideLength / 2, y: center.y + height / 3)
        
        let path = UIBezierPath()
        path.move(to: topPoint)
        path.addLine(to: leftPoint)
        path.addLine(to: rightPoint)
        path.close()
        
        return path
    }
    
    // MARK: - Октаграмма (8-конечная звезда)
    
    static func octagramPath(center: CGPoint, outerRadius: CGFloat, innerRadius: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        let numberOfPoints = 16
        let angleStep = 2 * CGFloat.pi / CGFloat(numberOfPoints)
        var startAngle: CGFloat = -CGFloat.pi / 2
        
        for i in 0..<numberOfPoints {
            let angle = startAngle + CGFloat(i) * angleStep
            let radius: CGFloat = (i % 2 == 0) ? outerRadius : innerRadius
            let x = center.x + radius * cos(angle)
            let y = center.y + radius * sin(angle)
            
            if i == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        path.close()
        
        return path
    }
    
    // MARK: - Вычитание (Even-Odd)
    
    static func combinedPathSubtract(triangleCenter: CGPoint, sideLength: CGFloat,
                                      starCenter: CGPoint, outerRadius: CGFloat, innerRadius: CGFloat) -> UIBezierPath {
        let triangle = trianglePath(center: triangleCenter, sideLength: sideLength)
        let star = octagramPath(center: starCenter, outerRadius: outerRadius, innerRadius: innerRadius)
        
        let combined = UIBezierPath()
        combined.append(triangle)
        combined.append(star)
        combined.usesEvenOddFillRule = true
        
        return combined
    }
    
    // MARK: - Объединение
    
    static func combinedPathUnion(triangleCenter: CGPoint, sideLength: CGFloat,
                                   starCenter: CGPoint, outerRadius: CGFloat, innerRadius: CGFloat) -> UIBezierPath {
        let triangle = trianglePath(center: triangleCenter, sideLength: sideLength)
        let star = octagramPath(center: starCenter, outerRadius: outerRadius, innerRadius: innerRadius)
        
        let combined = UIBezierPath()
        combined.append(triangle)
        combined.append(star)
        
        return combined
    }
}
