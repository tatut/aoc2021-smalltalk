"
A Day12Test is a test class for testing the behavior of Day12
"
Class {
	#name : #Day12Test,
	#superclass : #TestCase,
	#instVars : [
		'day12'
	],
	#category : #'AoC2021-Tests'
}

{ #category : #running }
Day12Test >> setUp [
	super setUp.
	day12 := Day12 new loadSample: 'dc-end
HN-start
start-kj
dc-start
dc-HN
LN-dc
HN-end
kj-sa
kj-HN
kj-dc'.
	
]

{ #category : #solutions }
Day12Test >> testPart1 [
	self assert: day12 part1 equals: 19.
]

{ #category : #test }
Day12Test >> testPart2 [
	self assert: day12 part2 equals: 103.
]
