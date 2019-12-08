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

class PlayerButton: UIButton {
    var player: Player
    var team: TeamInfo
    
    init(player: Player, team: TeamInfo) {
        self.player = player
        self.team = team
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class IdentifyViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var helpLabel: UILabel!
    @IBOutlet weak var curGameLabel: UILabel!
    @IBOutlet weak var curHomeLabel: UILabel!
    @IBOutlet weak var curAwayLabel: UILabel!
    @IBOutlet weak var gameHelpLabel: UILabel!
    
    var detectedPlayersArr:[(team: String, number: String)] = []
    
//    var teamColorCodes:[(team: String, homeColor: (red: Int, green: Int, blue: Int), awayColor: (red: Int, green: Int, blue: Int))] = [(team: "Orlando", homeColor: (red: 96, green: 70, blue: 161), awayColor: (red: 26, green: 82, blue: 228)), (team: "Chicago", homeColor: (red: 96, green: 70, blue: 161), awayColor: (red: 26, green: 82, blue: 228))]
    
    var teamColorCodes: [String: (homeColor: (red: Double, green: Double, blue: Double), awayColor: (red: Double, green: Double, blue: Double))] = [:]
    
//    let homeTeam = "orlando_pride"
//    let awayTeam = "portland_thorns"
//    let league = "NWSL"
    
//    let homeTeam = home
//    let awayTeam = away

    
//    let homeColor = teamcol
    
    @IBAction func startButton(_ sender: Any) {
        print("starting capture")
        photocount = 0
        is_stopped = false
        self.captureSession.startRunning()
        self.showCameraFeed()
        self.clearHelpLabels()
        self.detectedPlayersArr.removeAll()
    }
    
    var is_stopped = false
    @IBAction func StopButton(_ sender: Any) {
        is_stopped = true
        self.captureSession.stopRunning()
        
        self.clearDrawings()
        self.clearDrawings()
        self.resetHelpLabels()
        self.previewLayer.removeFromSuperlayer()
        
    }
    
    func resetHelpLabels(){
         self.numberLabel.text = ""
         self.helpLabel.text = "Press the start button and hold your phone up to the field to get information on a player. (Note, detection can be finnicky! If you run into trouble, try another player)"
         self.titleLabel.text = "Identify a Player!"
         self.curGameLabel.text = "Current Game:"
         self.curHomeLabel.text = home
         self.curAwayLabel.text = away
         let homeColor = self.teamColorCodes[home]?.homeColor
         self.curHomeLabel.backgroundColor = UIColor(red: CGFloat(homeColor!.red / 255), green: CGFloat(homeColor!.green / 255), blue: CGFloat(homeColor!.blue/255) , alpha: 1.0)
         
         let awayColor = self.teamColorCodes[away]?.awayColor
         self.curAwayLabel.backgroundColor = UIColor(red: CGFloat(awayColor!.red / 255), green: CGFloat(awayColor!.green / 255), blue: CGFloat(awayColor!.blue/255) , alpha: 1.0)
         self.curAwayLabel.textColor = UIColor.black
        
         self.gameHelpLabel.text = "Not the game you're looking for? Select a new one from the upcoming games page!"
    }
    
    func clearHelpLabels(){
        self.numberLabel.text = "#"
        self.titleLabel.text = ""
        self.helpLabel.text = ""
        self.curGameLabel.text = ""
        self.curHomeLabel.text = ""
        self.curHomeLabel.backgroundColor = nil
        self.curAwayLabel.backgroundColor = nil
        self.curAwayLabel.text = ""
        self.gameHelpLabel.text = ""
    }
    
    private let captureSession = AVCaptureSession()
    private lazy var previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
    private let videoDataOutput = AVCaptureVideoDataOutput()
    private var drawings: [CAShapeLayer] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.bringSubviewToFront(self.helpLabel)
//        print("calling populate colors")
        self.populateColors()
        self.addCameraInput()
        self.showCameraFeed()
        self.getCameraFrames()
//        self.makeButtons()
        self.setUpScroll()
    }
    
    var scView:UIScrollView!
    let buttonPadding:CGFloat = 10
    var xOffset:CGFloat = 10
    var currentScrollArr:[(team: String, number: String)] = []
    
    func setUpScroll() {
        self.resetHelpLabels()
        self.scView = UIScrollView(frame: CGRect(x: 0, y: 622, width: view.bounds.width, height: 90))
        self.view.addSubview(self.scView)

        self.scView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.6)
        self.scView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func updateScroll(){
        if(self.detectedPlayersArr.count == 0){
            return
        }
        
        let homeRoster = (teamsDict[home]?.playerList)!
        let awayRoster = (teamsDict[away]?.playerList)!
        

        for i in 0 ... self.detectedPlayersArr.count - 1 {
//            print("Current", self.currentScrollArr)
            if(contains(a: self.currentScrollArr, v: self.detectedPlayersArr[i])){
//                print(self.detectedPlayersArr[i], " already in scroll")
                continue
            }
            
            var name = ""
            var number = ""
            var team = ""
            
            let currPlayer = self.detectedPlayersArr[i]
            var idPlayer = homeRoster[0]
            var teamObj = teamsDict[home]
            self.currentScrollArr.append(currPlayer)
//            print(i, currPlayer)
            if (currPlayer.team == home) {
//                print("home roster: ", homeRoster)
                for player in homeRoster {
                    if currPlayer.number == player.number {
                        idPlayer = player
                        name = player.firstName + " " + player.lastName
                        number = player.number
                        team = currPlayer.team
                    }
                }
            }
            else if (currPlayer.team == away) {
//                print("Roster", awayRoster)
                for player in awayRoster {
                    if currPlayer.number == player.number {
                        idPlayer = player
                        name = player.firstName + " " + player.lastName
                        number = player.number
                        team = currPlayer.team
                        teamObj = teamsDict[away]
                    }
                }
            }
            
//            print("TEST", name,  number, team)
            if (name == "" || number == "" || team == "") {
                continue
            }
            
//            print("PLAYER", idPlayer)
            let button = PlayerButton( player: idPlayer, team: teamObj! )
            button.tag = i
            print("CHECK", button.player)
            button.layer.cornerRadius = 0.5 * button.bounds.size.width
            button.clipsToBounds = true
            
            var color = (red: 0.0, green: 0.0, blue: 0.0)
            if(team == home){ color = self.teamColorCodes[team]!.homeColor
                button.setTitleColor(UIColor.white, for: .normal)
            }
            else{ color = self.teamColorCodes[team]!.awayColor
                 button.setTitleColor(UIColor.black, for: .normal)
            }
            button.backgroundColor = UIColor(red: CGFloat(color.red)/255, green: CGFloat(color.green)/255, blue: CGFloat(color.blue)/255, alpha: 1)
            button.setTitle("\(number) \(name)", for: .normal)
            button.addTarget(self, action: #selector(btnTouch), for: UIControl.Event.touchUpInside)

            button.frame = CGRect(x: xOffset, y: CGFloat(buttonPadding), width: 200, height: 70)

            xOffset = xOffset + CGFloat(buttonPadding) + button.frame.size.width
            scView.addSubview(button)
        }

        scView.contentSize = CGSize(width: xOffset, height: scView.frame.height)
    }
    
    @IBAction func btnTouch(_ sender: PlayerButton) {
//        print("IN SEGUE", sender.player)
        performSegue(withIdentifier: "PlayerInfo", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "PlayerInfo") {
            let displayVC = segue.destination as! PlayerInfoViewController
            let button = sender as! PlayerButton
            displayVC.player_obj = button.player
            displayVC.team_obj = button.team
            displayVC.home_team_name = home
            displayVC.away_team_name = away
        }
//        if(segue.identifier == "Team") {
//            let displayVC = segue.destination as! TeamInfoViewController
//            let button = sender as! PlayerButton
//            print("checking button: ", button.team)
//            displayVC.home = button.team
//            displayVC.home_team_name = home
//            displayVC.away_team_name = away
//        }
    }
     
    
    func populateColors() {
//        if(league == ""){
//            print("League was null, setting now?")
//            league = "NWSL"
//        }
        print("populating colors, league: ", league)
        if (league == "NWSL"){
            self.teamColorCodes["orlando_pride"] = (homeColor: (red: 113, green: 78, blue: 178), awayColor: (red: 1, green: 1, blue: 1))
            self.teamColorCodes["chicago_red_stars"] = (homeColor: (red: 215, green: 240, blue: 255), awayColor: (red: 255, green: 246, blue: 49))
            self.teamColorCodes["reign"] = (homeColor: (red: 17, green: 26, blue: 47), awayColor: (red: 1, green: 1, blue: 1))
            self.teamColorCodes["portland_thorns"] = (homeColor: (red: 230, green: 60, blue: 41), awayColor: (red: 255, green: 255, blue: 255))
//            self.teamColorCodes["utah_royals"] = (homeColor: (red: 211, green: 142, blue: 9), awayColor: (red: 1, green: 1, blue: 1))
            self.teamColorCodes["utah_royals"] = (homeColor: (red: 234, green: 158, blue: 8), awayColor: (red: 1, green: 1, blue: 1))
            self.teamColorCodes["north_carolina_courage"] = (homeColor: (red: 1, green: 1, blue: 1), awayColor: (255, 255, 255))

        }
        else if (league == "WNBA"){
            self.teamColorCodes["chicago_sky"] = (homeColor: (red: 99, green: 141, blue: 223), awayColor: (red: 254, green: 234, blue: 0))
            self.teamColorCodes["atlanta_dream"] = (homeColor: (red: 37, green: 44, blue: 82), awayColor: (red: 143, green: 183, blue: 223))
            self.teamColorCodes["los_angeles_sparks"] = (homeColor: (red: 140, green: 138, blue: 8), awayColor: (red: 1, green: 1, blue: 1))
            self.teamColorCodes["las_vegas_aces"] = (homeColor: (red: 1, green: 1, blue: 1), awayColor: (red: 128, green: 77, blue: 17))
            self.teamColorCodes["seattle_storm"] = (homeColor: (red: 244, green: 239, blue: 119), awayColor: (red: 1, green: 1, blue: 1))
            self.teamColorCodes["phoenix_mercury"] = (homeColor: (red: 1, green: 1, blue: 1), awayColor: (red: 23, green: 17, blue: 18))
        }

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
//            print("observed width: ", observedhuman.boundingBox.width)
//            print("observed height: ", observedhuman.boundingBox.height)
//            print("observed x: ", observedhuman.boundingBox.origin.x)
//            print("observed y: ", observedhuman.boundingBox.origin.y)
//            print("human width: ", humanBoundingBoxOnScreen.width)
//            print("human height: ", humanBoundingBoxOnScreen.height)
//            print("human x: ", humanBoundingBoxOnScreen.origin.x)
//            print("human y: ", humanBoundingBoxOnScreen.origin.y)
            let humanBoundingBoxPath = CGPath(rect: humanBoundingBoxOnScreen, transform: nil)
            let humanBoundingBoxShape = CAShapeLayer()
            humanBoundingBoxShape.path = humanBoundingBoxPath
            humanBoundingBoxShape.fillColor = UIColor.clear.cgColor
            humanBoundingBoxShape.strokeColor = UIColor.green.cgColor
            
            let ciImage = CIImage(cvPixelBuffer: image)
            let context = CIContext()
            let cgimage = context.createCGImage(ciImage, from: ciImage.extent)
            if(cgimage == nil){ return humanBoundingBoxShape}
//            print(cgimage?.width, " " , cgimage?.height)
//            let uiImage =  UIImage(cgImage: cgimage!)
            if(photocount < 10){
//                UIImageWriteToSavedPhotosAlbum(uiImage, nil, nil, nil)
            }
            let cgimageCropped = cropImage(detectable: cgimage!, object: observedhuman)
            
            if(cgimageCropped == nil){ return humanBoundingBoxShape}
            let uiImageCrop =  UIImage(cgImage: cgimageCropped!)
            photocount += 1
            if(photocount < 10){
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
                if(team == "home") {teamName = home}
                if(team == "away") {teamName = away}
                let tup = (team: teamName, number: self.detectedNumber)
                print("tup: ", tup)
                if(team != "no team found" && !contains(a: self.detectedPlayersArr, v: tup)){
                    self.detectedPlayersArr.append(tup)
                    print(self.detectedPlayersArr)
                    self.updateScroll()
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
//        print("detectable width: ", detectable.width)
//        print("detectable height: ", detectable.height)
        
        let humanBoundingBoxOnScreen = self.previewLayer.layerRectConverted(fromMetadataOutputRect: object.boundingBox)
        
//        let imageViewScale = max(humanBoundingBoxOnScreen.width / CGFloat(detectable.width) , humanBoundingBoxOnScreen.height / CGFloat(detectable.height))
//        print("image view scale: ", imageViewScale)
        
        let width = humanBoundingBoxOnScreen.width * 3
        let height = humanBoundingBoxOnScreen.height * 2.5 + 200
        let x = humanBoundingBoxOnScreen.origin.x * 3
        let y = humanBoundingBoxOnScreen.origin.y * 2.5
//        let width = CGFloat(detectable.width) / humanBoundingBoxOnScreen.width * object.boundingBox.width
//        let height = CGFloat(detectable.height) / humanBoundingBoxOnScreen.height * object.boundingBox.height
//        let x = CGFloat(detectable.width) / humanBoundingBoxOnScreen.origin.x * object.boundingBox.origin.x
//        let y = CGFloat(detectable.height) / humanBoundingBoxOnScreen.origin.y * object.boundingBox.origin.y
        
        
        
//        print("crop width: ", width)
//        print("crop height: ", height)
//        print("crop x: ", x)
//        print("crop y: ", y)
        
        
//        let width = object.boundingBox.width * CGFloat(detectable.width)
//        let height = object.boundingBox.height * CGFloat(detectable.height)
//        let x = object.boundingBox.origin.x * CGFloat(detectable.width)
////        let y = object.boundingBox.origin.y * CGFloat(detectable.height)
//        let y = (1 - object.boundingBox.origin.y) * CGFloat(detectable.height) - height
////        let croppingRect = CGRect(x: x , y: y, width: width, height: height + (100))
//
        let croppingRect = CGRect(x: x, y: y, width: width, height: height)
//        let image = detectable.cropping(to: croppingRect)
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
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
                let size = image.size

                let widthRatio  = targetSize.width  / size.width
                let heightRatio = targetSize.height / size.height

                // Figure out what our orientation is, and use that to form the rectangle
                var newSize: CGSize
                if(widthRatio > heightRatio) {
                    newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
                } else {
                    newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
                }

                // This is the rect that we've calculated out and this is what is actually used below
                let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

                // Actually do the resizing to the rect using the ImageContext stuff
                UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
                image.draw(in: rect)
                let newImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()

                return newImage!
            }
            
        //    let r:CGFloat = 251/255
        //    let g:CGFloat = 94/255
        //    let b:CGFloat = 50/255
            func rgbToHue(r:CGFloat,g:CGFloat,b:CGFloat) -> (h:CGFloat, s:CGFloat, b:CGFloat) {
                let minV:CGFloat = CGFloat(min(r, g, b))
                let maxV:CGFloat = CGFloat(max(r, g, b))
                let delta:CGFloat = maxV - minV
                var hue:CGFloat = 0
                if delta != 0 {
                    if r == maxV {
                       hue = (g - b) / delta
                    }
                    else if g == maxV {
                       hue = 2 + (b - r) / delta
                    }
                    else {
                       hue = 4 + (r - g) / delta
                    }
                    hue *= 60
                    if hue < 0 {
                       hue += 360
                    }
                }
                let saturation = maxV == 0 ? 0 : (delta / maxV)
                let brightness = maxV
                return (h:hue/360, s:saturation, b:brightness)
            }
        //    let hueColor = rgbToHue(r: r, g: g, b: b)
        //    let finalColor = SKColor(hue: hueColor.h, saturation: hueColor.s, brightness: hueColor.b, alpha: 1)

        
        func findColor(image: UIImage) -> String{
            if(self.is_stopped){
                return "stopping, no team found"
            }
            
            let shrunk = self.resizeImage(image: image, targetSize: CGSize(width: 200.0, height: 200.0))
//            UIImageWriteToSavedPhotosAlbum(shrunk, nil, nil, nil)

            if(self.teamColorCodes.count == 0){
                self.populateColors()
            }
            let homeColor = self.teamColorCodes[home]?.homeColor
            let awayColor = self.teamColorCodes[away]?.awayColor
            
            if(homeColor == nil || awayColor == nil){
                print("home: ", home)
                print("away: ", away)
                return "no team found"
            }
//            print("checking, home:", homeColor, " away:", awayColor)
//
//            let homeHSV = rgbToHue(r: CGFloat(homeColor!.red/255), g: CGFloat(homeColor!.green/255), b: CGFloat(homeColor!.blue/255))
////            print("home rgb: ", homeColor!, "hsv: ", homeHSV)
//
//            let awayHSV = rgbToHue(r: CGFloat(awayColor!.red/255), g: CGFloat(awayColor!.green/255), b: CGFloat(awayColor!.blue/255))
////            print("away rgb: ", awayColor!, "hsv: ", awayHSV)
//
//
//            let homeHue = homeHSV.h * 360
//            let awayHue = awayHSV.h * 360
    //        let pixHue = CGFloat(240)
            
    //        let hueDiffHome = min(abs(homeHue-pixHue), 360-abs(homeHue-pixHue))
    //        let hueDiffAway = min(abs(awayHue-pixHue), 360-abs(awayHue-pixHue))
    //        print("home hue diff: ", hueDiffHome)
    //        print("away hue diff: ", hueDiffAway)


            let tolerance = 30
            var homeCount = 0
            var awayCount = 0
            
//            print("height: ", Int(shrunk.size.height))
//            print("width: ", Int(shrunk.size.width))
            
            for yCo in (0 ..< Int(shrunk.size.height)).reversed() {
                for xCo in 0 ..< Int(shrunk.size.width) {
                    let pixelColor = getPixelColor(image: shrunk, pos: CGPoint(x: xCo, y: yCo))
                    let pixelComps = getColorComponents(color: pixelColor)
//                    let pixelHSV = rgbToHue(r: pixelComps.red, g: pixelComps.green, b: pixelComps.blue)
//    //                print("pixel rgb: ", pixelComps, " hsv: ", pixelHSV)
//                    let pixHue = pixelHSV.h * 360
//                    let hueTolerance = CGFloat(10.0)
//                    let hueDiffHome = min(abs(homeHue-pixHue), 360-abs(homeHue-pixHue))
//                    let hueDiffAway = min(abs(awayHue-pixHue), 360-abs(awayHue-pixHue))
//    //                print("home hue diff: ", hueDiffHome)
//    //                print("away hue diff: ", hueDiffAway)
//
//                    if(abs(hueDiffHome - pixHue) <= hueTolerance){
//                        homeCount = homeCount + 1
//                    }
//                    if(abs(hueDiffAway - pixHue) <= hueTolerance){
//                        awayCount = awayCount + 1
//                    }

                    
                    
                    
                    
    //                let red = Double(pixelComps.red * 255)
    //                let green = Double(pixelComps.green * 255)
    //                let blue = Double(pixelComps.blue * 255)
                    
                    
                    let red = Int(round(pixelComps.red * 255))
                    let green = Int(round(pixelComps.green * 255))
                    let blue = Int(round(pixelComps.blue * 255))
    
    
    
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
                    
                }
                
            }
            print("home count: ", homeCount)
            print("away count: ", awayCount)
            if(homeCount >= awayCount){
                return "home"
            }
            if(awayCount >= homeCount){
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
