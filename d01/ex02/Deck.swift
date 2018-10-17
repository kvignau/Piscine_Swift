import Foundation

class Deck: NSObject {
	static let allSpades: [Card] = Value.allValues.map({
			(cardVal) -> Card in
				return (Card(c: Color.Spade, v: cardVal))
		})

	static let allDiamond: [Card] = Value.allValues.map({
			(cardVal) -> Card in
				return (Card(c: Color.Diamond, v: cardVal))
		})

	static let allHeart: [Card] = Value.allValues.map({
			(cardVal) -> Card in
				return (Card(c: Color.Heart, v: cardVal))
		})

	static let allClub: [Card] = Value.allValues.map({
			(cardVal) -> Card in
				return (Card(c: Color.Club, v: cardVal))
		})

	static let allCards: [Card] = allSpades + allDiamond + allHeart + allClub
}