///|
test "deadline computes total and remaining budget" {
  let deadline = Deadline::new("api", 1000, 250)
  assert_eq(deadline.total_budget_ms(), 250)
  assert_eq(deadline.remaining_ms(1100), 150)
  assert_false(deadline.expired(1100))
}

///|
test "deadline clamps negative timeout" {
  let deadline = Deadline::new("api", 1000, -1)
  assert_eq(deadline.deadline_ms, 1000)
  assert_true(deadline.expired(1000))
}

///|
test "deadline allocates child budget within remaining time" {
  let parent = Deadline::new("request", 1000, 500)
  let slice = parent.allocate("database", 1200, 400)
  assert_eq(slice.parent_remaining_ms, 300)
  assert_eq(slice.requested_ms, 400)
  assert_eq(slice.granted_ms, 300)
  assert_false(slice.fully_granted())
}

///|
test "split plan divides remaining budget with remainder" {
  let plan = Deadline::new("batch", 0, 100).split(10, 3)
  assert_eq(plan.per_part_ms, 30)
  assert_eq(plan.remainder_ms, 0)
  assert_eq(plan.grant_for_index(0), 30)
}

///|
test "split plan distributes remainder to early indexes" {
  let plan = Deadline::new("batch", 0, 101).split(0, 4)
  assert_eq(plan.per_part_ms, 25)
  assert_eq(plan.remainder_ms, 1)
  assert_eq(plan.grant_for_index(0), 26)
  assert_eq(plan.grant_for_index(1), 25)
}

///|
test "deadline report captures current state" {
  let report = Deadline::new("request", 1000, 200).report(1150)
  assert_eq(report.total_budget_ms, 200)
  assert_eq(report.remaining_ms, 50)
  assert_true(report.healthy())
  assert_false(report.expired)
}

///|
test "deadline guard rejects insufficient budget" {
  let decision = Deadline::new("request", 0, 100).can_start(80, 30)
  assert_false(decision.allowed)
  assert_eq(decision.reason, "insufficient_budget")
  assert_eq(decision.remaining_ms, 20)
}

///|
test "deadline guard allows tasks with enough budget" {
  let decision = Deadline::new("request", 0, 100).can_start(20, 30)
  assert_true(decision.allowed)
  assert_eq(decision.reason, "enough_budget")
}
