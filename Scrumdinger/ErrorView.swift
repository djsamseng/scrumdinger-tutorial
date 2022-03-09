//
//  ErrorView.swift
//  Scrumdinger
//
//  Created by Samuel Seng on 3/8/22.
//

import Foundation
import SwiftUI

struct ErrorView: View {
    let errorWrapper: ErrorWrapper
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Text("An error has occurred!")
                    .font(.title)
                    .padding(.bottom)
                Text(errorWrapper.error.localizedDescription)
                    .font(.headline)
                Text(errorWrapper.guidance)
                    .font(.caption)
                    .padding(.top)
                Spacer()
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(16)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button("Dismiss") {
                        dismiss()
                    }
                })
            }
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    enum SampleError: Error {
        case errorRequired
    }
    static var wrapper: ErrorWrapper {
        ErrorWrapper(error: SampleError.errorRequired, guidance: "This can be ignored")
    }
    static var previews: some View {
        ErrorView(errorWrapper: wrapper)
    }
}
