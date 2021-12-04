"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestAoC2021,
	#superclass : #PackageManifest,
	#category : #'AoC2021-Manifest'
}

{ #category : #'code-critics' }
ManifestAoC2021 class >> ruleCollectionProtocolRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#BingoBoard #unmarkedNumbers #false)) #'2021-12-04T13:36:51.200612+02:00') )
]
