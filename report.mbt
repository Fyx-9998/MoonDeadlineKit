///|
pub(all) struct DeadlineReport {
  name : String
  now_ms : Int
  start_ms : Int
  deadline_ms : Int
  total_budget_ms : Int
  remaining_ms : Int
  expired : Bool
} derive(Eq, Debug)

///|
pub fn Deadline::report(self : Deadline, now_ms : Int) -> DeadlineReport {
  {
    name: self.name,
    now_ms,
    start_ms: self.start_ms,
    deadline_ms: self.deadline_ms,
    total_budget_ms: self.total_budget_ms(),
    remaining_ms: self.remaining_ms(now_ms),
    expired: self.expired(now_ms),
  }
}

///|
pub fn DeadlineReport::healthy(self : DeadlineReport) -> Bool {
  !self.expired
}
