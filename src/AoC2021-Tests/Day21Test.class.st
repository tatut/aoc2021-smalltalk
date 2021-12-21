"
A Day21Test is a test class for testing the behavior of Day21
"
Class {
	#name : #Day21Test,
	#superclass : #TestCase,
	#category : #'AoC2021-Tests'
}

{ #category : #tests }
Day21Test >> testPart1 [
	self assert: (Day21 new part1: 4 and: 8) equals: 739785.
]
