import SwiftUI

struct ContentView: View {
    let cardData = CardData()
    var body: some View {
        ScrollView() {
            VStack(spacing: 30) {
                ForEach(cardData.cardViews) { card in
                    CardView(image: card.image, title: card.title)
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
