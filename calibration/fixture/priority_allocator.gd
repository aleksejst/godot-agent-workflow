extends RefCounted
## EXP-03 implementation module for the priority allocator.
##
## Deliberate fixture stub: syntactically valid but behaviorally
## incomplete. It returns an empty typed array for every input so the
## protected runner can be exercised in its intended failing state.
## The allocation algorithm itself is intentionally NOT implemented here
## (see experiments/exp_03/SPEC.md).


func allocate(supply: int, requests: Array[int]) -> Array[int]:
	# TODO(EXP-03): satisfy requests in priority order from supply, without
	# exceeding supply or mutating the requests argument.
	var empty_allocations: Array[int] = []
	return empty_allocations
