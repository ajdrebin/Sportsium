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
        photocount = 0
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
                    self.handleHumanDetectionResults(results, in: image)
                } else {
                    self.clearDrawings()
                }
            }
        })
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: image, orientation: .leftMirrored, options: [:])
        try? imageRequestHandler.perform([humanDetectionRequest])
    }
    
    var photocount = 0
    private func handleHumanDetectionResults(_ observedhumans: [VNDetectedObjectObservation], in image: CVPixelBuffer) {
        self.clearDrawings()
        let humansBoundingBoxes: [CAShapeLayer] = observedhumans.map({ (observedhuman: VNDetectedObjectObservation) -> CAShapeLayer in
            let humanBoundingBoxOnScreen = self.previewLayer.layerRectConverted(fromMetadataOutputRect: observedhuman.boundingBox)

            let humanBoundingBoxPath = CGPath(rect: humanBoundingBoxOnScreen, transform: nil)
            let humanBoundingBoxShape = CAShapeLayer()
            humanBoundingBoxShape.path = humanBoundingBoxPath
            humanBoundingBoxShape.fillColor = UIColor.clear.cgColor
            humanBoundingBoxShape.strokeColor = UIColor.green.cgColor
            
            
            let ciImage = CIImage(cvPixelBuffer: image)
            let context = CIContext()
            let cgimage = context.createCGImage(ciImage, from: ciImage.extent)
            let cgimageCropped = cropImage(detectable: cgimage!, object: observedhuman)
           
            let uiImage =  UIImage(cgImage: cgimage!)
            let uiImageCrop =  UIImage(cgImage: cgimageCropped!)
            photocount += 1
            if(photocount < 10){
                UIImageWriteToSavedPhotosAlbum(uiImage, nil, nil, nil)
                UIImageWriteToSavedPhotosAlbum(uiImageCrop, nil, nil, nil)
            }
           
            let cropPixelBuffer = uiToPixelBuffer(from: uiImageCrop)
            self.processImage(in: cropPixelBuffer!)
            
            
            return humanBoundingBoxShape
        })

        humansBoundingBoxes.forEach({ humanBoundingBox in self.view.layer.addSublayer(humanBoundingBox)
        })
        
       
        self.drawings = humansBoundingBoxes
    }
    
    
    private func cropImage(detectable: CGImage, object: VNDetectedObjectObservation) -> CGImage? {
        let width = object.boundingBox.width * CGFloat(detectable.width)
        let height = object.boundingBox.height * CGFloat(detectable.height)
        let x = object.boundingBox.origin.x * CGFloat(detectable.width)
        let y = (1 - object.boundingBox.origin.y) * CGFloat(detectable.height) - height
        let croppingRect = CGRect(x: x , y: y, width: width, height: height + (100))

//        let croppingRect = CGRect(x: x, y: y, width: width, height: height)
        let image = detectable.cropping(to: croppingRect)
        return image
    }
    
    
    func uiToPixelBuffer(from image: UIImage) -> CVPixelBuffer? {
      let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
      var pixelBuffer : CVPixelBuffer?
      let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(image.size.width), Int(image.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
      guard (status == kCVReturnSuccess) else {
        return nil
      }

      CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
      let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)

      let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
      let context = CGContext(data: pixelData, width: Int(image.size.width), height: Int(image.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)

      context?.translateBy(x: 0, y: image.size.height)
      context?.scaleBy(x: 1.0, y: -1.0)

      UIGraphicsPushContext(context!)
      image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
      UIGraphicsPopContext()
      CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))

      return pixelBuffer
    }

    func getAverageColor(inputImage: CIImage) -> UIColor? {
    
//        guard let inputImage = CIImage(image: self) else { return nil }
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)

        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }

        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull!])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)

        return UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
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
       let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: image,  options: [:])
         DispatchQueue.main.async {
            do {
                  try imageRequestHandler.perform(requests)
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
