"
A Day14Test is a test class for testing the behavior of Day14
"
Class {
	#name : #Day14Test,
	#superclass : #TestCase,
	#instVars : [
		'day14'
	],
	#category : #'AoC2021-Tests'
}

{ #category : #running }
Day14Test >> setUp [
	super setUp.
	day14 := Day14 new loadSample: 
'NNCB

CH -> B
HH -> N
CB -> H
NH -> C
HB -> C
HC -> B
HN -> C
NN -> C
BH -> H
NC -> B
NB -> B
BN -> B
BB -> N
BC -> B
CC -> N
CN -> C'.

]

{ #category : #tests }
Day14Test >> testPart1 [
	self assert: day14 part1 equals: 1588.
	
]

{ #category : #tests }
Day14Test >> testPart2 [ 
	self assert: day14 part2 equals: 2188189693529.
]
