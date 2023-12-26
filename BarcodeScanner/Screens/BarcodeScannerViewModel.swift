//
//  BarcodeScannerViewModel.swift
//  BarcodeScanner
//
//  Created by NebSha on 12/21/23.
//

import SwiftUI

final class BarcodeScannerViewModel: ObservableObject {
    
    @Published  var scanedCode = ""
    @Published  var alertItem: AlertItem?
    
    var statusText: String {
        return scanedCode.isEmpty ? "Not Yet scaned" : scanedCode

    }
    
    var statusTextColor: Color {
        //return scanedCode.isEmpty ? .red : .green
        // you can or you may not use return on the latest swift
        scanedCode.isEmpty ? .red : .green

    }
    
}
