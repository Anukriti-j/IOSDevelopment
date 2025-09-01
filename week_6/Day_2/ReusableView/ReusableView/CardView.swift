import SwiftUI

struct CardView: View {
    
    let image: String
    let title: String
    
    var body: some View {
        VStack {
            Text("\(title)")
                .font(.headline)
                .fontWeight(.bold)
                .padding([.top, .leading, .trailing])
            Image("\(image)")
                .resizable()
                .frame(height: 200, alignment: .center)
                .aspectRatio(contentMode: .fit)
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
//
//#Preview {
//    CardView()
//}
