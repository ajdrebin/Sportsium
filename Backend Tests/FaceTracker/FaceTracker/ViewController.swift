//
//  ViewController.swift
//  humanTracker
//
//  Created by Anurag Ajwani on 08/05/2019.
//  Copyright © 2019 Anurag Ajwani. All rights reserved.
//

import UIKit
import AVFoundation
import Vision

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    private let captureSession = AVCaptureSession()
    private lazy var previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
    private let videoDataOutput = AVCaptureVideoDataOutput()
    private var drawings: [CAShapeLayer] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addCameraInput()
        self.showCameraFeed()
        self.getCameraFrames()
        self.captureSession.startRunning()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.previewLayer.frame = self.view.frame
    }
    
    func captureOutput(
        _ output: AVCaptureOutput,
        didOutput sampleBuffer: CMSampleBuffer,
        from connection: AVCaptureConnection) {
        
        guard let frame = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            debugPrint("unable to get image from sample buffer")
            return
        }
        self.detecthuman(in: frame)
    }
    
    private func addCameraInput() {
        guard let device = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.builtInWideAngleCamera, .builtInDualCamera, .builtInTrueDepthCamera],
            mediaType: .video,
            position: .back).devices.first else {
                fatalError("No back camera device found, please make sure to run SimpleLaneDetection in an iOS device and not a simulator")
        }
        let cameraInput = try! AVCaptureDeviceInput(device: device)
        self.captureSession.addInput(cameraInput)
    }
    
    private func showCameraFeed() {
        self.previewLayer.videoGravity = .resizeAspectFill
        self.view.layer.addSublayer(self.previewLayer)
        self.previewLayer.frame = self.view.frame
    }
    
    private func getCameraFrames() {
        self.videoDataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString) : NSNumber(value: kCVPixelFormatType_32BGRA)] as [String : Any]
        self.videoDataOutput.alwaysDiscardsLateVideoFrames = true
        self.videoDataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "camera_frame_processing_queue"))
        self.captureSession.addOutput(self.videoDataOutput)
        guard let connection = self.videoDataOutput.connection(with: AVMediaType.video),
            connection.isVideoOrientationSupported else { return }
        connection.videoOrientation = .portrait
    }
    
    private func detecthuman(in image: CVPixelBuffer) {
        let humanDetectionRequest = VNDetectHumanRectanglesRequest(completionHandler: { (request: VNRequest, error: Error?) in
            DispatchQueue.main.async {
                if let results = request.results as? [VNDetectedObjectObservation] {
//                    print("did detect \(results.count) human(s)")
                    self.handleHumanDetectionResults(results)
                } else {
                    self.clearDrawings()
//                    print("no humans detected")
                }
            }
        })
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: image, orientation: .leftMirrored, options: [:])
        try? imageRequestHandler.perform([humanDetectionRequest])
    }
    
    private func handleHumanDetectionResults(_ observedhumans: [VNDetectedObjectObservation]) {
        self.clearDrawings()
        let humansBoundingBoxes: [CAShapeLayer] = observedhumans.map({ (observedhuman: VNDetectedObjectObservation) -> CAShapeLayer in
            let humanBoundingBoxOnScreen = self.previewLayer.layerRectConverted(fromMetadataOutputRect: observedhuman.boundingBox)
            let humanBoundingBoxPath = CGPath(rect: humanBoundingBoxOnScreen, transform: nil)
            let humanBoundingBoxShape = CAShapeLayer()
            humanBoundingBoxShape.path = humanBoundingBoxPath
            humanBoundingBoxShape.fillColor = UIColor.clear.cgColor
            humanBoundingBoxShape.strokeColor = UIColor.green.cgColor
            return humanBoundingBoxShape
        })
        humansBoundingBoxes.forEach({ humanBoundingBox in self.view.layer.addSublayer(humanBoundingBox) })
        self.drawings = humansBoundingBoxes
    }
    
    private func clearDrawings() {
        self.drawings.forEach({ drawing in drawing.removeFromSuperlayer() })
    }
}
