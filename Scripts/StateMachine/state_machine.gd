class_name StateMachine
extends Node

@export var character : CharacterBody2D
@export var animation_tree : AnimationTree
@export var state : State

var states : Dictionary

func _ready() -> void:
	if animation_tree:
		animation_tree.active = true
	for child in get_children():
		if (child is State):
			child.character = character
			states[child.state_name] = child 
			child.transitioned.connect(on_child_transition)
			if animation_tree:
				child.playback = animation_tree.get("parameters/playback")
		else:
			push_warning("Child node" + child.name + " is not a State")
	state = state
	
	
func on_child_transition(current_state:State, new_state_name:String):
	#print(current_state.state_name, "-->", new_state_name)
	var new_state = states[new_state_name]
	# check that new state isn't the same as current
	if current_state != state:
		return
	# check new state exists
	if !new_state:
		return

	if state:
		state.exit()

	new_state.previous_state = current_state # inform on previous state
	new_state.enter() 
	state = new_state
	
func _process(delta:float) -> void:
	if state:
		state.process(delta)
		
func _physics_process( delta:float) -> void:
	if state:
		state.process_physics(delta)
