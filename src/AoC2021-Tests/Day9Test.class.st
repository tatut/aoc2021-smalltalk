"
A Day9Test is a test class for testing the behavior of Day9
"
Class {
	#name : #Day9Test,
	#superclass : #TestCase,
	#category : #'AoC2021-Tests'
}

{ #category : #tests }
Day9Test >> testWithSample [
	| d |
	d := Day9 new loadSample: 
'2199943210
3987894921
9856789892
8767896789
9899965678'.
	self assert: d part1 equals: 15.
	self assert: d part2 equals: 1134.
	
	
]
