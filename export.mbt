///|
pub fn DeadlineReport::to_json(self : DeadlineReport) -> String {
  "{\"name\":\"\{escape_json(self.name)}\",\"now_ms\":\{self.now_ms},\"start_ms\":\{self.start_ms},\"deadline_ms\":\{self.deadline_ms},\"total_budget_ms\":\{self.total_budget_ms},\"remaining_ms\":\{self.remaining_ms},\"expired\":\{self.expired}}"
}

///|
pub fn DeadlineDecision::to_json(self : DeadlineDecision) -> String {
  "{\"allowed\":\{self.allowed},\"reason\":\"\{escape_json(self.reason)}\",\"remaining_ms\":\{self.remaining_ms}}"
}

///|
pub fn BudgetSlice::to_json(self : BudgetSlice) -> String {
  "{\"name\":\"\{escape_json(self.name)}\",\"requested_ms\":\{self.requested_ms},\"granted_ms\":\{self.granted_ms},\"parent_remaining_ms\":\{self.parent_remaining_ms}}"
}

///|
fn escape_json(text : String) -> String {
  let buf = StringBuilder(size_hint=text.length() + 8)
  for i = 0; i < text.length(); i = i + 1 {
    let ch = text[i]
    if ch == '"' {
      buf.write_string("\\\"")
    } else if ch == '\\' {
      buf.write_string("\\\\")
    } else {
      buf.write_string(text[i:i + 1].to_owned())
    }
  }
  buf.to_string()
}
