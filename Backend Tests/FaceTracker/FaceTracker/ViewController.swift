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
import Foundation
import Accelerate
import CoreImage

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var speedSwitch: UISegmentedControl!
    @IBOutlet weak var camView: UIImageView!
    
    @IBAction func startButton(_ sender: Any) {
        is_stopped = false
        self.captureSession.startRunning()
//        self.addCameraInput()
        self.showCameraFeed()
//        self.getCameraFrames()
    }
    
    var is_stopped = false
    @IBAction func StopButton(_ sender: Any) {
        is_stopped = true
        self.captureSession.stopRunning()
        
        self.clearDrawings()
        self.clearDrawings()
        self.numberLabel.text = "#"
        self.previewLayer.removeFromSuperlayer()
        
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
        self.view.layer.insertSublayer(self.previewLayer, at: 0)
        self.previewLayer.frame = self.view.frame
//        camView.layer.addSublayer(self.previewLayer)
//        self.previewLayer.frame = camView.layer.bounds
        self.previewLayer.videoGravity = .resizeAspectFill
       
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
//            print("origin: ", humanBoundingBoxOnScreen.origin)
//            print("x: ", humanBoundingBoxOnScreen.origin.x)
//            print("size: ", humanBoundingBoxOnScreen.size)
//            print("height: ", humanBoundingBoxOnScreen.size.height)

            let humanBoundingBoxPath = CGPath(rect: humanBoundingBoxOnScreen, transform: nil)
            let humanBoundingBoxShape = CAShapeLayer()
            humanBoundingBoxShape.path = humanBoundingBoxPath
            humanBoundingBoxShape.fillColor = UIColor.clear.cgColor
            humanBoundingBoxShape.strokeColor = UIColor.green.cgColor
            
            
            let ciImage = CIImage(cvPixelBuffer: image)
            let context = CIContext()
            let cgimage = context.createCGImage(ciImage, from: ciImage.extent)
            let imageRef = cgimage?.cropping(to: humanBoundingBoxOnScreen)
            let uiImage =  UIImage(cgImage: imageRef!)
            UIImageWriteToSavedPhotosAlbum(uiImage, nil, nil, nil);
            
            
            return humanBoundingBoxShape
        })

        humansBoundingBoxes.forEach({ humanBoundingBox in self.view.layer.addSublayer(humanBoundingBox)
            

//            let ciImage = CIImage(cvPixelBuffer: image)
//            let context = CIContext()
//            if let cgimage = context.createCGImage(ciImage, from: ciImage.extent) {
//                let uiImage =  UIImage(cgImage: cgimage)
//                print("original size: ", uiImage.size)
//                let imageNew = uiImage.cropping(to: humanBoundingBox.path?.boundingBox)
////                UIImageWriteToSavedPhotosAlbum(uiImage, nil, nil, nil);
//            }
            
            
           
//            let newImage = resizePixelBuffer(image,
//                              cropX: Int((humanBoundingBox.path?.boundingBox.origin.x)!),
//                              cropY: Int((humanBoundingBox.path?.boundingBox.origin.y)!),
//                              cropWidth: CVPixelBufferGetWidth(image),
//                              cropHeight: CVPixelBufferGetHeight(image),
//                              scaleWidth: Int((humanBoundingBox.path?.boundingBox.width)!),
//                              scaleHeight: Int((humanBoundingBox.path?.boundingBox.height)!))

//            let ciImageNew = CIImage(cvPixelBuffer: newImage!)
//            let contextNew = CIContext()
//            if let cgimageNew = contextNew.createCGImage(ciImageNew, from: ciImageNew.extent) {
//                let uiImageNew =  UIImage(cgImage: cgimageNew)
//                UIImageWriteToSavedPhotosAlbum(uiImageNew, nil, nil, nil);
//            }
            
            self.processImage(in: image)
            
            
            
        })
        
       
        self.drawings = humansBoundingBoxes
    }
    
    
//    private func cropImage(object: VNDetectedObjectObservation) -> CGImage? {
//        let width = object.boundingBox.width * CGFloat(self.detectable.width)
//        let height = object.boundingBox.height * CGFloat(self.detectable.height)
//        let x = object.boundingBox.origin.x * CGFloat(self.detectable.width)
//        let y = (1 - object.boundingBox.origin.y) * CGFloat(self.detectable.height) - height
//
//        let croppingRect = CGRect(x: x, y: y, width: width, height: height)
//        let image = self.detectable.cropping(to: croppingRect)
//        return image
//    }
    
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

    for result in results {
        if let observation = result as? VNRecognizedTextObservation {
            for text in observation.topCandidates(1) {
                let text_int = Int(text.string)
                if(text_int != nil){
                    if(text_int! >= 0 && text_int! <= 66){
                        print("HIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIT")
                        print("text: ", text.string)
                        self.numberLabel.text = text.string
                    }
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
    
    
    /**
      First crops the pixel buffer, then resizes it.
      - Note: The new CVPixelBuffer is not backed by an IOSurface and therefore
        cannot be turned into a Metal texture.
    */
    public func resizePixelBuffer(_ srcPixelBuffer: CVPixelBuffer,
                                  cropX: Int,
                                  cropY: Int,
                                  cropWidth: Int,
                                  cropHeight: Int,
                                  scaleWidth: Int,
                                  scaleHeight: Int) -> CVPixelBuffer? {
        if(is_stopped){
           print("is stopped")
            return srcPixelBuffer
        }
        let flags = CVPixelBufferLockFlags(rawValue: 0)
      guard kCVReturnSuccess == CVPixelBufferLockBaseAddress(srcPixelBuffer, flags) else {
        return nil
      }
      defer { CVPixelBufferUnlockBaseAddress(srcPixelBuffer, flags) }

      guard let srcData = CVPixelBufferGetBaseAddress(srcPixelBuffer) else {
        print("Error: could not get pixel buffer base address")
        return nil
      }
      let srcBytesPerRow = CVPixelBufferGetBytesPerRow(srcPixelBuffer)
      let offset = cropY*srcBytesPerRow + cropX*4
      var srcBuffer = vImage_Buffer(data: srcData.advanced(by: offset),
                                    height: vImagePixelCount(cropHeight),
                                    width: vImagePixelCount(cropWidth),
                                    rowBytes: srcBytesPerRow)

      let destBytesPerRow = scaleWidth*4
      guard let destData = malloc(scaleHeight*destBytesPerRow) else {
        print("Error: out of memory")
        return nil
      }
      var destBuffer = vImage_Buffer(data: destData,
                                     height: vImagePixelCount(scaleHeight),
                                     width: vImagePixelCount(scaleWidth),
                                     rowBytes: destBytesPerRow)

        
      let error = vImageScale_ARGB8888(&srcBuffer, &destBuffer, nil, vImage_Flags(0))
      if error != kvImageNoError {
        print("Error:", error)
        free(destData)
        return nil
      }

      let releaseCallback: CVPixelBufferReleaseBytesCallback = { _, ptr in
        if let ptr = ptr {
          free(UnsafeMutableRawPointer(mutating: ptr))
        }
      }

      let pixelFormat = CVPixelBufferGetPixelFormatType(srcPixelBuffer)
      var dstPixelBuffer: CVPixelBuffer?
      let status = CVPixelBufferCreateWithBytes(nil, scaleWidth, scaleHeight,
                                                pixelFormat, destData,
                                                destBytesPerRow, releaseCallback,
                                                nil, nil, &dstPixelBuffer)
      if status != kCVReturnSuccess {
        print("Error: could not create new pixel buffer")
        free(destData)
        return nil
      }
      return dstPixelBuffer
    }
}
