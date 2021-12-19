Class {
	#name : #Day19Point,
	#superclass : #Object,
	#instVars : [
		'coords'
	],
	#category : #AoC2021
}

{ #category : #'as yet unclassified' }
Day19Point class >> allOrientations [ 
 ^ 
#( ( 1  1  1  1 2 3) 
   ( 1  1  1  2 3 1) 
   ( 1  1  1  3 1 2) 
   ( 1  1 -1  3 2 1)
   ( 1  1 -1  2 1 3)
   ( 1  1 -1  1 3 2)
   ( 1 -1 -1  1 2 3)
   ( 1 -1 -1  2 3 1)
   ( 1 -1 -1  3 1 2)
   ( 1 -1  1  3 2 1)
   ( 1 -1  1  2 1 3)
   ( 1 -1  1  1 3 2)
   (-1  1 -1  1 2 3)
   (-1  1 -1  2 3 1)
   (-1  1 -1  3 1 2)
   (-1  1  1  3 2 1)
   (-1  1  1  2 1 3)
   (-1  1  1  1 3 2)
   (-1 -1  1  1 2 3)
   (-1 -1  1  2 3 1)
   (-1 -1  1  3 1 2)
   (-1 -1 -1  3 2 1)
   (-1 -1 -1  2 1 3)
   (-1 -1 -1  1 3 2) )


]

{ #category : #arithmetic }
Day19Point >> + aPoint [ 
	"return new point by adding aPoint to this point"
	| p1 p2 |
	p1 := coords.
	p2 := aPoint coords.
	^ self class new coords: 
		{ (p1 at: 1) + (p2 at: 1) .
		  (p1 at: 2) + (p2 at: 2) .
		  (p1 at: 3) + (p2 at: 3) }
]

{ #category : #arithmetic }
Day19Point >> - aPoint [ 
	"return new point by substracting aPoint from this point"
	| p1 p2 |
	p1 := coords.
	p2 := aPoint coords.
	^ self class new coords: 
		{ (p1 at: 1) - (p2 at: 1) .
		  (p1 at: 2) - (p2 at: 2) .
		  (p1 at: 3) - (p2 at: 3) }
]

{ #category : #comparing }
Day19Point >> = anObject [

	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ coords = anObject coords
]

{ #category : #converting }
Day19Point >> asString [ 
	^ '<', (',' join: coords), '>'

]

{ #category : #accessing }
Day19Point >> coords [

	^ coords
]

{ #category : #accessing }
Day19Point >> coords: anObject [

	coords := anObject
]

{ #category : #'distance functions' }
Day19Point >> distanceTo: p [
	^ ((coords at: 1) -( p coords at: 1)) abs + 
	  ((coords at: 2) - (p coords at: 2)) abs + 
	  ((coords at: 3) - (p coords at: 3)) abs
]

{ #category : #comparing }
Day19Point >> hash [

	"Answer an integer value that is related to the identity of the receiver."

	^ coords hash
]

{ #category : #'as yet unclassified' }
Day19Point >> inOrientation: o [
	"return new version of point in orientation"
	^ self class new coords: 
		{ (o at: 1) * (coords at: (o at: 4)) .
		  (o at: 2) * (coords at: (o at: 5)) .
		  (o at: 3) * (coords at: (o at: 6)) }
]
