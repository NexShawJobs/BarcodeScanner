//
//  ContentView.swift
//  BarcodeScanner
//
//  Created by NebSha on 12/18/23.
//

import SwiftUI

struct BarcodeScannerView: View {
@StateObject var viewModel = BarcodeScannerViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                ScannerView(scanedCode: $viewModel.scanedCode,
                            alertItem: $viewModel.alertItem)
                    .frame(maxWidth: .infinity, maxHeight: 300)
                    .padding()
                Spacer()
                    .frame(height:60)
                Label("Scaned Barcode", systemImage: "barcode.viewfinder")
                    .font(.title)
                    .padding()
                Text (viewModel.statusText)
                    .bold()
                    .font(.largeTitle)
                    .foregroundStyle(viewModel.statusTextColor)
            }.navigationTitle("Barcode Scanner")
                .alert(item:$viewModel.alertItem){ alertItem in
                    Alert(title: Text(alertItem.title),
                          message: Text(alertItem.message),
                          dismissButton: alertItem.dismissButton)
                }
        }
    }
}

#Preview {
    BarcodeScannerView()
}
