import UIKit

class ViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private let gestureView = ShapesGestureView()
    private let gestureLabel = UILabel()
    
    // MARK: - 5 распознавателей жестов
    
    private let rotationGesture = UIRotationGestureRecognizer()
    private let pinchGesture = UIPinchGestureRecognizer()
    private let tapGesture = UITapGestureRecognizer()
    private let longPressGesture = UILongPressGestureRecognizer()
    private let swipeGesture = UISwipeGestureRecognizer()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupGestures()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gestureView.frame = view.bounds
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        view.backgroundColor = .white
        
        gestureView.frame = view.bounds
        gestureView.backgroundColor = .white
        view.addSubview(gestureView)
        
        gestureLabel.frame = CGRect(x: 20, y: 80, width: view.bounds.width - 40, height: 80)
        gestureLabel.textAlignment = .center
        gestureLabel.numberOfLines = 0
        gestureLabel.font = .systemFont(ofSize: 16, weight: .medium)
        gestureLabel.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        gestureLabel.layer.cornerRadius = 12
        gestureLabel.layer.masksToBounds = true
        gestureLabel.text = " Выполните жест на фигуре"
        view.addSubview(gestureLabel)
    }
    
    private func setupGestures() {
        // 1. Вращение → Фон 1
        rotationGesture.addTarget(self, action: #selector(handleRotation))
        gestureView.addGestureRecognizer(rotationGesture)
        
        // 2. Пинч (масштабирование) → Фон 2
        pinchGesture.addTarget(self, action: #selector(handlePinch))
        gestureView.addGestureRecognizer(pinchGesture)
        
        // 3. Тап (касание) → Фон 3
        tapGesture.addTarget(self, action: #selector(handleTap))
        tapGesture.numberOfTapsRequired = 1
        gestureView.addGestureRecognizer(tapGesture)
        
        // 4. Долгое нажатие → Фон 4
        longPressGesture.addTarget(self, action: #selector(handleLongPress))
        longPressGesture.minimumPressDuration = 0.5
        gestureView.addGestureRecognizer(longPressGesture)
        
        // 5. Свайп (смахивание) → Фон 5
        swipeGesture.addTarget(self, action: #selector(handleSwipe))
        swipeGesture.direction = .right
        gestureView.addGestureRecognizer(swipeGesture)
        
        // Включаем возможность взаимодействия (для UILabel это не нужно, но для View - да)
        gestureView.isUserInteractionEnabled = true
    }
    
    // MARK: - Обработчики жестов
    
    @objc private func handleRotation(_ gesture: UIRotationGestureRecognizer) {
        if gesture.state == .began {
            gestureView.updateBackgrounds(to: 1)
            gestureLabel.text = " Жест: ВРАЩЕНИЕ → Фон 1 (клетка)"
            gestureLabel.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.2)
            
            // Через 2 секунды сбрасываем подсказку
            resetLabelAfterDelay()
        }
    }
    
    @objc private func handlePinch(_ gesture: UIPinchGestureRecognizer) {
        if gesture.state == .began {
            gestureView.updateBackgrounds(to: 2)
            gestureLabel.text = " Жест: ПИНЧ (масштабирование) → Фон 2 (точки)"
            gestureLabel.backgroundColor = UIColor.systemRed.withAlphaComponent(0.2)
            resetLabelAfterDelay()
        }
    }
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        gestureView.updateBackgrounds(to: 3)
        gestureLabel.text = " Жест: ТАП (касание) → Фон 3 (цветочный)"
        gestureLabel.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.2)
        resetLabelAfterDelay()
    }
    
    @objc private func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            gestureView.updateBackgrounds(to: 4)
            gestureLabel.text = " Жест: ДОЛГОЕ НАЖАТИЕ → Фон 4 (листья)"
            gestureLabel.backgroundColor = UIColor.systemOrange.withAlphaComponent(0.2)
            resetLabelAfterDelay()
        }
    }
    
    @objc private func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        gestureView.updateBackgrounds(to: 5)
        gestureLabel.text = " Жест: СВАЙП (смахивание) → Фон 5 (темный узор)"
        gestureLabel.backgroundColor = UIColor.systemGray.withAlphaComponent(0.2)
        resetLabelAfterDelay()
    }
    
    // MARK: - Вспомогательные методы
    
    private func resetLabelAfterDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.gestureLabel.text = " Выполните жест на фигуре"
            self?.gestureLabel.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        }
    }
}
