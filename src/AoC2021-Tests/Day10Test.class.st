"
A Day10Test is a test class for testing the behavior of Day10
"
Class {
	#name : #Day10Test,
	#superclass : #TestCase,
	#category : #'AoC2021-Tests'
}

{ #category : #tests }
Day10Test >> testWithSample [
	| d |
	d := Day10 new loadSample: '[({(<(())[]>[[{[]{<()<>>
[(()[<>])]({[<{<<[]>>(
{([(<{}[<>[]}>{[]{[(<()>
(((({<>}<{<{<>}{[]{[]{}
[[<[([]))<([[{}[[()]]]
[{[{({}]{}}([{[{{{}}([]
{<[[]]>}<{[{[{[]{()[[[]
[<(<(<(<{}))><([]([]()
<{([([[(<>()){}]>(<<{{
<{([{{}}[<[[[<>{}]]]>[]]'.
	self assert: d part1 equals: 26397.
	self assert: d part2 equals: 288957.

]
