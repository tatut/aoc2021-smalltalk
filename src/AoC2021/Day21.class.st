Class {
	#name : #Day21,
	#superclass : #DayInput,
	#category : #AoC2021
}

{ #category : #solutions }
Day21 >> part1 [ 
 | dice pos1 score1 pos2 score2 |
 dice := Day21DeterministicDice new.

  "starting pos (-1 to wrap) "
  pos1 := 4 - 1.
  pos2 := 8 - 1.   

  score1 := 0. score2 := 0.
  [ true ] whileTrue: [ 
	 Transcript show: 'P1 ', pos1 asString, ' => '.
	 pos1 := (pos1 + dice roll + dice roll + dice roll) % 10.
	 score1 := score1 + pos1 + 1.
	 Transcript show: pos1 asString, ' SCORE: ', score1 asString;cr.
	 
	score1 >= 1000 ifTrue: [ ^ score2 * dice rolledCount  ].
	 
	 Transcript show: 'P2 ', pos2 asString, ' => '.
	 pos2 := (pos2 + dice roll + dice roll + dice roll) % 10.
	 score2 := score2 + pos2 + 1.
	 Transcript show: pos2 asString, ' SCORE: ', score2 asString.

	score2 >= 1000 ifTrue: [ ^ score1 * dice rolledCount ].
  ]
]

{ #category : #solutions }
Day21 >> part1: initialPos1 and: initialPos2 [  
 | dice pos1 score1 pos2 score2 |
 dice := Day21DeterministicDice new.

  "starting pos (-1 to wrap) "
  pos1 := initialPos1 - 1.
  pos2 := initialPos2 - 1.   

  score1 := 0. score2 := 0.
  [ true ] whileTrue: [ 
	 Transcript show: 'P1 ', pos1 asString, ' => '.
	 pos1 := (pos1 + dice roll + dice roll + dice roll) % 10.
	 score1 := score1 + pos1 + 1.
	 Transcript show: pos1 asString, ' SCORE: ', score1 asString;cr.
	 
	score1 >= 1000 ifTrue: [ ^ score2 * dice rolledCount  ].
	 
	 Transcript show: 'P2 ', pos2 asString, ' => '.
	 pos2 := (pos2 + dice roll + dice roll + dice roll) % 10.
	 score2 := score2 + pos2 + 1.
	 Transcript show: pos2 asString, ' SCORE: ', score2 asString.

	score2 >= 1000 ifTrue: [ ^ score1 * dice rolledCount ].
  ]
]

{ #category : #solutions }
Day21 >> part2: initialPos1 and: initialPos2 [  
  | p1wins p2wins games roll3Sums |
 p1wins := 0.
 p2wins := 0.
 games := OrderedCollection new.

 "all possible outcomes of rolling d3 three times"
 "pending: can we count duplicates in game state to optimize?"
 roll3Sums := #(3 4 5 4 5 6 5 6 7 4 5 6 5 6 7 6 7 8 5 6 7 6 7 8 7 8 9).

 games add: (Day21Game new 
		pos1: (initialPos1 - 1);
		pos2: (initialPos2 - 1)).
		
 [ games isNotEmpty ] whileTrue: [ 
	"while there are unplayed game universes"
	| g |
	g := games removeFirst .
	"play this game for"
	roll3Sums do: [ :s | 
		| ng |
		ng := g copy.
		ng turn = 1 
			ifTrue: [  
				ng turn: 2.
				ng pos1: (ng pos1 + s) % 10.
				ng score1: (ng score1 + ng pos1 + 1).
				ng score1 >= 21 
					ifTrue: [ p1wins := p1wins + 1 ]
					ifFalse: [ games add: ng ] ]
			ifFalse: [ 
				ng turn: 1.
				ng pos2: (ng pos2 + s) % 10.
				ng score2: (ng score2 + ng pos2 + 1).
				ng score2 >= 21 
					ifTrue: [ p2wins := p2wins + 1 ]
					ifFalse: [ games add: ng ] ]
	]].
  Transcript show: 'P1 wins: ', p1wins asString, ' P2 wins: ', p2wins asString;cr.
  ^ p1wins min: p2wins

]
