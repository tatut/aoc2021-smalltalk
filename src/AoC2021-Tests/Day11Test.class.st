"
A Day11Test is a test class for testing the behavior of Day11
"
Class {
	#name : #Day11Test,
	#superclass : #TestCase,
	#instVars : [
		'day11'
	],
	#category : #'AoC2021-Tests'
}

{ #category : #running }
Day11Test >> setUp [
	super setUp.
	day11 := Day11 new loadSample: '5483143223
2745854711
5264556173
6141336146
6357385478
4167524645
2176841721
6882881134
4846848554
5283751526'.

]

{ #category : #tests }
Day11Test >> testPart1 [
 	self assert: day11 part1 equals: 1656.

]

{ #category : #tests }
Day11Test >> testPart2 [
	self assert: day11 part2 equals: 195
]
