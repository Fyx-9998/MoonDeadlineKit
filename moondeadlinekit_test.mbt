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
