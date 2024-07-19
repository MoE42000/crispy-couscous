class_name State
extends Node

signal transitioned

@export
var state_name : String
@export 
var animation_name : String

var character : CharacterBody2D
var playback : AnimationNodeStateMachinePlayback

var previous_state : State # tracking whichw as previous state

func enter() -> void:
	pass

func exit() -> void:
	pass

func process(_delta:float) -> void:
	pass
	
func process_physics(_delta:float) -> void:
	pass
	

