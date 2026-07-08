///|
pub(all) struct SplitPlan {
  parent_name : String
  parts : Int
  per_part_ms : Int
  remainder_ms : Int
} derive(Eq, Debug)

///|
pub fn Deadline::split(
  self : Deadline,
  now_ms : Int,
  parts : Int,
) -> SplitPlan {
  let safe_parts = if parts > 0 { parts } else { 1 }
  let remaining = self.remaining_ms(now_ms)
  {
    parent_name: self.name,
    parts: safe_parts,
    per_part_ms: remaining / safe_parts,
    remainder_ms: remaining % safe_parts,
  }
}

///|
pub fn SplitPlan::grant_for_index(
  self : SplitPlan,
  index : Int,
) -> Int {
  if index < self.remainder_ms {
    self.per_part_ms + 1
  } else {
    self.per_part_ms
  }
}
