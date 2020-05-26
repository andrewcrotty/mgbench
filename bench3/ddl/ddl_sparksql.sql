CREATE TABLE logs (
  log_time     TIMESTAMP,
  device_id    STRING,
  device_name  STRING,
  device_type  STRING,
  device_floor SHORT,
  event_type   STRING,
  event_unit   STRING,
  event_value  FLOAT
);
