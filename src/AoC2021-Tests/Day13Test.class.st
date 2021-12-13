"
A Day13Test is a test class for testing the behavior of Day13
"
Class {
	#name : #Day13Test,
	#superclass : #TestCase,
	#instVars : [
		'day13'
	],
	#category : #'AoC2021-Tests'
}

{ #category : #running }
Day13Test >> setUp [
	super setUp.
	day13 := Day13 new loadSample: '6,10
0,14
9,10
0,3
10,4
4,11
6,0
6,12
4,1
0,13
10,12
3,4
3,0
8,4
1,10
2,14
8,10
9,0

fold along y=7
fold along x=5'.
	
]

{ #category : #tests }
Day13Test >> testPart1 [
	self assert: day13 part1 equals: 17.
]

{ #category : #tests }
Day13Test >> testPart2 [
	self assert: day13 part2 equals: 
'#####
#...#
#...#
#...#
#####
'.
]
