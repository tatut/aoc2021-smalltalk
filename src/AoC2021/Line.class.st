Class {
	#name : #Line,
	#superclass : #Object,
	#instVars : [
		'start',
		'end'
	],
	#category : #AoC2021
}

{ #category : #'instance creation' }
Line class >> from: startPoint to: endPoint [
 ^ self new start: startPoint; end: endPoint; yourself
]

{ #category : #accessing }
Line >> end [

	^ end
]

{ #category : #accessing }
Line >> end: anObject [

	end := anObject
]

{ #category : #testing }
Line >> isHorizontal [
	^ start y = end y
]

{ #category : #testing }
Line >> isVertical [ 
  ^ start x = end x
]

{ #category : #accessing }
Line >> points [
	"return all points covered by the line as a set"
	| ps d at |
	at := start.
	ps := Set with: at.
	d := (end x - start x) sign @ (end y - start y) sign. 
	[ at ~= end ] whileTrue: [
	  at := at + d.
	  ps add: at.
	].

	"answer with the points set"
	^ ps 
]

{ #category : #accessing }
Line >> start [

	^ start
]

{ #category : #accessing }
Line >> start: anObject [

	start := anObject
]
