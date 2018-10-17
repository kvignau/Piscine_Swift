let shuffled = Deck.allCards.shuffle()
for elem in shuffled
{
	print("\(elem.value), \(elem.color)")
}