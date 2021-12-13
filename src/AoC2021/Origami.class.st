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

{ #category : #converting }
Origami >> asString [
	^ String streamContents: [ :out | 
		0 to: height do: [ :y |
			0 to: width do: [ :x |
				out nextPut: ((dots includes: x@y) ifTrue: [ $# ] ifFalse: [ $. ]).
			].
			out nextPut: Character cr. ]]
]

{ #category : #accessing }
Origami >> dots [

	^ dots
]

{ #category : #'instance creation' }
Origami >> foldedAtX: x [
	"answer with new origami that is this origami folded at x"
	^ self class new fromDots: 
		(Set new fillFrom: dots 
			with: [ :d | 
				d x < x 
					ifTrue: [ d ] 
					ifFalse: [ (x - (d x - x)) @ d y ]])
	
]

{ #category : #'instance creation' }
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
