///|
fn main {
  let deadline = @deadline.Deadline::new("demo-request", 1000, 250)
  println("MoonDeadlineKit demo")
  println("remaining_ms: \{deadline.remaining_ms(1120)}")
  println("expired: \{deadline.expired(1300)}")
}
