#if !TARGET_OS_ANDROID
import SwiftUI
import SceneKit

struct IOSNative3DView: UIViewRepresentable {
    let inProgressCount: Int
    let doneCount: Int

    func makeUIView(context: Context) -> SCNView {
        let scnView = SCNView()
        scnView.allowsCameraControl = false
        scnView.autoenablesDefaultLighting = true
        scnView.backgroundColor = .clear
        scnView.scene = makeScene()
        return scnView
    }

    func updateUIView(_ uiView: SCNView, context: Context) {
        uiView.scene = makeScene()
    }

    private func makeScene() -> SCNScene {
        let scene = SCNScene()
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(0, 1.0, 4)
        cameraNode.eulerAngles = SCNVector3(-0.12, 0, 0)
        scene.rootNode.addChildNode(cameraNode)
        let data: [(count: Int, color: UIColor, x: Float)] = [
            (inProgressCount, UIColor(red: 0.10, green: 0.55, blue: 1.0,  alpha: 1), -1.0),
            (doneCount,       UIColor(red: 0.20, green: 0.85, blue: 0.45, alpha: 1),  1.0),
        ]
        let maxCount = max(data.map { $0.count }.max() ?? 1, 1)
        for item in data {
            let height = CGFloat(max(item.count, 1)) / CGFloat(maxCount) * 1.8
            let box = SCNBox(width: 0.8, height: height, length: 0.8, chamferRadius: 0.06)
            let mat = SCNMaterial()
            mat.diffuse.contents = item.color
            box.materials = [mat]
            let node = SCNNode(geometry: box)
            node.position = SCNVector3(item.x, Float(height) / 2, 0)
            scene.rootNode.addChildNode(node)
        }
        return scene
    }
}
#endif
