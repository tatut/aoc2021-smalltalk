Class {
	#name : #DayInput,
	#superclass : #Object,
	#instVars : [
		'input'
	],
	#category : #AoC2021
}

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
