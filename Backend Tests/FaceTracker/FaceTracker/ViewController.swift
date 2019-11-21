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
    
    
    @IBOutlet weak var speedSwitch: UISegmentedControl!
        @IBOutlet weak var camView: UIImageView!
    @IBAction func startButton(_ sender: Any) {
        self.captureSession.startRunning()
    }
    @IBAction func StopButton(_ sender: Any) {
        self.captureSession.stopRunning()
    }
    
    private let captureSession = AVCaptureSession()
    private lazy var previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
    private let videoDataOutput = AVCaptureVideoDataOutput()
    private var drawings: [CAShapeLayer] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addCameraInput()
        self.showCameraFeed()
        self.getCameraFrames()
//        self.captureSession.startRunning()
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
//        self.processImage(in: frame)
//        DispatchQueue.main.async {
//            print("switch: ", self.speedSwitch.selectedSegmentIndex)
//        }
        
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
        
//        self.view.layer.addSublayer(self.previewLayer)
//        self.previewLayer.frame = self.view.frame
        camView.layer.addSublayer(self.previewLayer)
        self.previewLayer.frame = camView.layer.bounds
//        self.previewLayer.videoGravity = .resizeAspect
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
                    self.handleHumanDetectionResults(results, in: image)
//                    print("in between")
//                    self.processImage(in: image)
                    
                } else {
                    self.clearDrawings()
//                    print("no humans detected")
                }
            }
        })
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: image, orientation: .leftMirrored, options: [:])
        try? imageRequestHandler.perform([humanDetectionRequest])
    }
    
    private func handleHumanDetectionResults(_ observedhumans: [VNDetectedObjectObservation], in image: CVPixelBuffer) {
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
        humansBoundingBoxes.forEach({ humanBoundingBox in self.view.layer.addSublayer(humanBoundingBox)
            self.processImage(in: image)
            
            
            
        })
        
       
        self.drawings = humansBoundingBoxes
    }
    
    
    private func clearDrawings() {
        self.drawings.forEach({ drawing in drawing.removeFromSuperlayer() })
    }
    
    
    
    lazy var textDetectionRequestFast: VNRecognizeTextRequest = {
           let request = VNRecognizeTextRequest(completionHandler: self.handleDetectedText)
        let speed = self.speedSwitch.selectedSegmentIndex
            request.recognitionLevel = .fast
           
           request.usesLanguageCorrection = false
//           request.customWords = ["13", "17", "10", "2", "Orlando", "Health"]
           request.recognitionLanguages = ["en_US"]
           return request
       }()
    
    lazy var textDetectionRequestAccurate: VNRecognizeTextRequest = {
               let request = VNRecognizeTextRequest(completionHandler: self.handleDetectedText)
            let speed = self.speedSwitch.selectedSegmentIndex
                request.recognitionLevel = .accurate
               
               request.usesLanguageCorrection = false
    //           request.customWords = ["13", "17", "10", "2", "Orlando", "Health"]
               request.recognitionLanguages = ["en_US"]
               return request
           }()
       
    func processImage(in image: CVPixelBuffer) {
        let speed = self.speedSwitch.selectedSegmentIndex
        var requests = [textDetectionRequestFast]
        if(speed == 0){
            print("using fast")
            requests = [textDetectionRequestFast]
        }
        else{
            print("using accurate")
            requests = [textDetectionRequestAccurate]
        }
//           let requests = [textDetectionRequest]
       let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: image,  options: [:])
//           DispatchQueue.global(qos: .userInitiated).async {
//               do {
//                   try imageRequestHandler.perform(requests)
//               } catch let error {
//                   print("Error: \(error)")
//               }
//           }
         DispatchQueue.main.async {
            do {
                  try imageRequestHandler.perform(requests)
//                  print("and here")
              } catch let error {
                  print("Error: \(error)")
              }
        }
       }
    
    fileprivate func handleDetectedText(request: VNRequest?, error: Error?) {
//        print("in handle detected text")
        if let error = error {
    //        presentAlert(title: "Error", message: error.localizedDescription)
            print("Error: ", error.localizedDescription)
            return
        }
        guard let results = request?.results, results.count > 0 else {
    //        presentAlert(title: "Error", message: "No text was found.")
            print("Error: no text was found")
            return
    }

        print("results: ", results.count)
    for result in results {
        if let observation = result as? VNRecognizedTextObservation {
            for text in observation.topCandidates(1) {
//                let component = ""
//                component.x = observation.boundingBox.origin.x
//                component.y = observation.boundingBox.origin.y
//                component.text = text.string
//                components.append(component)
                print("text:", text.string)
//                print("bounding box: ", observation.boundingBox.origin.x,
//                      observation.boundingBox.origin.y)
//                if(text.string == "7" || text.string == "21" || text.string == "12" || text.string == "15" || text.string == "17"){
//                    print("HIT MOTHEFUCKERS LETS GOOOOOOOOOO")
//                }
                let nums = ["2","4","14", "10","11", "7", "21","24", "12", "15", "17", "20", "23", "16", "6", "8"]
                if(nums.contains(text.string)){
                    print("HIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIT")
                }
            }
        }
        }
    }
    fileprivate func presentAlert(title: String, message: String) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(controller, animated: true, completion: nil)
    }
            
}
