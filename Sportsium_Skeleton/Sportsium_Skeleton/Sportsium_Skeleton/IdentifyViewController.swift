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

class IdentifyViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    
    @IBOutlet weak var numberLabel: UILabel!
//    @IBOutlet weak var speedSwitch: UISegmentedControl!
    @IBOutlet weak var helpLabel: UILabel!
    
    var detectedPlayersArr:[(team: String, number: String)] = []
    
//    var teamColorCodes:[(team: String, homeColor: (red: Int, green: Int, blue: Int), awayColor: (red: Int, green: Int, blue: Int))] = [(team: "Orlando", homeColor: (red: 96, green: 70, blue: 161), awayColor: (red: 26, green: 82, blue: 228)), (team: "Chicago", homeColor: (red: 96, green: 70, blue: 161), awayColor: (red: 26, green: 82, blue: 228))]
    
    var teamColorCodes: [String: (homeColor: (red: Double, green: Double, blue: Double), awayColor: (red: Double, green: Double, blue: Double))] = [:]
    
    let homeTeam = "orlando_pride"
    let awayTeam = "chicago_red_stars"
    
    
//    let homeColor = teamcol
    
    @IBAction func startButton(_ sender: Any) {
        photocount = 0
        is_stopped = false
        self.captureSession.startRunning()
        self.showCameraFeed()
        self.helpLabel.text = ""
        self.detectedPlayersArr.removeAll()
    }
    
    var is_stopped = false
    @IBAction func StopButton(_ sender: Any) {
        is_stopped = true
        self.captureSession.stopRunning()
        
        self.clearDrawings()
        self.clearDrawings()
        self.numberLabel.text = "#"
        self.helpLabel.text = "Identify a Player! Press the start button and hold your phone up to the field to get information on a player."
        self.previewLayer.removeFromSuperlayer()
        
    }
    
    private let captureSession = AVCaptureSession()
    private lazy var previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
    private let videoDataOutput = AVCaptureVideoDataOutput()
    private var drawings: [CAShapeLayer] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.bringSubviewToFront(self.helpLabel)
        self.populateColors()
        self.addCameraInput()
        self.showCameraFeed()
        self.getCameraFrames()
    }
    
    func populateColors() {
        self.teamColorCodes["orlando_pride"] = (homeColor: (red: 77, green: 52, blue: 136), awayColor: (red: 208, green: 202, blue: 219))
        self.teamColorCodes["chicago_red_stars"] = (homeColor: (red: 112, green: 134, blue: 173), awayColor: (red: 213, green: 216, blue: 211))
        self.teamColorCodes["reign"] = (homeColor: (red: 17, green: 26, blue: 47), awayColor: (red: 1, green: 1, blue: 1))
        self.teamColorCodes["portland_thorns"] = (homeColor: (red: 0, green: 0, blue: 0), awayColor: (red: 190, green: 201, blue: 230))
        self.teamColorCodes["utah_royals"] = (homeColor: (red: 211, green: 142, blue: 9), awayColor: (red: 1, green: 1, blue: 1))
        self.teamColorCodes["north_carolina_courage"] = (homeColor: (red: 1, green: 1, blue: 1), awayColor: (233, 222, 245))
        
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
        self.view.layer.insertSublayer(self.previewLayer, at: 0)
        self.previewLayer.frame = self.view.frame
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
        if(self.is_stopped){
            return
        }
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
        if(self.is_stopped){
            return
        }
        
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
//            let uiImage =  UIImage(cgImage: cgimage!)
            if(photocount < 20){
//                UIImageWriteToSavedPhotosAlbum(uiImage, nil, nil, nil)
            }
            let cgimageCropped = cropImage(detectable: cgimage!, object: observedhuman)
            let uiImageCrop =  UIImage(cgImage: cgimageCropped!)
            photocount += 1
            if(photocount < 20){
//                UIImageWriteToSavedPhotosAlbum(uiImageCrop, nil, nil, nil)
            
            }
            
            //skip first 10 photos
            if(photocount < 10){
                return humanBoundingBoxShape
            }
           
            let cropPixelBuffer = uiToPixelBuffer(from: uiImageCrop)
            self.processImage(in: cropPixelBuffer!)
        
            if(self.detectedNumber != "-1"){
                let team = self.findColor(image: uiImageCrop)
                var teamName = ""
                if(team == "home") {teamName = homeTeam}
                if(team == "away") {teamName = awayTeam}
                let tup = (team: teamName, number: self.detectedNumber)
                print("tup: ", tup)
                if(team != "no team found" && !contains(a: self.detectedPlayersArr, v: tup)){
                    self.detectedPlayersArr.append(tup)
                    print(self.detectedPlayersArr)
                }
                
                self.detectedNumber = "-1"
            }
            else{
//                print("no number detected")
            }
            
            
            return humanBoundingBoxShape
        })

        humansBoundingBoxes.forEach({ humanBoundingBox in self.view.layer.addSublayer(humanBoundingBox)
            
        })
        
       
        self.drawings = humansBoundingBoxes
    }
    
    func contains(a:[(team: String, number: String)], v:(team: String, number: String)) -> Bool {
      let (c1, c2) = v
      for (v1, v2) in a { if v1 == c1 && v2 == c2 { return true } }
      return false
    }
    
    private func cropImage(detectable: CGImage, object: VNDetectedObjectObservation) -> CGImage? {
        if(self.is_stopped){
            return detectable
        }
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
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)

        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }

        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull!])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)

        return UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
    }
    
    func getColorComponents(color: UIColor) -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat){
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return (red, green, blue, alpha)
    }
    
    func findColor(image: UIImage) -> String{
        if(self.is_stopped){
            return "stopping, no team found"
        }
//        let homeTeam = (red: 96, green: 70, blue: 161)
//        let awayTeam = (red: 26, green: 82, blue: 228)
        let homeColor = self.teamColorCodes[self.homeTeam]?.homeColor
        let awayColor = self.teamColorCodes[self.awayTeam]?.awayColor
//        print("home color: ", homeColor)
//        print("away color: ", awayColor)
//        let tolerance = 55.0
        let tolerance = 30
        var homeCount = 0
        var awayCount = 0
        
//        print("height: ", Int(image.size.height))
//        print("width: ", Int(image.size.width))
        
        for yCo in (0 ..< Int(image.size.height)).reversed() {
            for xCo in 0 ..< Int(image.size.width) {
                let pixelColor = getPixelColor(image: image, pos: CGPoint(x: xCo, y: yCo))
                let pixelComps = getColorComponents(color: pixelColor)
//                let red = Double(pixelComps.red * 255)
//                let green = Double(pixelComps.green * 255)
//                let blue = Double(pixelComps.blue * 255)
                let red = Int(round(pixelComps.red * 255))
                let green = Int(round(pixelComps.green * 255))
                let blue = Int(round(pixelComps.blue * 255))
                
//                var homeDist = pow(abs(red - homeColor!.red),Double(2)) + pow(abs(green - homeColor!.green),Double(2)) + pow(abs(blue - homeColor!.blue),Double(2))
//                var awayDist = pow(abs(red - awayColor!.red),Double(2)) + pow(abs(green - awayColor!.green),Double(2)) + pow(abs(blue - awayColor!.blue),Double(2))
//
//                homeDist = Double(homeDist).squareRoot()
//                awayDist = Double(awayDist).squareRoot()
//
////                print(homeDist, " ", awayDist)
//                if(homeDist < tolerance){
//                    homeCount = homeCount + 1
//                }
//                if(awayDist < tolerance){
//                    awayCount = awayCount + 1
//                }
                
                 if(abs(red - Int(homeColor!.red)) <= tolerance &&
                    abs(green - Int(homeColor!.green)) <= tolerance &&
                   abs(blue - Int(homeColor!.blue)) <= tolerance){
                    homeCount = homeCount + 1
                }
                if(abs(red - Int(awayColor!.red)) <= tolerance &&
                   abs(green - Int(awayColor!.green)) <= tolerance &&
                   abs(blue - Int(awayColor!.blue)) <= tolerance){
                    awayCount = awayCount + 1
                }
                
                
                
//                if(homeCount >= 1200){
//                    print("home count: ", homeCount)
//                    print("away count: ", awayCount)
//                    return "home"
//                }
//                if(awayCount >= 1200){
//                    print("home count: ", homeCount)
//                    print("away count: ", awayCount)
//                    return "away"
//                }
            }
            
        }
        print("home count: ", homeCount)
        print("away count: ", awayCount)
        if(homeCount >= awayCount && homeCount >= 500){
            return "home"
        }
        if(awayCount >= homeCount && awayCount >= 500){
            return "away"
        }
        return "no team found"
        
    }
    
    func getPixelColor(image: UIImage, pos: CGPoint) -> UIColor {
        let pixelData = image.cgImage!.dataProvider!.data
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)

        let pixelInfo: Int = ((Int(image.size.width) * Int(pos.y)) + Int(pos.x)) * 4

        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)

        return UIColor(red: r, green: g, blue: b, alpha: a)
    }

    private func clearDrawings() {
        self.drawings.forEach({ drawing in drawing.removeFromSuperlayer() })
    }
    
    
    
    lazy var textDetectionRequestFast: VNRecognizeTextRequest = {
           let request = VNRecognizeTextRequest(completionHandler: self.handleDetectedText)
//        let speed = self.speedSwitch.selectedSegmentIndex
            request.recognitionLevel = .fast
           
           request.usesLanguageCorrection = false
//           request.customWords = ["13", "17", "10", "2", "Orlando", "Health"]
           request.recognitionLanguages = ["en_US"]
           return request
       }()
    
    lazy var textDetectionRequestAccurate: VNRecognizeTextRequest = {
               let request = VNRecognizeTextRequest(completionHandler: self.handleDetectedText)
//            let speed = self.speedSwitch.selectedSegmentIndex
                request.recognitionLevel = .accurate
               
               request.usesLanguageCorrection = false
    //           request.customWords = ["13", "17", "10", "2", "Orlando", "Health"]
               request.recognitionLanguages = ["en_US"]
               return request
           }()
       
    func processImage(in image: CVPixelBuffer) {
        if(self.is_stopped){
            return
        }
//        let speed = self.speedSwitch.selectedSegmentIndex
        let requests = [textDetectionRequestFast]
//        if(speed == 0){
////            print("using fast")
//            requests = [textDetectionRequestFast]
//        }
//        else{
////            print("using accurate")
//            requests = [textDetectionRequestAccurate]
//        }
       let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: image,  options: [:])
         DispatchQueue.main.async {
            do {
                  try imageRequestHandler.perform(requests)
              } catch let error {
                  print("Error: \(error)")
              }
        }
       }
    
    var detectedNumber = "-1"
    fileprivate func handleDetectedText(request: VNRequest?, error: Error?) {
        if(self.is_stopped){
            return
        }
        if let error = error {
            print("Error: ", error.localizedDescription)
            return
        }
        guard let results = request?.results, results.count > 0 else {
//            print("Error: no text was found")
            self.detectedNumber = "-1"
            return
    }

    for result in results {
        if let observation = result as? VNRecognizedTextObservation {
            for text in observation.topCandidates(1) {
                let text_int = Int(text.string)
                if(text_int != nil){
                    if(text_int! >= 0 && text_int! <= 66){
                        self.numberLabel.text = text.string
                        self.detectedNumber = text.string
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
    
}
