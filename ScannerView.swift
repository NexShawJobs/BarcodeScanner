//
//  ScannerView.swift
//  BarcodeScanner
//
//  Created by NebSha on 12/18/23.
//

import SwiftUI

struct ScannerView: UIViewControllerRepresentable {

    
    func makeUIViewController(context: Context) -> ScannerVC {
        ScannerVC(scannerDeleget: context.coordinator)
    }
    
    func updateUIViewController(_ uiViewController: ScannerVC, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    final class Coordinator:NSObject, ScannerVCDelegate {
        func didFind(barcode: String) {
            print(barcode)
        }
        
        func didSurface(error: CameraError) {
            print(error.rawValue)
        }
    }
}


#Preview {
    ScannerView()
}
