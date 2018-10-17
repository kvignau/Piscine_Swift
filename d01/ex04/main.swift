// SORTED
var deckSort = Deck(false)

print("All sorted deck -> \n\(deckSort)\n\nDrawed card ->")
var i = 0
while i < 20 {
	let card: Card? = deckSort.draw()
	if (card != nil)
	{
		print(card!)
	}
	i += 1
}

print("\nCard still in the sorted deck ->\n\(deckSort)\n")

print("Card outs -> \n\(deckSort.outs)")

var aceSpade = Card(c:Color.Spade, v:Value.Two)
var kingSpade = Card(c:Color.Spade, v:Value.King)
var fourDiamond = Card(c:Color.Diamond, v:Value.Four)
var aceClub = Card(c:Color.Club, v:Value.Ace)

deckSort.fold(aceSpade)
deckSort.fold(kingSpade)
deckSort.fold(fourDiamond)
deckSort.fold(aceClub)

print("\nFold cards ->\n\(deckSort.discards)")



// SHUFFLED
var deckShuffled = Deck(true)

print("\n\nAll Shuffle deck -> \n\(deckShuffled)\n\nDrawed card ->")
i = 0
while i < 20 {
	let card: Card? = deckShuffled.draw()
	if (card != nil)
	{
		print(card!)
	}
	i += 1
}

print("\nCard still in the Shuffled deck ->\n\(deckShuffled)\n")

print("Card outs -> \n\(deckShuffled.outs)")

deckShuffled.fold(aceSpade)
deckShuffled.fold(kingSpade)
deckShuffled.fold(fourDiamond)
deckShuffled.fold(aceClub)

print("\nFold cards ->\n\(deckShuffled.discards)")
