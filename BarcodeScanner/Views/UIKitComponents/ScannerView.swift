//
//  ScannerView.swift
//  BarcodeScanner
//
//  Created by NebSha on 12/18/23.
//

import SwiftUI

struct ScannerView: UIViewControllerRepresentable {
    
    @Binding var scanedCode: String
    @Binding var alertItem: AlertItem?
    func makeUIViewController(context: Context) -> ScannerVC {
        ScannerVC(scannerDeleget: context.coordinator)
    }
    
    func updateUIViewController(_ uiViewController: ScannerVC, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(scanerView: self)
    }
    final class Coordinator:NSObject, ScannerVCDelegate {
        
        init(scanerView: ScannerView) {
            self.scanerView = scanerView
        }
        private let scanerView : ScannerView
        func didFind(barcode: String) {
            scanerView.scanedCode = barcode
        }
        
        func didSurface(error: CameraError) {
            switch error {
            case .invalidDeviceInput:
                scanerView.alertItem = AlertContext.invalidDeviceInput
            case .invalidScandValue:
                scanerView.alertItem = AlertContext.invalidScannedType
            }
        }
    }
}

//
//#Preview {
//    ScannerView(scanedCode: .constant("123"), alertItem: $alertItem)
//}
