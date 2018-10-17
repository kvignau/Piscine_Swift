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

	var cards: [Card] = []
	var discards: [Card] = []
	var outs: [Card] = []

	init (_ shuffle: Bool)
	{
		self.cards = (shuffle) ? Deck.allCards.shuffle() : Deck.allCards
	}

	override var description: String
	{
		let result: String = cards.reduce("", {acc, card in
			return ((acc != "") ? acc + "\n" + card.description : card.description)
		})
		return (result)
	}

	func draw() -> Card?
	{
		if (cards.count > 0) {
			let card = self.cards.removeFirst()
			self.outs.append(card)
			return (card)
		}
		return (nil)
	}

	func fold(_ c: Card)
	{
		if (self.outs.contains{(elem) -> Bool in
					return (elem == c)
		})
		{
			let index = outs.index(of: c);
            self.outs.remove(at: index!);
            self.discards.append(c)
		}
	}
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