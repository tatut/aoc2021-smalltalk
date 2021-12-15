Class {
	#name : #DayInput,
	#superclass : #Object,
	#instVars : [
		'input'
	],
	#category : #AoC2021
}

{ #category : #parsing }
DayInput class >> parseLinesToArray2D: lines [
	| input |
	input := Array2D rows: (lines size) columns: (lines first size).
	1 to: (lines size) do: [ :y |
		| line |
		line := lines at: y.
		1 to: (line size) do: [ :x |
			input at: y at: x put: (line at: x) asString asNumber 
		]	
	].
	^ input
]

{ #category : #actions }
DayInput >> load: inputFile [ 
   "load input file and call self #parseInput"
	input := self class parseInput: (FileLocator home / 'projects' / 'aoc2021' / inputFile) contents lines.
]

{ #category : #initialization }
DayInput >> load: inputFile using: parseLines [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
			
	| lines |
	lines := (FileLocator home / 'projects' / 'aoc2021' / inputFile) contents lines.
	input := (parseLines value: lines)
]

{ #category : #initialization }
DayInput >> loadSample: sampleInput [
  	input := self class parseInput: sampleInput lines 
]
