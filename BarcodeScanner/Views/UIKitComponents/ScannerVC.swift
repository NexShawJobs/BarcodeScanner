//
//  ScannerVC.swift
//  BarcodeScanner
//
//  Created by NebSha on 12/18/23.
//

import Foundation
import AVFoundation
import UIKit

enum CameraError {
    case invalidDeviceInput
    case invalidScandValue
}
protocol ScannerVCDelegate: class {
    func didFind(barcode: String)
    func didSurface(error: CameraError)
}
final class ScannerVC: UIViewController {
    
    let captureSession = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    weak var scannerDeleget: ScannerVCDelegate?
    
    init (scannerDeleget: ScannerVCDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.scannerDeleget = scannerDeleget
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSession()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let previewLayer = previewLayer else {
            scannerDeleget?.didSurface(error: .invalidDeviceInput)
            return
        }
        previewLayer.frame = view.layer.bounds
    }
    
    private func setupCaptureSession(){
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            scannerDeleget?.didSurface(error: .invalidDeviceInput)
            return
        }
        
        let videoInput: AVCaptureDeviceInput
        do {
            try videoInput = AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            scannerDeleget?.didSurface(error: .invalidDeviceInput)
            return
        }
        
        if captureSession.canAddInput(videoInput){
            captureSession.addInput(videoInput)
        }else {
            scannerDeleget?.didSurface(error: .invalidDeviceInput)
            return
        }
        
        let metaDataOutput = AVCaptureMetadataOutput()
        if captureSession.canAddOutput(metaDataOutput){
            captureSession.addOutput(metaDataOutput)
            metaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metaDataOutput.metadataObjectTypes = [.ean8, .ean13]
        }else{
            scannerDeleget?.didSurface(error: .invalidDeviceInput)
            return
        }
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer!.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer!)
        
        captureSession.startRunning()
    }
}

extension ScannerVC: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects:
                        [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let object = metadataObjects.first else {
            scannerDeleget?.didSurface(error: .invalidScandValue)
            return
        }
        
        guard let machineReadableObject = object as? AVMetadataMachineReadableCodeObject else {
            scannerDeleget?.didSurface(error: .invalidScandValue)
            return
        }
        
        guard let barcode = machineReadableObject.stringValue else {
            scannerDeleget?.didSurface(error: .invalidScandValue)
            return
        }
        scannerDeleget?.didFind(barcode: barcode)
    }
}
