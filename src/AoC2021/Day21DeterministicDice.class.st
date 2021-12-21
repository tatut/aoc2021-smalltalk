Class {
	#name : #Day21DeterministicDice,
	#superclass : #Object,
	#instVars : [
		'nextVal',
		'rolledCount'
	],
	#category : #AoC2021
}

{ #category : #initialization }
Day21DeterministicDice >> initialize [ 
   rolledCount := 0.
	nextVal := 1.

]

{ #category : #'as yet unclassified' }
Day21DeterministicDice >> roll [ 
  "roll the dice"
  | v |
  v := nextVal.
  nextVal := nextVal + 1.
  nextVal > 100 ifTrue: [ nextVal := 1 ].
  rolledCount := rolledCount + 1.
  ^ v

]

{ #category : #accessing }
Day21DeterministicDice >> rolledCount [

	^ rolledCount
]
