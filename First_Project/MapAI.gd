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
	var next_base = get_next_capturable_base()
	assign_next_capturable_base_to_units(next_base)


func get_next_capturable_base():
	# Asume base capture start order is first
	var list_of_bases = range(capturable_bases.size())
	if base_capture_start_order == BaseCaptureStartOrder.LAST:
		list_of_bases = range(capturable_bases.size() - 1, -1, -1)
		
	for i in list_of_bases:
		var base: CapturableBase = capturable_bases[i]
		if team.team == base.team.team:
			return base.global_position
	return null

func assign_next_capturable_base_to_units(base_location: Vector2):
	if base_location == null or base_location == Vector2.ZERO:
		return
		
	for unit in get_children():
		if unit == team:
			continue
		# assign capturable base target here
