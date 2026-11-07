extends SceneTree
## EXP-03 protected headless test runner.
##
## Runs the fixed acceptance cases from experiments/exp_03/SPEC.md against
## the implementation at res://experiments/exp_03/priority_allocator.gd.
## All checks are explicit; printed success text alone is never treated as
## evidence that the assertions executed.
##
## The implementation is instantiated through a preload and called
## directly, with no scene setup and no class_name registration. Its fixed
## typed interface (supply: int, requests: Array[int]) -> Array[int]
## makes dynamic result-type machinery unnecessary.

const AllocatorScript := preload(
	"res://experiments/exp_03/priority_allocator.gd"
)

const PASS_TOKEN: String = "EXP03_PASS"

var _allocator: AllocatorScript = AllocatorScript.new()
var _passed_cases: int = 0
var _failed_cases: int = 0
var _failed_checks: int = 0
var _fixture_errors: int = 0


func _init() -> void:
	if _allocator == null:
		_report_fixture_error(
			"preloaded priority_allocator.gd did not instantiate"
		)
		_finish()
		return
	if not _allocator.has_method("allocate"):
		_report_fixture_error(
			"instantiated allocator does not expose an allocate() method"
		)
		_finish()
		return

	_check_case("Empty", 5, [], [])
	_check_case("Zero supply", 0, [3, 2], [0, 0])
	_check_case("Exact supply", 5, [3, 2], [3, 2])
	_check_case("Short supply", 4, [3, 2], [3, 1])
	_check_case("First request exhausts supply", 2, [3, 2], [2, 0])
	_check_case("Excess supply", 10, [3, 2], [3, 2])
	_check_case("Zero-valued requests", 3, [0, 2, 0, 4], [0, 2, 0, 1])
	_check_case("All zero", 3, [0, 0], [0, 0])
	_finish()


func _check_case(
	case_name: String,
	supply: int,
	requests: Array[int],
	expected: Array[int]
) -> void:
	var issues: PackedStringArray = PackedStringArray()

	# Snapshot of the requests argument: it bounds the per-request checks
	# even if the callee mutates its argument, and it detects that mutation.
	var requests_copy: Array[int] = []
	for request: int in requests:
		requests_copy.append(request)

	var result: Array[int] = _allocator.allocate(supply, requests)

	var size_matches: bool = result.size() == expected.size()
	if not size_matches:
		issues.append(
			"expected %d allocations, got %d"
			% [expected.size(), result.size()]
		)

	if size_matches:
		var total_used: int = 0
		var index: int = 0
		for allocation: int in result:
			total_used += allocation
			if allocation < 0:
				issues.append(
					"allocation %d is negative (%d)" % [index, allocation]
				)
			if allocation > requests_copy[index]:
				issues.append(
					"allocation %d (%d) exceeds its request (%d)"
					% [index, allocation, requests_copy[index]]
				)
			if allocation != expected[index]:
				issues.append(
					"allocation %d is %d, expected %d"
					% [index, allocation, expected[index]]
				)
			index += 1
		if total_used > supply:
			issues.append(
				"total allocation %d exceeds supply %d"
				% [total_used, supply]
			)

	if requests != requests_copy:
		issues.append("allocate() mutated its requests argument")

	_conclude_case(case_name, issues)


func _conclude_case(case_name: String, issues: PackedStringArray) -> void:
	if issues.is_empty():
		_passed_cases += 1
		print("case '%s': pass" % case_name)
	else:
		_failed_cases += 1
		for issue: String in issues:
			_failed_checks += 1
			print("EXP03_FAIL [%s] %s" % [case_name, issue])


func _report_fixture_error(message: String) -> void:
	_fixture_errors += 1
	print("EXP03_FAIL [fixture] %s" % message)


func _finish() -> void:
	print(
		"EXP03 summary: %d case(s) passed, %d case(s) failed, %d failing check(s), %d fixture error(s)"
		% [_passed_cases, _failed_cases, _failed_checks, _fixture_errors]
	)
	if _failed_cases == 0 and _fixture_errors == 0:
		print(PASS_TOKEN)
		quit(0)
	else:
		quit(1)
