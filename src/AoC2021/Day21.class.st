Class {
	#name : #Day21,
	#superclass : #DayInput,
	#category : #AoC2021
}

{ #category : #solutions }
Day21 >> part1: initialPos1 and: initialPos2 [  
 | dice pos1 score1 pos2 score2 |
 dice := Day21DeterministicDice new.

  "starting pos (-1 to wrap) "
  pos1 := initialPos1 - 1.
  pos2 := initialPos2 - 1.   

  score1 := 0. score2 := 0.
  [ true ] whileTrue: [ 
	 pos1 := (pos1 + dice roll + dice roll + dice roll) % 10.
	 score1 := score1 + pos1 + 1.
	 score1 >= 1000 ifTrue: [ ^ score2 * dice rolledCount  ].
	 
	 pos2 := (pos2 + dice roll + dice roll + dice roll) % 10.
	 score2 := score2 + pos2 + 1.
	 score2 >= 1000 ifTrue: [ ^ score1 * dice rolledCount ].
  ]
]

{ #category : #solutions }
Day21 >> part2: initialPos1 and: initialPos2 [  
  | p1wins p2wins games playRound |
 p1wins := 0.
 p2wins := 0.
 games := LinkedList new.

 games add: (Day21Game new 
		pos1: (initialPos1 - 1);
		pos2: (initialPos2 - 1)).
		
 playRound := [ :g :s :count | 
		| ng |
		ng := g copy.
		ng turn = 1 
			ifTrue: [  
				ng turn: 2.
				ng appears: (ng appears * count).
				ng pos1: (ng pos1 + s) % 10.
				ng score1: (ng score1 + ng pos1 + 1).
				ng score1 >= 21 
					ifTrue: [ p1wins := p1wins + ng appears ]
					ifFalse: [ games add: ng ] ]
			ifFalse: [ 
				ng turn: 1.
				ng appears: (ng appears * count).
				ng pos2: (ng pos2 + s) % 10.
				ng score2: (ng score2 + ng pos2 + 1).
				ng score2 >= 21 
					ifTrue: [ p2wins := p2wins + ng appears ]
					ifFalse: [ games add: ng ] ]].
				
 [ games isNotEmpty ] whileTrue: [ 
	"while there are unplayed game universes"
	| g |
	g := games removeFirst .
	"play this game for all possible outcomes and their counts"
	playRound value: g value: 3 value: 1.
	playRound value: g value: 4 value: 3.
	playRound value: g value: 5 value: 6.
	playRound value: g value: 6 value: 7.
	playRound value: g value: 7 value: 6.
	playRound value: g value: 8 value: 3.
	playRound value: g value: 9 value: 1.
 ].

  ^ p1wins max: p2wins

]
