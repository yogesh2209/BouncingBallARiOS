//
//  ViewController.swift
//  ARKitTutorial1
//
//  Created by Yogesh Kohli on 6/11/18.
//  Copyright © 2018 Yogesh Kohli. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    var ballNode = SCNNode()
    var anchors: [ARAnchor] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // setupViews()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViews()
        //if let ballImage = "⚽".image() {
       
       // }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if anchors.count > 1 {
            startBouncing()
            return
        }
        
        if let currentFrame = sceneView.session.currentFrame {
            var translation = matrix_identity_float4x4
            translation.columns.3.z = -0.3
            let transform = simd_mul(currentFrame.camera.transform, translation)
            let anchor = ARAnchor(transform: transform)
            sceneView.session.add(anchor: anchor)
            anchors.append(anchor)
        }
    }
    
    //Load views
    func setupViews() {
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
        sceneView.delegate = self
         ballNode = make2DNode(image: #imageLiteral(resourceName: "yellow"))
    }
    
    func startBouncing(){
        guard let first = anchors.first, let start = sceneView.node(for: first),
              let last = anchors.last, let end = sceneView.node(for: last)
            else { return }
        
        if ballNode.parent == nil {
            sceneView.scene.rootNode.addChildNode(ballNode)
        }
        
        let animation = CABasicAnimation(keyPath: #keyPath(SCNNode.transform))
        animation.fromValue = start.transform
        animation.toValue = end.transform
        animation.autoreverses = true
        animation.duration = 1
        animation.repeatCount = .infinity
        ballNode.removeAllAnimations()
        ballNode.addAnimation(animation, forKey: nil)
    }
    
    func make2DNode(image: UIImage, width: CGFloat = 0.1, height: CGFloat = 0.1) -> SCNNode {
        let plane = SCNPlane(width: width, height: height)
        plane.firstMaterial?.diffuse.contents = image
        let node = SCNNode(geometry: plane)
        node.constraints = [SCNBillboardConstraint()]
        
        return node
    }
    
    // MARK: SceneView Delegates
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
     //   if let runningManEmoji = "🏃".image() {
            let player = make2DNode(image: #imageLiteral(resourceName: "paddlered"))
            node.addChildNode(player)
     //   }
    }
}

