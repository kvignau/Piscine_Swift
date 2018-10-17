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

extension Array {
		func shuffle() -> Array {
			var elements = self
			for (index, _) in elements.enumerated()
			{
				let save = elements[index]
				let randIndex = Int(arc4random_uniform(UInt32(elements.count)))
				if (index != randIndex)
				{
					elements[index] = elements[randIndex]
					elements[randIndex] = save
				}
			}
			return (elements);
		}
	}