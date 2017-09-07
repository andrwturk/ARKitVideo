//
//  ViewController.swift
//  ARKitTest
//
//  Created by Andrew Turkin on 8/27/17.
//  Copyright © 2017 Andrew Turkin. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    let videoURL = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
    struct AspectRatio {
        static let width: CGFloat = 320
        static let height: CGFloat = 240
    }
    let AspectDiv: CGFloat = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create AVPlayer
        let player = AVPlayer(url: videoURL!)
        // place AVPlayer on SKVideoNode
        let playerNode = SKVideoNode(avPlayer: player)
        // flip video upside down
        playerNode.yScale = -1
        
        // create SKScene and set player node on it
        let spriteKitScene = SKScene(size: CGSize(width: AspectRatio.width, height: AspectRatio.height))
        spriteKitScene.scaleMode = .aspectFit
        playerNode.position = CGPoint(x: spriteKitScene.size.width/2, y: spriteKitScene.size.height/2)
        playerNode.size = spriteKitScene.size
        spriteKitScene.addChild(playerNode)
        
        // create 3D SCNNode and set SKScene as a material
        let videoNode = SCNNode()
        videoNode.geometry = SCNPlane(width: 0.2, height: 0.1)
        videoNode.geometry?.firstMaterial?.diffuse.contents = spriteKitScene
        videoNode.geometry?.firstMaterial?.isDoubleSided = true
        // place SCNNode inside ARKit 3D coordinate space
        videoNode.position = SCNVector3(x: 0, y: 0, z: -0.5)
        
        // create a new scene
        let scene = SCNScene()
        scene.rootNode.addChildNode(videoNode)
        // set the scene to the view
        sceneView.scene = scene
        playerNode.play()
    }
}
