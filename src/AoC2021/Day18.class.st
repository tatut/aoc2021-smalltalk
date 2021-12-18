Class {
	#name : #Day18,
	#superclass : #DayInput,
	#category : #AoC2021
}

{ #category : #parsing }
Day18 class >> parseInput: lines [
	^ lines collect: [:line | SnailfishNumber fromString: line]
]

{ #category : #solutions }
Day18 >> part1 [
	^ (input reduce: [ :left :right | (left + right) reduce ]) magnitude
]

{ #category : #enumerating }
Day18 >> reduce: initialNum [
	| s d done |
	s := ReadWriteStream on: initialNum .
	d := 0.
	done := false.
	
	[ done ] whileFalse: [ 
		| ch |
		s position: 1. "go to start"
		
		ch := s next.
		"if found [ we are going deeper"
		ch = $[ 
			ifTrue: [ d := d + 1. ]
			ifFalse: [ 
				ch = $] ifTrue: [ d := d - 1. ]
				ifFalse: [ 
					Transcript show: 'found numbers at', s position asString;cr.
					"parse numbers" 	
				]].
		
	
		].

]

{ #category : #enumerating }
Day18 >> reduceNum: initialNum [
	| s d done |
	s := ReadWriteStream on: initialNum .
	d := 0.
	done := false.
	
	"s position: 0."
	[ done ] whileFalse: [ 
		| ch |
		
		ch := s next.
		"if found [ we are going deeper"
		ch = $[ 
			ifTrue: [ d := d + 1. ]
			ifFalse: [ 
				ch = $] ifTrue: [ d := d - 1. ]
				ifFalse: [ 
					Transcript show: 'found numbers at', s position asString;cr.
					"parse numbers" 	
				]].
		
	
		].

]
