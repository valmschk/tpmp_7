import UIKit

struct ShapeTheme {
    
    // MARK: - Геометрия фигур (как в задании 2)
    
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
    
    // MARK: - Текстуры (НОВИНКА для задания 4)
    
    /// Получить текстуру (UIColor(patternImage:)) по индексу
    /// Вариант 32: 5 разных текстур для 5 жестов
    static func getTexture(for index: Int) -> UIColor {
        let imageName: String
        
        switch index {
        case 1:
            imageName = "texture_grid"      // Жест: Вращение → Фон 1 (клетка)
        case 2:
            imageName = "texture_dots"      // Жест: Пинч → Фон 2 (точки)
        case 3:
            imageName = "texture_flowers"   // Жест: Тап → Фон 3 (цветочный)
        case 4:
            imageName = "texture_leaves"    // Жест: Long Press → Фон 4 (листья)
        case 5:
            imageName = "texture_dark"      // Жест: Свайп → Фон 5 (темный узор)
        default:
            imageName = "texture_grid"
        }
        
        // Загружаем изображение из Assets
        if let image = UIImage(named: imageName) {
            return UIColor(patternImage: image)
        }
        
        // Если изображений нет в Assets, используем цвета-заглушки
        return getFallbackColor(for: index)
    }
    
    /// Цвета-заглушки на случай, если изображения не добавлены в Assets
    static func getFallbackColor(for index: Int) -> UIColor {
        switch index {
        case 1: return UIColor.systemBlue.withAlphaComponent(0.7)
        case 2: return UIColor.systemRed.withAlphaComponent(0.7)
        case 3: return UIColor.systemGreen.withAlphaComponent(0.7)
        case 4: return UIColor.systemOrange.withAlphaComponent(0.7)
        case 5: return UIColor.systemGray.withAlphaComponent(0.7)
        default: return UIColor.systemPurple
        }
    }
}
