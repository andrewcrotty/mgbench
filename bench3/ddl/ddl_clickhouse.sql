CREATE TABLE logs (
  log_time     DateTime,
  log_time_ms  UInt16,
  device_id    FixedString(15),
  device_name  String,
  device_type  String,
  device_floor UInt8,
  event_type   String,
  event_unit   FixedString(1),
  event_value  Nullable(Float32)
)
ENGINE = MergeTree()
ORDER BY log_time;
