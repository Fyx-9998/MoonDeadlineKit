///|
fn main {
  let deadline = @deadline.Deadline::new("demo-request", 1000, 250)
  let report = deadline.report(1120)
  let decision = deadline.can_start(1120, 80)
  let child = deadline.allocate("database", 1120, 120)
  println("MoonDeadlineKit demo")
  println(report.to_json())
  println(decision.to_json())
  println(child.to_json())
}
