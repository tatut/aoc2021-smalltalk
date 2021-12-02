Class {
	#name : #DayInput,
	#superclass : #Object,
	#instVars : [
		'input'
	],
	#category : #AoC2021
}

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
  	input := sampleInput 
]
