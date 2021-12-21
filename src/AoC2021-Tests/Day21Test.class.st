"
A Day21Test is a test class for testing the behavior of Day21
"
Class {
	#name : #Day21Test,
	#superclass : #TestCase,
	#category : #'AoC2021-Tests'
}

{ #category : #running }
Day21Test >> setUp [
	super setUp.
	self executionEnvironment maxTimeForTest: 25 seconds 
	"Put here a common initialization logic for tests"
]

{ #category : #tests }
Day21Test >> testPart1 [
	self assert: (Day21 new part1: 4 and: 8) equals: 739785.
]

{ #category : #tests }
Day21Test >> testPart2 [
	self assert: (Day21 new part2: 4 and: 8) equals: 444356092776315.
]
