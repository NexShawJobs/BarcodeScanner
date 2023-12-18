//
//  ContentView.swift
//  BarcodeScanner
//
//  Created by NebSha on 12/18/23.
//

import SwiftUI

struct BarcodeScannerView: View {
    var body: some View {
        NavigationView {
            VStack {
                ScannerView()
                    .frame(maxWidth: .infinity, maxHeight: 300)
                    .padding()
                Spacer()
                    .frame(height:60)
                Label("Scaned Barcode", systemImage: "barcode.viewfinder")
                    .font(.title)
                    .padding()
                Text ("Not Yet Scanned")
                    .bold()
                    .font(.largeTitle)
                    .foregroundStyle(.green)
            }.navigationTitle("Barcode Scanner")
        }
    }
}


#Preview {
    BarcodeScannerView()
}
