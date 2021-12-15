"
A Day15Test is a test class for testing the behavior of Day15
"
Class {
	#name : #Day15Test,
	#superclass : #TestCase,
	#instVars : [
		'day15'
	],
	#category : #'AoC2021-Tests'
}

{ #category : #running }
Day15Test >> setUp [
	super setUp.
	day15 := Day15 new loadSample: '1163751742
1381373672
2136511328
3694931569
7463417111
1319128137
1359912421
3125421639
1293138521
2311944581'.
]

{ #category : #tests }
Day15Test >> testPart1 [
	self assert: day15 part1 equals: 40.
]

{ #category : #tests }
Day15Test >> testPart2 [
	self assert: day15 part2 equals: 315.
]
