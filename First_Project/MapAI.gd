extends Node2D

enum BaseCaptureStartOrder {
	FIRST,
	LAST
}

export (BaseCaptureStartOrder) var base_capture_start_order

var capturable_bases: Array = []

onready var team = $Team

func initialize(capturable_bases: Array):
	self.capturable_bases = capturable_bases
	for base in capturable_bases:
		base.connect("base_captured", self, "handle_base_captured")
	check_for_capturable_bases()

func handle_base_captured(_new_team: int):
	check_for_capturable_bases()

func check_for_capturable_bases():
	var next_base = get_next_capturable_base()
	if next_base != null and next_base != Vector2.ZERO:
		assign_next_capturable_base_to_units(next_base)

func get_next_capturable_base():
	# Asume base capture start order is first
	var list_of_bases = range(capturable_bases.size())
	if base_capture_start_order == BaseCaptureStartOrder.LAST:
		list_of_bases = range(capturable_bases.size() - 1, -1, -1)
		
	for i in list_of_bases:
		var base: CapturableBase = capturable_bases[i]
		if team.team != base.team.team:
			print("Assigning team %d to capture base %d" % [team.team, i])
			return base.global_position
	return null

func assign_next_capturable_base_to_units(base_location: Vector2):
	for unit in get_children():
		if unit == team:
			continue
		
		# assign capturable base target here
		var ai: AI = unit.ai
		ai.next_base = base_location
		ai.set_state(AI.State.ADVANCE)
