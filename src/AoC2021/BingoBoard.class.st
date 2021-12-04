Class {
	#name : #BingoBoard,
	#superclass : #Object,
	#instVars : [
		'grid',
		'marked'
	],
	#category : #AoC2021
}

{ #category : #accessing }
BingoBoard >> grid: anObject [

	grid := anObject
]

{ #category : #initialization }
BingoBoard >> initialize [
	marked := Set new .
]

{ #category : #game }
BingoBoard >> mark: aNumber [
	marked add: aNumber 
]

{ #category : #game }
BingoBoard >> unmarkedNumbers [
	"return bag of all unmarked numbers"			
	| s |
	s := Bag new.
	grid do: [ :r | r do: [ :n | (marked includes: n) ifFalse: [ s add: n ] ] ].
	^ s
]

{ #category : #game }
BingoBoard >> winner [
	"returns boolean if this board is a winning board"
	| r c |	
	r := #(1 2 3 4 5) select: [ :x | self winningRow:  x ].
	c := #(1 2 3 4 5) select: [ :x | self winningCol: x ].
	^ r isNotEmpty | c isNotEmpty
]

{ #category : #game }
BingoBoard >> winningCol: c [
	"returns boolean if the given col is a winning one"
	 ^ (#(1 2 3 4 5) 
		  collect: [ :r | marked includes: ((grid at: r) at: c) ] 
		  thenSelect: [ :x | x ]) size = 5
		
]

{ #category : #game }
BingoBoard >> winningRow: r [
	"returns boolean if the given row is a winning row"
	 ^ (#(1 2 3 4 5) 
		  collect: [ :c | marked includes: ((grid at: r) at: c) ] 
		  thenSelect: [ :x | x ]) size = 5
		

]
