Class {
	#name : #Day16Packet,
	#superclass : #Object,
	#instVars : [
		'version',
		'type',
		'lengthType',
		'subPackets',
		'literal'
	],
	#category : #AoC2021
}

{ #category : #'as yet unclassified' }
Day16Packet >> eval [
	"answer with the evaluated value of this packet"
	| args |
	args := subPackets collect: [ :s | s eval ].
	
	"sum packet"
	type = 0 ifTrue: [ ^ args sum ].
	
	"product packet"
	type = 1 ifTrue: [ ^ args inject: 1 into: [ :acc :v | acc * v ] ].
	
	"min and max packet"
	type = 2 ifTrue: [ ^ args min  ].
	type = 3 ifTrue: [ ^ args max ].
	
	"literal "
	type = 4 ifTrue: [ ^ literal ].
	
	"greater and less than and equal"
	type = 5 ifTrue: [ ^ (args first > args second) ifTrue: [ 1 ] ifFalse: [ 0 ] ].	
	type = 6 ifTrue: [ ^ (args first < args second) ifTrue: [ 1 ] ifFalse: [ 0 ] ].
 	type = 7 ifTrue: [ ^ (args first = args second) ifTrue: [ 1 ] ifFalse: [ 0 ] ].
	^ #unrecognized
	
]

{ #category : #'instance creation' }
Day16Packet >> fromStream: stream [
	"read packet from stream"
	subPackets := OrderedCollection new.
	version := self readBitNumber: stream bits: 3.
	type := self readBitNumber: stream bits: 3.
	type = 4 
		ifTrue: [ literal := self readLiteral: stream ]
		ifFalse: [  
 			lengthType := stream next.
			lengthType = $0 
			ifTrue: [ 
				| subPacketBits at | 
				"read packets until enough bits have been read"
				subPacketBits := self readBitNumber: stream bits: 15. 
				at := stream position.
				[ stream position < (at + subPacketBits) ] whileTrue: [ 
					subPackets add: (self class new fromStream: stream).
				]]
			ifFalse: [ 
 				(self readBitNumber: stream bits: 11) timesRepeat: [
				  subPackets add: (self class new fromStream: stream)
 			]]].
	^ self
	
]

{ #category : #accessing }
Day16Packet >> lengthType [

	^ lengthType
]

{ #category : #accessing }
Day16Packet >> lengthType: anObject [

	lengthType := anObject
]

{ #category : #accessing }
Day16Packet >> literal [

	^ literal
]

{ #category : #accessing }
Day16Packet >> literal: anObject [

	literal := anObject
]

{ #category : #'as yet unclassified' }
Day16Packet >> read3BitNumber: stream [
	^ (String streamContents: [ :out | 
		out nextPutAll: '2r0'.
		3 timesRepeat: [ out nextPut: stream next ] ]) asNumber 
]

{ #category : #'as yet unclassified' }
Day16Packet >> readBitNumber: stream bits: n [
	^ (String streamContents: [ :out | 
		out nextPutAll: '2r'.
		n timesRepeat: [ out nextPut: stream next ] ]) asNumber 
]

{ #category : #'as yet unclassified' }
Day16Packet >> readLiteral: stream [
	^ (String streamContents: [ :out |
		| done |
		out nextPutAll: '2r'.
		done := false.
		[ done ] whileFalse: [ 
			| bits |
			bits := stream next: 5.
			out nextPutAll: bits allButFirst .
			bits first = $0 ifTrue: [ done := true ]
		]
	]) asNumber 
]

{ #category : #accessing }
Day16Packet >> subPackets [

	^ subPackets
]

{ #category : #accessing }
Day16Packet >> subPackets: anObject [

	subPackets := anObject
]

{ #category : #accessing }
Day16Packet >> type [

	^ type
]

{ #category : #accessing }
Day16Packet >> type: anObject [

	type := anObject
]

{ #category : #accessing }
Day16Packet >> version [

	^ version
]

{ #category : #accessing }
Day16Packet >> version: anObject [

	version := anObject
]

{ #category : #visiting }
Day16Packet >> visit: aVisitorBlock [
	"visit this packet and all sub packets with the given block"
	aVisitorBlock value: self.
	subPackets do: [ :sp | sp visit: aVisitorBlock  ]
]
