Class {
	#name : #Day13,
	#superclass : #DayInput,
	#category : #AoC2021
}

{ #category : #parsing }
Day13 class >> parseInput: lines [
	"answer with array of point and folds"
	| splits pointsLines foldsLines |
	splits := lines splitOn: #('').
	pointsLines := splits at: 1.
	foldsLines := splits at: 2.
	^ { pointsLines collect: [ :line |
			| p |
			p := (line splitOn: $,) collect: [ :n | n asNumber ].
			(p at: 1) @ (p at: 2)
	    ].
	 foldsLines  }
	
]

{ #category : #solutions }
Day13 >> part1 [
	| o fold pos |
	o := Origami new fromDots: (input at: 1).
	fold := (input at: 2) first.
	pos := (fold allButFirst: 13) asNumber.
	o := ('fold along x=*' match: fold)
		     ifTrue: [ o foldedAtX: pos ]
		     ifFalse: [ o foldedAtY: pos ].
	^ o dots size
]

{ #category : #solutions }
Day13 >> part2 [
	| o |
	o := Origami new fromDots: (input at: 1).
	(input at: 2) do: [ :fold |
		| pos |
		pos := (fold allButFirst: 13) asNumber.
		o := ('fold along x=*' match: fold)
			     ifTrue: [ o foldedAtX: pos ]
		 	    ifFalse: [ o foldedAtY: pos ].
	].
	^ o asString 

]
