import UIKit

class ShapesGestureView: UIView {
    
    // MARK: - Свойства (сохраняем слои для быстрой смены фона)
    
    private let triangleLayer = CAShapeLayer()
    private let octagramLayer = CAShapeLayer()
    
    // MARK: - Инициализация
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
    }
    
    private func setupLayers() {
        backgroundColor = .white
        
        // Настройка слоя треугольника
        triangleLayer.fillColor = UIColor.systemPurple.cgColor
        triangleLayer.strokeColor = UIColor.darkGray.cgColor
        triangleLayer.lineWidth = 2
        triangleLayer.shadowColor = UIColor.black.cgColor
        triangleLayer.shadowOpacity = 0.2
        triangleLayer.shadowOffset = CGSize(width: 3, height: 3)
        triangleLayer.shadowRadius = 4
        
        // Настройка слоя октаграммы
        octagramLayer.fillColor = UIColor.systemPink.cgColor
        octagramLayer.strokeColor = UIColor.darkGray.cgColor
        octagramLayer.lineWidth = 2
        octagramLayer.shadowColor = UIColor.black.cgColor
        octagramLayer.shadowOpacity = 0.2
        octagramLayer.shadowOffset = CGSize(width: 3, height: 3)
        octagramLayer.shadowRadius = 4
        
        layer.addSublayer(triangleLayer)
        layer.addSublayer(octagramLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Треугольник (слева)
        let trianglePath = ShapeTheme.trianglePath(
            center: CGPoint(x: bounds.width * 0.35, y: bounds.midY),
            sideLength: 160
        )
        triangleLayer.path = trianglePath.cgPath
        
        // Октаграмма (справа)
        let octagramPath = ShapeTheme.octagramPath(
            center: CGPoint(x: bounds.width * 0.7, y: bounds.midY),
            outerRadius: 80,
            innerRadius: 35
        )
        octagramLayer.path = octagramPath.cgPath
    }
    
    // MARK: - КЛЮЧЕВОЙ МЕТОД: смена фона без перерисовки геометрии
    
    /// Меняет текстуру (fillColor) для обеих фигур
    func updateBackgrounds(to textureIndex: Int) {
        let texture = ShapeTheme.getTexture(for: textureIndex)
        
        // Меняем цвет заливки у существующих слоев
        // Это мгновенно и не требует перерисовки пути!
        triangleLayer.fillColor = texture.cgColor
        octagramLayer.fillColor = texture.cgColor
    }
    
    /// Очистка (если нужна)
    func resetBackgrounds() {
        triangleLayer.fillColor = UIColor.systemPurple.cgColor
        octagramLayer.fillColor = UIColor.systemPink.cgColor
    }
}
