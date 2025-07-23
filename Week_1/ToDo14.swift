
// TODO 14: Create a function that returns an array of cards (full deck)

enum  Num: Int, CaseIterable {
    case ace = 1, two, three, four, five, six, seven, eight, nine, ten, jack, queen, king
}

enum Suit: CaseIterable {
    case spades, hearts, diamonds, clubs
}

struct Card {
    let num: Num
    let suit: Suit
    func simpleDescription() -> String {
        "\(num) of \(suit)"
    }

    static func createDeck() -> [Card] {
        // Loop through every suit and every rank to build a 52-card deck
        var deck: [Card] = []
        for suit in Suit.allCases {
            for rank in Num.allCases {
                deck.append(Card(num: rank, suit: suit))
            }
        }
        return deck
    }
}
let fullDeck = Card.createDeck()
print(fullDeck)
print(fullDeck.count) // 52
