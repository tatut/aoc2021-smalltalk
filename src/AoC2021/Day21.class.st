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
  | p1wins p2wins games roll3Sums |
 p1wins := 0.
 p2wins := 0.
 games := OrderedCollection new.

 "different sums of 3 rolls, and how many times they appear"
 roll3Sums := Dictionary new 
	add: 3 -> 1;
	add: 4 -> 3;
	add: 5 -> 6;
	add: 6 -> 7;
	add: 7 -> 6;
	add: 8 -> 3;
	add: 9 -> 1; yourself.

 games add: (Day21Game new 
		pos1: (initialPos1 - 1);
		pos2: (initialPos2 - 1)).
		
 [ games isNotEmpty ] whileTrue: [ 
	"while there are unplayed game universes"
	| g |
	g := games removeFirst .
	"play this game for"
	roll3Sums keysAndValuesDo: [ :s :count | 
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
					ifFalse: [ games add: ng ] ]
	]].

  ^ p1wins max: p2wins

]
