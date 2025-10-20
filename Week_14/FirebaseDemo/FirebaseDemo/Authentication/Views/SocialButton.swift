import Foundation
import SwiftUI

struct SocialButton: View {
    let title: String
    let systemImage: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: systemImage)
                    .foregroundColor(.white)
                Text(title)
                    .foregroundColor(.white)
                    .bold()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(color)
            .cornerRadius(8)
        }
    }
}
