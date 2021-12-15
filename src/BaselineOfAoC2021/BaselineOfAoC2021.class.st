Class {
	#name : #BaselineOfAoC2021,
	#superclass : #BaselineOf,
	#category : #BaselineOfAoC2021
}

{ #category : #baselines }
BaselineOfAoC2021 >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [
			"Packages"
			spec 
				package: 'AoC2021';
				package: 'AoC2021-Tests' with: [ spec requires: #('AoC2021') ]
		]
]

{ #category : #accessing }
BaselineOfAoC2021 >> projectClass [
	^ MetacelloCypressBaselineProject
]
