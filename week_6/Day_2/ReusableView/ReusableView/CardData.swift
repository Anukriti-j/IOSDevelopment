import Foundation

struct CardData {
    var cardViews: [Cards] = [Cards(image: "Animals", title: "Animal"), Cards(image: "ceoimage", title: "CEO"),
                              Cards(image: "Person", title: "person"), Cards(image: "trees", title: "Nature")]
}

struct Cards: Identifiable {
    let id = UUID()
    let image: String
    let title: String
}
