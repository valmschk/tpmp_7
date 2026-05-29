import UIKit

class ViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private let shapeContainerA = UIView()
    private let shapeContainerB = UIView()
    private let shapeContainerC = UIView()
    
    private let shapeA = UIView()
    private let shapeB = UIView()
    private let shapeC = UIView()
    
    private let statusLabel = UILabel()
    private let tapGesture = UITapGestureRecognizer()
    
    private var animationIndex = 0
    private let animationsCount = 3
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupGesture()
        prepareForDrawing()
        runAnimationForCurrentState()
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        view.backgroundColor = .white
        
        // Текст-подсказка
        statusLabel.frame = CGRect(x: 20, y: 60, width: view.bounds.width - 40, height: 80)
        statusLabel.textAlignment = .center
        statusLabel.numberOfLines = 0
        statusLabel.font = .systemFont(ofSize: 16, weight: .medium)
        statusLabel.textColor = .darkGray
        view.addSubview(statusLabel)
        
        // Контейнер A (смещение + поворот)
        shapeContainerA.frame = CGRect(x: 50, y: 180, width: 100, height: 100)
        shapeA.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        shapeA.backgroundColor = .systemBlue
        shapeA.layer.cornerRadius = 12
        shapeContainerA.addSubview(shapeA)
        view.addSubview(shapeContainerA)
        
        // Контейнер B (прозрачность)
        shapeContainerB.frame = CGRect(x: 200, y: 180, width: 100, height: 100)
        shapeB.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        shapeB.backgroundColor = .systemGreen
        shapeB.layer.cornerRadius = 50  // Круг
        shapeContainerB.addSubview(shapeB)
        view.addSubview(shapeContainerB)
        
        // Контейнер C (вращение + масштаб)
        shapeContainerC.frame = CGRect(x: 125, y: 400, width: 100, height: 100)
        shapeC.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        shapeC.backgroundColor = .systemOrange
        shapeC.layer.cornerRadius = 12
        shapeContainerC.addSubview(shapeC)
        view.addSubview(shapeContainerC)
    }
    
    private func setupGesture() {
        tapGesture.addTarget(self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Сброс перед анимацией (важно для памяти!)
    
    private func prepareForDrawing() {
        // Останавливаем все текущие анимации
        shapeContainerA.layer.removeAllAnimations()
        shapeContainerB.layer.removeAllAnimations()
        shapeContainerC.layer.removeAllAnimations()
        
        // Сбрасываем трансформации в исходное состояние
        shapeContainerA.transform = .identity
        shapeContainerB.transform = .identity
        shapeContainerC.transform = .identity
        
        // Сбрасываем прозрачность
        shapeContainerB.alpha = 1.0
        
        // Возвращаем цвета
        shapeA.backgroundColor = .systemBlue
        shapeB.backgroundColor = .systemGreen
        shapeC.backgroundColor = .systemOrange
    }
    
    // MARK: - Анимации
    
    private func runAnimationForCurrentState() {
        prepareForDrawing()
        
        switch animationIndex {
        case 0:
            runScenario1()
            statusLabel.text = "🎬 Сценарий 1: Наложение эффектов\n(смещение вверх + поворот на 45°)"
        case 1:
            runScenario2()
            statusLabel.text = "🎬 Сценарий 2: Бесконечная анимация\n(прозрачность + пульсация с autoreverse)"
        case 2:
            runScenario3()
            statusLabel.text = "🎬 Сценарий 3: Вращение + Масштаб\n(поворот на 180° и уменьшение до 70%)"
        default:
            break
        }
    }
    
    // СЦЕНАРИЙ 1: Наложение эффектов (concatenating)
    private func runScenario1() {
        // Создаем две отдельные трансформации
        let move = CGAffineTransform(translationX: 0, y: -40)
        let rotate = CGAffineTransform(rotationAngle: .pi / 4)  // 45 градусов
        
        // Склеиваем их в одну матрицу
        let combinedTransform = move.concatenating(rotate)
        
        UIView.animate(withDuration: 1.5, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.shapeContainerA.transform = combinedTransform
        }, completion: nil)
        
        // Для контейнера B: анимация прозрачности
        UIView.animate(withDuration: 1.5, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.shapeContainerB.alpha = 0.2
        }, completion: nil)
    }
    
    // СЦЕНАРИЙ 2: Бесконечное движение (repeat + autoreverse)
    private func runScenario2() {
        // Анимация прозрачности туда-обратно
        UIView.animate(withDuration: 2.0, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.shapeContainerB.alpha = 0.2
        }, completion: nil)
        
        // Анимация смещения вверх-вниз
        UIView.animate(withDuration: 1.8, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.shapeContainerA.transform = CGAffineTransform(translationX: 0, y: -50)
        }, completion: nil)
    }
    
    // СЦЕНАРИЙ 3: Вращение и масштаб
    private func runScenario3() {
        let rotate = CGAffineTransform(rotationAngle: .pi)      // 180 градусов
        let scale = CGAffineTransform(scaleX: 0.7, y: 0.7)      // 70% от размера
        
        let combinedTransform = rotate.concatenating(scale)
        
        UIView.animate(withDuration: 1.5, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.shapeContainerC.transform = combinedTransform
        }, completion: nil)
        
        // Дополнительно: плавное изменение цвета фона контейнера C
        UIView.animate(withDuration: 1.5, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.shapeC.backgroundColor = .systemRed
        }, completion: nil)
    }
    
    // MARK: - Actions
    
    @objc private func handleTap() {
        animationIndex = (animationIndex + 1) % animationsCount
        runAnimationForCurrentState()
    }
}
