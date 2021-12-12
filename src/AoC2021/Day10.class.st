Class {
	#name : #Day10,
	#superclass : #DayInput,
	#category : #AoC2021
}

{ #category : #'as yet unclassified' }
Day10 class >> openerFor: aChar [
	aChar = $) ifTrue: [ ^ $( ].
	aChar = $} ifTrue: [ ^ ${ ].
	aChar = $] ifTrue: [ ^ $[ ].
	aChar = $> ifTrue: [ ^ $< ].
	
]

{ #category : #parsing }
Day10 class >> parseInput: lines [
	^ lines

]

{ #category : #accessing }
Day10 >> firstIllegalCharacter: line [
	| stack |
	stack := OrderedCollection new.
	line do: [ :ch | 
 		"opener character, push to stack"
		('({[<' includes: ch) 
			ifTrue: [ stack add: ch ]
			ifFalse: [ 
				| opener |
				"closer, pop stack and check opener is correct"
				opener := stack removeLast .
				opener = (self class openerFor: ch) ifFalse: [ ^ ch ]].			
 	].
	^ nil
]

{ #category : #solutions }
Day10 >> part1 [
	"take first illegal character on each corrupt line and count the score"
	| errors |
	"counts of wrong characters"
	errors := Dictionary new
		add: $) -> 0;
		add: $] -> 0;
		add: $} -> 0;
		add: $> -> 0; yourself.
	
	input do: [ :line | 
		| err |
 		err := self firstIllegalCharacter: line.
 		err ifNotNil: [ errors at: err update:  [ :n | n + 1 ] ]
	].

	^ ( ((errors at: $)) * 3) +
	    ((errors at: $]) * 57) +
		 ((errors at: $}) * 1197) +
		 ((errors at: $>) * 25137) )
		
]

{ #category : #solutions }
Day10 >> part2 [
	"discard corrupts, repair incompletes"
	| scores |
	scores := input 
		"select only incomplete lines by reusing part1 utility"
		select: [ :line | (self firstIllegalCharacter: line) isNil ]
	 	thenCollect: [ :line |
 			| stack score |
			stack := OrderedCollection new.
 			line do: [ :ch |
				stack isEmpty
 					ifTrue: [ stack add: ch ]
					ifFalse: [ (stack last = (self class openerFor: ch))
						ifTrue: [  stack removeLast ]
						ifFalse: [ stack add: ch ]]
			 ].
			score := 0.
			stack reversed do: [ :ch | 
				score := score * 5.
				ch = $( ifTrue: [ score := score + 1 ].
				ch = $[ ifTrue: [ score := score + 2 ].
				ch = ${ ifTrue: [ score := score + 3 ].
				ch = $< ifTrue: [ score := score + 4 ].	
			].
			score
		].
	scores sort.
	^ scores at: ((scores size / 2) ceiling)


]
