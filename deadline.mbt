///|
pub(all) struct Deadline {
  name : String
  start_ms : Int
  deadline_ms : Int
} derive(Eq, Debug)

///|
pub fn Deadline::new(
  name : String,
  start_ms : Int,
  timeout_ms : Int,
) -> Deadline {
  let budget = if timeout_ms > 0 { timeout_ms } else { 0 }
  { name, start_ms, deadline_ms: start_ms + budget }
}

///|
pub fn Deadline::from_absolute(
  name : String,
  start_ms : Int,
  deadline_ms : Int,
) -> Deadline {
  { name, start_ms, deadline_ms: if deadline_ms >= start_ms { deadline_ms } else { start_ms } }
}

///|
pub fn Deadline::total_budget_ms(self : Deadline) -> Int {
  self.deadline_ms - self.start_ms
}

///|
pub fn Deadline::remaining_ms(self : Deadline, now_ms : Int) -> Int {
  let remaining = self.deadline_ms - now_ms
  if remaining > 0 { remaining } else { 0 }
}

///|
pub fn Deadline::expired(self : Deadline, now_ms : Int) -> Bool {
  now_ms >= self.deadline_ms
}
