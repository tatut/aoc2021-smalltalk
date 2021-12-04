Class {
	#name : #BingoNumbers,
	#superclass : #Object,
	#instVars : [
		'numbers',
		'index'
	],
	#category : #AoC2021
}

{ #category : #initialization }
BingoNumbers >> initialize [
	index := 1.
]

{ #category : #accessing }
BingoNumbers >> nextNumber [
	"return the next bingo number from the sequencec"			
	| n |
	n := numbers at: index.
	index := index + 1.
	^ n

]

{ #category : #accessing }
BingoNumbers >> numbers [

	^ numbers
]

{ #category : #accessing }
BingoNumbers >> numbers: anObject [

	numbers := anObject
]
