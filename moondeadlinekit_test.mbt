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
