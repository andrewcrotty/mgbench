CREATE TABLE logs (
  log_time     DateTime64,
  device_id    FixedString(15),
  device_name  LowCardinality(String),
  device_type  LowCardinality(String),
  device_floor UInt8,
  event_type   LowCardinality(String),
  event_unit   FixedString(1),
  event_value  Nullable(Float32)
)
ENGINE = MergeTree()
ORDER BY (event_type, log_time);
