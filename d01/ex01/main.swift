let card1 = Card(c : Color.Spade, v : Value.Ace)
print(card1)
let card2 = Card(c : Color.Diamond, v: Value.Two)
print(card2)
print(card1 == card2)

let card3 = Card(c : Color.Heart, v : Value.Ten)
let card4 = Card(c : Color.Spade, v : Value.Nine)
let card5 = Card(c : Color.Heart, v : Value.Ten)
print(card3.description)
print(card4.description)
print(card3 == card4)
print(card3 == card5)

let i: Int = 3
print(card3.isEqual(i))
