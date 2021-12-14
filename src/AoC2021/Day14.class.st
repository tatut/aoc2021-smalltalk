Class {
	#name : #Day14,
	#superclass : #DayInput,
	#category : #AoC2021
}

{ #category : #parsing }
Day14 class >> parseInput: lines [
	"parse template and pair insertion rules"
	^ { 
	 lines first .
	 (lines allButFirst: 2) collect: [ :line |
	   | split | 
	   split := line splitOn: ' -> '.
	   (split at:1) -> (split at:2)
	 ]  as: Dictionary.
	}
]

{ #category : #solutions }
Day14 >> part1 [
	^ self partWithSteps: 10
]

{ #category : #solutions }
Day14 >> part2 [
	^ self partWithSteps: 40
]

{ #category : #solutions }
Day14 >> partWithSteps: steps [
	| pairs counts rules |
	rules := input at: 2.
	pairs := Dictionary new.
	(input at:1) overlappingPairsDo: [ :a :b | 
		| p |
		p := a asString,b asString.
		pairs at: p update: [ :c | c + 1 ] initial: 1].
	
	steps timesRepeat: [  
		| newPairs |
		
		"go through each pair, if it matches rule, increase left/right pairs"
		newPairs := Dictionary new. 
		pairs keysAndValuesDo: [ :pair :count |
		  | insert |
		  insert := rules at: pair ifAbsent: nil.
		  insert
		   ifNil: [ newPairs at: pair put: (pairs at: pair) ] 
		   ifNotNil: [ 
			| left right |
			left := pair first asString, insert asString.
			right := insert asString, pair second asString.
			newPairs at: left update: [ :c | c + count ] initial: count.
			newPairs at: right update: [ :c | c + count ] initial: count. 
		  ].
	     pairs := newPairs. 
		]
	].

   "element counts"
	counts := Dictionary new.
	pairs keysAndValuesDo: [ :pair :count |
	  counts at: pair first update: [ :c | c + count ] initial: count.
	  counts at: pair second update: [ :c | c + count ] initial: count.
	
	].
	counts := SortedCollection withAll: counts values.
	^ ( (counts last / 2) ceiling - (counts first / 2) ceiling)
]
