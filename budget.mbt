///|
pub(all) struct BudgetSlice {
  name : String
  requested_ms : Int
  granted_ms : Int
  parent_remaining_ms : Int
} derive(Eq, Debug)

///|
pub fn Deadline::allocate(
  self : Deadline,
  child_name : String,
  now_ms : Int,
  requested_ms : Int,
) -> BudgetSlice {
  let remaining = self.remaining_ms(now_ms)
  let requested = if requested_ms > 0 { requested_ms } else { 0 }
  {
    name: child_name,
    requested_ms: requested,
    granted_ms: if requested < remaining { requested } else { remaining },
    parent_remaining_ms: remaining,
  }
}

///|
pub fn BudgetSlice::deadline(self : BudgetSlice, start_ms : Int) -> Deadline {
  Deadline::new(self.name, start_ms, self.granted_ms)
}

///|
pub fn BudgetSlice::fully_granted(self : BudgetSlice) -> Bool {
  self.granted_ms >= self.requested_ms
}
