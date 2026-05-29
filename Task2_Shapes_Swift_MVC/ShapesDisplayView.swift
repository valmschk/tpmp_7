import UIKit

class ShapesDisplayView: UIView {
    
    private var currentShapeLayer: CAShapeLayer?
    private var currentGradientLayer: CAGradientLayer?
    
    private let purplePinkGradient: [CGColor] = [
        UIColor.systemPurple.cgColor,
        UIColor.systemPink.cgColor
    ]
    
    private let grayGradient: [CGColor] = [
        UIColor.lightGray.cgColor,
        UIColor.darkGray.cgColor
    ]
    
    // Раздельное отображение
    func drawSeparateShapes() {
        clearLayers()
        
        let trianglePath = ShapeGeometry.trianglePath(
            center: CGPoint(x: bounds.width * 0.3, y: bounds.midY),
            sideLength: 150
        )
        addShapeLayer(with: trianglePath, gradient: purplePinkGradient, shadow: true)
        
        let starPath = ShapeGeometry.octagramPath(
            center: CGPoint(x: bounds.width * 0.7, y: bounds.midY),
            outerRadius: 70,
            innerRadius: 30
        )
        addShapeLayer(with: starPath, gradient: purplePinkGradient, shadow: true)
    }
    
    // Вычитание
    func drawSubtractedShape() {
        clearLayers()
        
        let combinedPath = ShapeGeometry.combinedPathSubtract(
            triangleCenter: CGPoint(x: bounds.midX, y: bounds.midY),
            sideLength: 200,
            starCenter: CGPoint(x: bounds.midX, y: bounds.midY),
            outerRadius: 70,
            innerRadius: 30
        )
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = combinedPath.cgPath
        shapeLayer.fillRule = .evenOdd
        shapeLayer.fillColor = UIColor.systemPurple.cgColor
        
        addShadow(to: shapeLayer)
        layer.addSublayer(shapeLayer)
        currentShapeLayer = shapeLayer
    }
    
    // Объединение
    func drawUnionShape() {
        clearLayers()
        
        let combinedPath = ShapeGeometry.combinedPathUnion(
            triangleCenter: CGPoint(x: bounds.midX, y: bounds.midY - 20),
            sideLength: 180,
            starCenter: CGPoint(x: bounds.midX, y: bounds.midY + 30),
            outerRadius: 65,
            innerRadius: 28
        )
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = combinedPath.cgPath
        maskLayer.fillColor = UIColor.black.cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = grayGradient
        gradientLayer.mask = maskLayer
        
        addShadow(to: maskLayer)
        layer.addSublayer(gradientLayer)
        
        currentGradientLayer = gradientLayer
        currentShapeLayer = maskLayer
    }
    
    // MARK: - Вспомогательные методы
    
    private func addShapeLayer(with path: UIBezierPath, gradient colors: [CGColor], shadow: Bool) {
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        maskLayer.fillColor = UIColor.black.cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        gradientLayer.mask = maskLayer
        
        if shadow {
            addShadow(to: maskLayer)
        }
        
        layer.addSublayer(gradientLayer)
        currentGradientLayer = gradientLayer
        currentShapeLayer = maskLayer
    }
    
    private func addShadow(to layer: CALayer) {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 5, height: 5)
        layer.shadowRadius = 8
    }
    
    private func clearLayers() {
        currentShapeLayer?.removeFromSuperlayer()
        currentGradientLayer?.removeFromSuperlayer()
        currentShapeLayer = nil
        currentGradientLayer = nil
    }
}
