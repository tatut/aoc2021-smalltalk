Class {
	#name : #Day4,
	#superclass : #DayInput,
	#instVars : [
		'numbers',
		'boards'
	],
	#category : #AoC2021
}

{ #category : #'instance creation' }
Day4 >> fromInput [
	"initialize bingo numbers and boards from input lines"
	| nums |
	"first line is comma separated list of numbers"
	nums := (input first splitOn: $,) collect: [:x | x asNumber ].
	numbers := BingoNumbers new numbers: nums.
	
	"rest are lines representing boards as 5x5 grids"
	
	boards := ((input asOrderedCollection removeFirst; removeFirst; yourself) splitOn: #('')) collect: [ :lines |
		BingoBoard new grid: (lines collect: [ :line | (line splitOn: Character space) select: [ :x | x isNotEmpty ] thenCollect: [ :x | x asNumber ] ])
	].
   
]

{ #category : #solutions }
Day4 >> part1 [
	| winner n w |
	winner := [ | winners |
		winners := boards select: [ :b | b winner ].
		winners isEmpty ifTrue: [ nil ] ifFalse: [  winners first ]].
	
	"draw new numbers until a winner is found"
	[ winner value ] whileNil: [ 
		n := numbers nextNumber .
		boards do: [ :b | b mark: n ].	
	].
	
	Transcript show: winner value unmarkedNumbers asString,' is winning board unmarked ',n asString,' is last num';cr.
	"get winning board's unmarked numbers and multiple by last num"
	w := winner value. 
	^ w unmarkedNumbers sum * n
]

{ #category : #solutions }
Day4 >> part2 [
	| notWonYet winners n w |
	
	winners := [ (boards select: [ :b | b winner ]) asSet ].
	notWonYet := Set withAll: boards.
	
	"draw new numbers until the last winner is found"
	[ notWonYet size > 1 ] whileTrue: [ 
		n := numbers nextNumber .
		boards do: [ :b | b mark: n ].
		notWonYet := notWonYet difference: winners value.	
	].
	w := notWonYet asArray first. "last winner"
	
	"draw numbers until last winner wins"
	[ w winner ] whileFalse: [ 
		n := numbers nextNumber.
		w mark: n.
	 ].
	
	"get last winning board's unmarked numbers and multiple by last num"	 
	^ w unmarkedNumbers sum * n
]
