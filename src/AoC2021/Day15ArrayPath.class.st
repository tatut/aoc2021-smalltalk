Class {
	#name : #Day15ArrayPath,
	#superclass : #AStar,
	#instVars : [
		'input'
	],
	#category : #AoC2021
}

{ #category : #'as yet unclassified' }
Day15ArrayPath class >> withInput: input [
	^ self new input: input; yourself.
]

{ #category : #accessing }
Day15ArrayPath >> edgeWeightFrom: a to: b [
	^ input at: b y at: b x

]

{ #category : #accessing }
Day15ArrayPath >> heuristicFrom: fromNode to: toNode [
	^ fromNode distanceTo: toNode 
]

{ #category : #accessing }
Day15ArrayPath >> input: anArray2D [
	input := anArray2D
]

{ #category : #accessing }
Day15ArrayPath >> neighbors: aNode do: aBlock [
	aNode fourNeighbors do: [ :n |
		(n x between: 1 and: input columnCount) & (n y between: 1 and: input rowCount)
			ifTrue: [ aBlock value: n ]
 	]
]
