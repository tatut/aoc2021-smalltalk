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
	pairs := CountDictionary new.
	(input at:1) overlappingPairsDo: [ :a :b | 
		pairs at: (a asString,b asString) incrementBy: 1
	].
	
	steps timesRepeat: [  
		"go through each pair, if it matches rule, increase left/right pairs"
		pairs := CountDictionary from: pairs with: [ :d :pair :count |
			| insert |
		 	insert := (rules at: pair) asString.
			d at: (pair first asString, insert asString) incrementBy: count;
			  at: (insert asString, pair second asString) incrementBy: count ]].

   "element counts"
	counts := (CountDictionary from: pairs with: [:cs :pair :count |
	  cs at: pair first incrementBy: count;
 		  at: pair second incrementBy: count ]) counts.
	^ ( (counts last / 2) ceiling - (counts first / 2) ceiling)
]
