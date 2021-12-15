Class {
	#name : #AStar,
	#superclass : #Object,
	#category : #AoC2021
}

{ #category : #testing }
AStar class >> isAbstract [
		
	^ self == AStar
]

{ #category : #accessing }
AStar >> edgeWeightFrom: fromNode to: toNode [
	"Answer with the weight score of the edge from fromNode to toNode."
	SubclassResponsibility signal: 'Subclass must implement edge weight calculation'
]

{ #category : #calculating }
AStar >> findPathFrom: start to: goal [
	"find shortest path from start to goal"
	| openSet cameFrom gScore fScore gs fs |
	
	cameFrom := Dictionary new.
	gScore := Dictionary new.
	gScore at: start put: 0.
	fScore := Dictionary new.
	fScore at: start put: (self heuristicFrom: start to: goal).
	
	gs := [ :p | gScore at: p ifAbsent: SmallInteger maxVal ].
	fs := [ :p | fScore at: p ifAbsent: SmallInteger maxVal ].
	
	openSet := SortedCollection sortUsing: [ :a :b | (fs value: a) < (fs value: b) ].
	openSet add: start. 
	
	[ openSet isEmpty ] whileFalse: [ 
		| current |
		current := openSet removeFirst.
		current = goal 
			ifTrue: [
				| path prev |
				path := OrderedCollection with: current.
			   prev := cameFrom at: current ifAbsent: nil.
			   [ prev isNotNil ] whileTrue: [ 
					path addFirst: prev.
					prev := cameFrom at: prev ifAbsent: nil.
				].
      			^ path ]
			ifFalse: [ 
				self neighbors: current do: [ :neighbor |
					| tentative_gScore |
					tentative_gScore := (gs value: current) + (self edgeWeightFrom: current to: neighbor).
					tentative_gScore < (gs value: neighbor)
						ifTrue: [ 
							 "This path to neighbor is better than any previous one. Record it!"
		                cameFrom at: neighbor put: current.
		                gScore at: neighbor put: tentative_gScore.
		                fScore at: neighbor put: tentative_gScore + (self heuristicFrom: neighbor to: goal).
		                (openSet includes: neighbor) ifFalse: [ openSet add: neighbor ].
						] 
				].
			].
	].
	NotFound signal: 'No path found.'


]

{ #category : #accessing }
AStar >> heuristicFrom: fromNode to: toNode [
	"Answer with the heuristic score to reach from fromNode to toNode."
	SubclassResponsibility signal: 'Subclass must implement heuristic score calculation'
]

{ #category : #accessing }
AStar >> neighbors: aNode do: aBlock [
	"execute aBlock for each neighbor aNode"
	SubclassResponsibility signal: 'Subclass must implement neighbors' 
]
