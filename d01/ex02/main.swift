print("All Spades -> \(Deck.allSpades)\n")
print("All Club -> \(Deck.allClub)\n")
print("All Heart -> \(Deck.allHeart)\n")
print("All Diamond -> \(Deck.allDiamond)\n")

for elem in Deck.allCards
{
	print("\(elem.value), \(elem.color)")
}