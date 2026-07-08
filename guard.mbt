///|
pub(all) struct DeadlineDecision {
  allowed : Bool
  reason : String
  remaining_ms : Int
} derive(Eq, Debug)

///|
pub fn Deadline::can_start(
  self : Deadline,
  now_ms : Int,
  required_ms : Int,
) -> DeadlineDecision {
  let remaining = self.remaining_ms(now_ms)
  let required = if required_ms > 0 { required_ms } else { 0 }
  if self.expired(now_ms) {
    { allowed: false, reason: "deadline_expired", remaining_ms: remaining }
  } else if remaining < required {
    { allowed: false, reason: "insufficient_budget", remaining_ms: remaining }
  } else {
    { allowed: true, reason: "enough_budget", remaining_ms: remaining }
  }
}
