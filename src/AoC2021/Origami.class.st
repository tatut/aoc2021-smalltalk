Class {
	#name : #Origami,
	#superclass : #Object,
	#instVars : [
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
	^ self class new fromDots: 
		(Set new fillFrom: dots 
			with: [ :d | 
				d x < x 
					ifTrue: [ d ] 
					ifFalse: [ (x - (d x - x)) @ d y ]])
	
]

{ #category : #'as yet unclassified' }
Origami >> foldedAtY: y [
	"answer with new origami that is this origami folded at y"
	^ self class new fromDots: 
		(Set new fillFrom: dots 
			with: [ :d | 
				d y < y 
					ifTrue: [ d ] 
					ifFalse: [ d x @ (y - (d y - y)) ]])
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
