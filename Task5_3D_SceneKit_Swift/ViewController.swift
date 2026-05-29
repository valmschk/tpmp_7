import UIKit
import SceneKit

class ViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private var scnView: SCNView!
    private var scnScene: SCNScene!
    private var cameraNode: SCNNode!
    private var torusNode: SCNNode!
    
    private let pinchGesture = UIPinchGestureRecognizer()
    private let statusLabel = UILabel()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScene()
        setupCamera()
        setupLights()
        setupTorus()
        setupGestures()
        setupLabel()
        startAutoRotation()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scnView.frame = view.bounds
        statusLabel.frame = CGRect(x: 20, y: 60, width: view.bounds.width - 40, height: 80)
    }
    
    // MARK: - Setup Scene
    
    private func setupScene() {
        scnView = SCNView(frame: view.bounds)
        scnView.backgroundColor = UIColor.black
        scnView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(scnView)
        
        // Создаем сцену
        scnScene = SCNScene()
        scnView.scene = scnScene
        
        // Включаем управление камерой (вращение обзора стандартными жестами)
        scnView.allowsCameraControl = true
        
        // Включаем статистику FPS (опционально, для отладки)
        scnView.showsStatistics = true
        
        // Включаем отражения и тени
        scnView.autoenablesDefaultLighting = false
    }
    
    // MARK: - Camera
    
    private func setupCamera() {
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        
        // Отодвигаем камеру по оси Z на 20 единиц
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 20)
        
        scnScene.rootNode.addChildNode(cameraNode)
    }
    
    // MARK: - Lights (Освещение)
    
    private func setupLights() {
        // 1. Направленный свет (имитирует солнце)
        let directionalLight = SCNLight()
        directionalLight.type = .directional
        directionalLight.color = UIColor.white
        directionalLight.intensity = 1000
        
        let directionalNode = SCNNode()
        directionalNode.light = directionalLight
        directionalNode.eulerAngles = SCNVector3(x: -Float.pi / 4, y: Float.pi / 4, z: 0)
        scnScene.rootNode.addChildNode(directionalNode)
        
        // 2. Окружающий свет (мягкая подсветка, чтобы тени не были черными)
        let ambientLight = SCNLight()
        ambientLight.type = .ambient
        ambientLight.color = UIColor.systemMint
        ambientLight.intensity = 300
        
        let ambientNode = SCNNode()
        ambientNode.light = ambientLight
        scnScene.rootNode.addChildNode(ambientNode)
        
        // 3. Дополнительный точечный свет спереди
        let fillLight = SCNLight()
        fillLight.type = .omni
        fillLight.color = UIColor.white
        fillLight.intensity = 200
        
        let fillNode = SCNNode()
        fillNode.light = fillLight
        fillNode.position = SCNVector3(x: 0, y: 5, z: 10)
        scnScene.rootNode.addChildNode(fillNode)
    }
    
    // MARK: - 3D Object (Тор)
    
    private func setupTorus() {
        // Создаем геометрию тора (кольца)
        // radius: радиус тора, ringRadius: толщина кольца
        let torus = SCNTorus(ringRadius: 3.5, pipeRadius: 0.8)
        
        // Материал: красный с металлическим блеском
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.systemRed
        material.specular.contents = UIColor.white
        material.shininess = 0.8
        material.metalness.contents = 0.7
        material.roughness.contents = 0.3
        
        torus.materials = [material]
        
        // Создаем узел с геометрией
        torusNode = SCNNode(geometry: torus)
        torusNode.position = SCNVector3(x: 0, y: 0, z: 0)
        
        scnScene.rootNode.addChildNode(torusNode)
    }
    
    // MARK: - Auto Rotation (автоматическое вращение)
    
    private func startAutoRotation() {
        // Бесконечное вращение вокруг оси Y
        let rotationAction = SCNAction.rotateBy(x: 0, y: 2, z: 0, duration: 1)
        let foreverRotation = SCNAction.repeatForever(rotationAction)
        torusNode.runAction(foreverRotation)
    }
    
    // MARK: - Gestures (Pinch для масштабирования объекта)
    
    private func setupGestures() {
        pinchGesture.addTarget(self, action: #selector(handlePinch))
        scnView.addGestureRecognizer(pinchGesture)
    }
    
    @objc private func handlePinch(_ gesture: UIPinchGestureRecognizer) {
        // HitTest: пускаем луч из точки касания в 3D-сцену
        let location = gesture.location(in: scnView)
        let hitResults = scnView.hitTest(location, options: nil)
        
        // Проверяем, попали ли мы в наш тор
        if let hitNode = hitResults.first?.node, hitNode == torusNode {
            let scale = Float(gesture.scale)
            
            // Масштабируем узел
            torusNode.scale = SCNVector3(
                x: torusNode.scale.x * scale,
                y: torusNode.scale.y * scale,
                z: torusNode.scale.z * scale
            )
            
            // Сбрасываем scale жеста для плавного продолжения
            gesture.scale = 1.0
            
            // Обновляем статус
            statusLabel.text = " Масштаб: \(String(format: "%.2f", torusNode.scale.x))"
            statusLabel.backgroundColor = UIColor.black.withAlphaComponent(0.7)
            
            // Сбрасываем текст через 1.5 секунды
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
                self?.statusLabel.text = " Вращайте камеру двумя пальцами |  Пинч для масштаба"
            }
        }
    }
    
    // MARK: - Label (информация для пользователя)
    
    private func setupLabel() {
        statusLabel.textAlignment = .center
        statusLabel.numberOfLines = 0
        statusLabel.font = .systemFont(ofSize: 14, weight: .medium)
        statusLabel.textColor = .white
        statusLabel.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        statusLabel.layer.cornerRadius = 12
        statusLabel.layer.masksToBounds = true
        statusLabel.text = " Вращайте камеру двумя пальцами |  Пинч для масштаба"
        view.addSubview(statusLabel)
    }
}
