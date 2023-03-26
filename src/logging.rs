pub use log::*;

use chrono::prelude::*;

struct Logger;

impl Log for Logger {
  fn enabled(&self, _metadata: &log::Metadata) -> bool {
    true
  }

  fn log(&self, record: &log::Record) {
    println!("{} - {}: {}",
      Local::now().format("%Y-%m-%d %H:%M:%S"),
      record.level(),
      record.args()
    );
  }

  fn flush(&self) {}
}

pub fn setup() {
  log::set_logger(&Logger).unwrap();
  log::set_max_level(log::LevelFilter::Info);
}