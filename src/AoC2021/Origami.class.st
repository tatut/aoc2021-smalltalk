Class {
	#name : #Origami,
	#superclass : #Object,
	#instVars : [
		'grid',
		'width',
		'height',
		'dots'
	],
	#category : #AoC2021
}

{ #category : #accessing }
Origami >> dots [

	^ dots
]

{ #category : #'as yet unclassified' }
Origami >> foldedAtX: x [
	"answer with new origami that is this origami folded at x"
	| newDots |
	newDots := Set withAll: (dots select: [ :d | d x < x ]).
	(dots select: [ :d | d x > x ]) do: [ :d |
 		newDots add: (x - (d x - x)) @ d y
	].
	^ Origami new fromDots: newDots	
]

{ #category : #'as yet unclassified' }
Origami >> foldedAtY: y [
	"answer with new origami that is this origami folded at y"
	| newDots |
	newDots := Set withAll: (dots select: [ :d | d y < y ]).
	(dots select: [ :d | d y > y ]) do: [ :d |
 		newDots add: d x @ (y - (d y - y))
	].
	^ Origami new fromDots: newDots	
]

{ #category : #'instance creation' }
Origami >> fromDots: theDots [
	"read from given dots. answers with self"
	width := (theDots collect: #x) max .
	height := (theDots collect: #y) max .
	dots := Set withAll: theDots .
	^ self
]

{ #category : #printing }
Origami >> printOrigami [
	0 to: height do: [ :y |
		Transcript cr.
		0 to: width do: [ :x |
			Transcript show: ((dots includes: x@y) ifTrue: [ '#' ] ifFalse: [ '.' ]).
		]
	].
]
